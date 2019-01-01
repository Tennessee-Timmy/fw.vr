/* ----------------------------------------------------------------------------
Function: round_fnc_loopSrv

Description:
	MUST be spawned
	The timer that runs on the server
	'disable_round_serverTimeLoop' to disable

Parameters:
	none
Returns:
	nothing
Examples:
	[] spawn round_fnc_loopSrv;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
if !(isServer) exitWith {};
// Code begins

private _first = true;

//private _ao = missionNamespace getVariable ["mission_round_aoList",ROUND_SETTING_AOLIST];
//_ao call round_fnc_markersSrv;


// wait for game to start
sleep 1;

// loop
while {isNil "disable_round_loopSrv"} do {
	ten_start4 = diag_tickTime;

	//--- Update variables every round
	// times
	private _switchTime = missionNamespace getVariable ["mission_round_switchTime",ROUND_SETTING_SWITCHTIME];
	private _prepTime = missionNamespace getVariable ["mission_round_prepTime",ROUND_PARAM_PREPTIME];
	private _startTime = missionNamespace getVariable ["mission_round_startTime",ROUND_SETTING_STARTTIME];
	private _roundTime = missionNamespace getVariable ["mission_round_time",ROUND_PARAM_TIME];

	// rounds
	private _playedRounds = missionNamespace getVariable ["mission_rounds_played",0];
	private _roundCount = missionNamespace getVariable ["mission_round_count",ROUND_PARAM_COUNT];
	private _roundCountWin = missionNamespace getVariable ["p_round_count_win",ROUND_PARAM_COUNT_WIN];

	// location
	private _locSwitch = missionNamespace getVariable ["mission_round_locSwitch",ROUND_SETTING_LOCSWITCH];

	// update sides
	private _activeSides = call round_fnc_update;

	// local variables needed in this scope
	private _validSides = [];
	private _leadSides = [];
	private _leadUnits = [];
	private _leadScore = 0;
	private _leadAlive = 0;
	private _deadArr = [] call respawn_fnc_getDeadArray;

	// check game winner
	if (call round_fnc_checkGameWin) exitWith {};

	//--- Round start
	// update locations if it's time to switch them
	// if it's not time to switch team update them *(for setvariable for clients to know what spawn location to use (in case of jip etc.))
	if (_playedRounds > 0 && (_playedRounds mod _locSwitch) isEqualTo 0) then {
		[false] call round_fnc_updateLoc;
	} else {
		[true] call round_fnc_updateLoc;
	};

	//--- SAFETY ON
	// Global safety will be enabled and restriction will be disabled for now
	missionNamespace setVariable ['mission_safe_pause',false,true];
	missionNamespace setVariable ['mission_safe_restrict_pause',true,true];
	[999,false] call safe_fnc_setTime;
	[0,true] call safe_fnc_setTime;

	// global zone
	[true] call safe_fnc_addZone;


	//--- Loaction switch
	// First time nothing will happen
	if (_first) then {
		//_first = false;

	// if it's not first time run the location switch check
	} else {

		if (((_playedRounds mod _locSwitch) isEqualTo 0)) then {
			missionNamespace setVariable ['mission_round_stage','preRoundSwitch',true];
			for '_i' from _switchTime to 0 step -1 do {
				sleep 1;
				missionNamespace setVariable ['mission_round_toStart',_i,true];
				private _toStart = missionNamespace getVariable ['mission_round_toStart',_i];
				if (_toStart <= 0) exitWith {};
			};
		};
	};


	//--- load AO during prestart
	// unused currently todo
	missionNamespace setVariable ['mission_round_ao_loaded',false];

	// load ao (handle saved so it can be checked if it's done yet)
	private _aoLoadHandle = [nil,nil,nil,true] spawn round_fnc_loadAO;
	//private _aoLoadHandle = [] spawn {};

	//--- Prestart
	// lets everyone load in correctly
	// Happens in the loading/staging area
	missionNamespace setVariable ['mission_round_stage','preStart',true];

	// respawn everyone
	[] call respawn_fnc_respawn;

	if (_first) then {
		_first = false;
		_startTime = _startTime max 35;

	};

	// wait for staging/start/loading of level to end
	for '_i' from _startTime to 0 step -1 do {
		sleep 1;
		missionNamespace setVariable ['mission_round_toStart',_i,true];
		private _toStart = missionNamespace getVariable ['mission_round_toStart',_i];
		if (_toStart <= 0 && (isNil '_aoLoadHandle' || {isNull _aoLoadHandle})) exitWith {};
	};

	// respawn everyone (again) JUST IN CASE
	[] call respawn_fnc_respawn;

	_activeSides = call round_fnc_update;

	// delete the toStart (not needed anymore)
	missionNamespace setVariable ['mission_round_toStart',nil,true];

	// change state
	missionNamespace setVariable ['mission_round_stage','prep',true];

	//--- Prepare the round
	call round_fnc_prepRoundSrv;

	sleep 1;

	//--- RESTRICTION ON
	// enable restriction
	[_prepTime,true] call safe_fnc_setTime;
	missionNamespace setVariable ['mission_safe_restrict_pause',false,true];

	// wait until preperation ends
	for '_i' from _prepTime to 0 step -1 do {
		sleep 1;
		missionNamespace setVariable ['mission_round_toPrep',_i,true];
		private _toPrep = missionNamespace getVariable ['mission_round_toPrep',_i];

		// make sure ao is done loading
		if (_toPrep <= 0) exitWith {};
	};

	// delete variable
	missionNamespace setVariable ['mission_round_toPrep',nil,true];

	// start the round
	call round_fnc_startRoundSrv;
	missionNamespace setVariable ['mission_round_stage','live',true];


	//--- SAFETY OFF
	// Global safety will be enabled and restriction will be disabled for now
	missionNamespace setVariable ['mission_safe_pause',true,true];
	missionNamespace setVariable ['mission_safe_restrict_pause',true,true];
	[0,false] call safe_fnc_setTime;
	[0,true] call safe_fnc_setTime;

	// global zone removal
	[true,true] call safe_fnc_addZone;



	// update activsides
	_activeSides = call round_fnc_update;	// todo this was in unscheduled, WHY?!
	_validSides = [];

	// update validSides
	private _nil = {
		private _sideUnits = _x getVariable ['round_sideUnits',[]];
		call {

			// filter sideunits
			_sideUnits = _sideUnits select {
				!isNil '_x' && !isNull _x
			};

			// add to valid sides if the unit array is not empty
			if !(_sideUnits isEqualTo []) then {
				_validSides pushBack _x;
			};

		};
		false
	} count _activeSides;

	private _roundOver = false;
	private _roundLosers = 0;
	private _activeCount = (count _validSides);

	private _timeOutCodeRan = _activeCount;
	private '_winner';
	private _roundSides = + _validSides;

	call round_fnc_checkRoundWin;

	if (isNil '_winner') then {
		missionNamespace setVariable ['mission_round_roundWinner','tie',true];
	};

	missionNamespace setVariable ['mission_rounds_played',(_playedRounds + 1),true];

	missionNamespace setVariable ['mission_round_stage','endRound',true];

	// End the round
	call round_fnc_endRoundSrv;

	// time after round ends before new round:
	sleep 10;
};