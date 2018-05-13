/* ----------------------------------------------------------------------------
Function: respawn_round_fnc_loopSrv

Description:
	MUST be spawned
	The timer that runs on the server
	'disable_round_serverTimeLoop' to disable

Parameters:
	none
Returns:
	nothing
Examples:
	[] spawn respawn_round_fnc_loopSrv;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
if !(isServer) exitWith {};
// Code begins

private _first = true;

// wait for game to start
sleep 1;
// loop
while {isNil "disable_round_loopSrv"} do {

	//--- Update variables every round

	// times
	private _switchTime = missionNamespace getVariable ["mission_respawn_round_switchTime",RESPAWN_ROUND_SETTING_SWITCHTIME];
	private _prepTime = missionNamespace getVariable ["mission_respawn_round_prepTime",RESPAWN_ROUND_PARAM_PREPTIME];
	private _startTime = missionNamespace getVariable ["mission_respawn_round_startTime",RESPAWN_ROUND_SETTING_STARTTIME];
	private _roundTime = missionNamespace getVariable ["mission_respawn_round_time",RESPAWN_ROUND_PARAM_TIME];

	// rounds
	private _playedRounds = missionNamespace getVariable ["mission_respawn_rounds_played",0];
	private _roundCount = missionNamespace getVariable ["mission_respawn_round_count",RESPAWN_ROUND_PARAM_COUNT];
	private _roundCountWin = missionNamespace getVariable ["p_respawn_round_count_win",RESPAWN_ROUND_PARAM_COUNT_WIN];

	// location
	private _locSwitch = missionNamespace getVariable ["mission_respawn_round_locSwitch",RESPAWN_ROUND_SETTING_LOCSWITCH];

	// update sides
	private _activeSides = call respawn_round_fnc_update;

	// local variables needed in this scope
	private _validSides = [];
	private _leadSides = [];
	private _leadUnits = [];
	private _leadScore = 0;
	private _leadAlive = 0;
	private _deadArr = [] call respawn_fnc_getDeadArray;


	//--- Check for winner

	// loop through sides to see if we have a side that's won yet or if only 1 side left
	private _nil = {
		_x params ['_sideName',['_sideUnits',[]],['_sideData',[]]];
		call {

			// filter sideunits
			_sideUnits = _sideUnits select {
				!isNil '_x' && !isNull _x
			};

			// add to valid sides if the unit array is not empty
			if !(_sideUnits isEqualTo []) then {
				_validSides pushBack _x;
			};

			// get side data to check wins
			_sideData params ['_sideNum',['_sideWins',0]];

			// compare sidewins to current leader score
			if (_sideWins >= _leadScore) then {

				// get the amount of alive players for side
				private _sideAlive = _sideUnits - _deadArr;
				private _sideAliveCount = count _sideAlive;

				// if this side has more alive than previous leaders
				if (_sideAliveCount >= _leadAlive) then {

					// delete other leadersides
					if (_sideAliveCount > _leadAlive) then {
						_leadSides = [];
						_leadUnits = [];
						_leadAlive = _sideAliveCount;
					};

					// add this side to leaders, update lead units and update lead score
					_leadSides pushBack _x;
					_leadUnits append _sideUnits;
					_leadScore = _sideWins;
				};
			};
		};
		false
	} count _activeSides;

	// Check if leader score is higher or equal then required win count OR we played roundcount number of rounds
	if (((_leadScore >= _roundCountWin) || (_playedRounds isEqualTo _roundCount) || ((count _validSides) <= 1)) && true) exitWith {

		// update winner list
		missionNamespace setVariable ['mission_tasks_winPlayers',_leadUnits,true];

		// end mission
		call tasks_fnc_endSrv;

		missionNamespace setVariable ['mission_respawn_round_stage','end',true];
	};


	//--- Round start
	// update locations if it's time to switch them
	if ((_playedRounds mod _locSwitch) isEqualTo 0) then {
		call respawn_round_fnc_updateLoc;
	};


	//--- first time loading time
	// if first time running, wait until start time has passed (also let everyone know of time until start)
	if (_first) then {
		_first = false;
		missionNamespace setVariable ['mission_respawn_round_stage','preStart',true];
		for '_i' from _startTime to 0 step -1 do {
			sleep 1;
			missionNamespace setVariable ['mission_respawn_round_toStart',_i,true];
			private _toStart = missionNamespace getVariable ['mission_respawn_round_toStart',_i];
			if (_toStart <= 0) exitWith {};
		};

	// if it's not first time run the round delay instead
	} else {
		if (((_playedRounds mod _locSwitch) isEqualTo 0)) then {
			missionNamespace setVariable ['mission_respawn_round_stage','preRoundSwitch',true];
			for '_i' from _switchTime to 0 step -1 do {
				sleep 1;
				missionNamespace setVariable ['mission_respawn_round_toStart',_i,true];
				private _toStart = missionNamespace getVariable ['mission_respawn_round_toStart',_i];
				if (_toStart <= 0) exitWith {};
			};
		};

	};
	_activeSides = call respawn_round_fnc_update;

	// delete the toStart (not needed anymore)
	missionNamespace setVariable ['mission_respawn_round_toStart',nil,true];


	//--- Prepare the round
	call respawn_round_fnc_prepRoundSrv;
	missionNamespace setVariable ['mission_respawn_round_stage','prep',true];

	// wait until preperation ends
	for '_i' from _prepTime to 0 step -1 do {
		sleep 1;
		missionNamespace setVariable ['mission_respawn_round_toPrep',_i,true];
		private _toPrep = missionNamespace getVariable ['mission_respawn_round_toPrep',_i];
		if (_toPrep <= 0) exitWith {};
	};

	// delete variable
	missionNamespace setVariable ['mission_respawn_round_toPrep',nil,true];

	// start the round
	call respawn_round_fnc_startRoundSrv;
	missionNamespace setVariable ['mission_respawn_round_stage','live',true];

	private _roundOver = false;
	private _roundLosers = 0;
	private _activeCount = (count _validSides);

	private _timeOutCodeRan = false;
	private '_winner';

	// wait until round ends
	for '_i' from (_roundTime*60) to -6 step -1 do {
		private _roundSides = + _validSides;
		missionNamespace setVariable ['mission_respawn_round_toRoundEnd',_i,true];
		private _toRoundEnd = _i;

		if (_roundSides isEqualTo []) exitWith {};

		// check conditions
		private _nil = {
			_x params ['_sideName',['_sideUnits',[]],'_sideData'];
			if (isNil '_sideData') then {
				_sideData = [];
				_x set [2,_sideData];
			};
			private _sideWins = _sideData param [1,0];
			private _sideLocNr = _sideData param [2,0];

			// round condition code
			private _condCodeFile = "plugins\respawn_round\code\cond.sqf";

			private _roundWinCode = {};
			private _roundLoseCode = {};
			private _roundTimeOutCode = {};

			if (_condCodeFile call mission_fnc_checkFile) then {
				// load the file
				call compile preprocessFileLineNumbers _condCodeFile;
				if (_i <= 0 && !_timeOutCodeRan) then {
					missionNamespace setVariable ['mission_respawn_round_msg',"Time's up!",true];

					// timeout code
					call _roundTimeOutCode;
					_timeOutCodeRan = true;
				};

				// call so I can use exitWith so it will only fail or only succeed
				call {
					// check lose code
					if ((call _roundLoseCode) isEqualTo true) exitWith {
						_roundSides deleteAt _forEachIndex;
						_roundLosers = _roundLosers + 1;
					};

					//check condition for winning and check the amount of losers (if all other teams lost, we win)
					if (((call _roundWinCode) isEqualTo true) || (_roundLosers isEqualTo (_activeCount - 1))) exitWith {
						missionNamespace setVariable ['mission_respawn_round_roundWinner',_sideName,true];
						[_sideName,'wins',1] call respawn_round_fnc_updateSideData;
						_sideData set [1,(_sideWins + 1)];
						_roundOver = true;
						_winner = _sideName;
					};
				};
			};
			if (_roundOver) exitWith {};
		} forEach _roundSides;
		if (_roundOver) exitWith {};
		sleep 1;

		private _addTime = missionNamespace getVariable 'mission_respawn_round_timeAdd';
		if (!isNil '_addTime') then {
			_i = _i + _addTime;
			missionNamespace setVariable ['mission_respawn_round_timeAdd',nil];
		};
	};

	if (isNil '_winner') then {
		missionNamespace setVariable ['mission_respawn_round_roundWinner','tie',true];
	};

	missionNamespace setVariable ['mission_respawn_rounds_played',(_playedRounds + 1),true];

	// End the round
	call respawn_round_fnc_endRoundSrv;

	// time after round ends before new round:
	sleep 5;
};