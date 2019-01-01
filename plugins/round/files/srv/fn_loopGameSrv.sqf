/* ----------------------------------------------------------------------------
Function: round_fnc_loopGameSrv

Description:
	The game loop for the server (as opposed to round loop)

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

private _ao = missionNamespace getVariable ["mission_round_aoList",ROUND_SETTING_AOLIST];
_ao call round_fnc_markersSrv;


// wait for game to start
uiSleep 5;

// save ao (makes sure AO works)
ten_start2 = diag_tickTime;
call round_fnc_saveAO;
ten_start3 = diag_tickTime;

// wait for game to start
sleep 1;
// delete ALL ao
[true,'',true] spawn round_fnc_loadAO;

private _sides = + (missionNamespace getVariable ["mission_round_sides",ROUND_SETTING_SIDES]);
private _mode = missionNamespace getVariable ["mission_round_mode",ROUND_PARAM_MODE];
private _gamesToPlay = 100;

//--- Mode selection
call {

	//--- GAMEMODE SPECIFIC
	if (_mode isEqualTo 0) then {
		 missionNamespace getVariable ['mission_round_disableVoting',true];
		_gamesToPlay = 1;
	};

	if (_mode isEqualTo 1) then {
		 missionNamespace getVariable ['mission_round_disableVoting',true];
		_gamesToPlay = 1;
	};
	if (_mode isEqualTo 2) then {
		 missionNamespace getVariable ['mission_round_disableVoting',true];
		 _gamesToPlay = 3;
	};
	if (_mode isEqualTo 3) then {
		 missionNamespace getVariable ['mission_round_disableVoting',true];
		 _gamesToPlay = 3;
	};

	//--- SHARED
	if (_mode in [0,2]) then {
		 missionNamespace getVariable ['mission_round_disableVoting',true];
	};

};


// loop
while {isNil "disable_round_loopGameSrv"} do {

	//--- Update variables every game
	private _gamesPlayed = missionNamespace getVariable ["mission_round_gamesPlayed",0];

	// srv code
	private _srvCodeFile = format ["plugins\round\code\srv.sqf",''];

	private _onGameStartCodeSrv = {};
	if (_srvCodeFile call mission_fnc_checkFile) then {
		// load the file
		call compile preprocessFileLineNumbers _srvCodeFile;
		call _onGameStartCodeSrv;
	};

	ten_start5 = diag_tickTime;

	//--- choose location
	// Check if new map should be voted for:
	if (
	    (_first && _mode in [1,3,5]) ||			// first time loading AND mode is votable
	    (_mode in [4,5]) ||						// OR contionious play
	    (_mode isEqualTo 3 && _gamesPlayed < 3)	// OR 3 voted maps mode AND less than 3 games played
	) then {

		// todo this might be expensive
		if (!_first) then {

			// respawn everyone
			[] call respawn_fnc_respawn;
			sleep 1;

			// reload all AOs
			private _aoList = missionNamespace getVariable ["mission_round_aoList",ROUND_SETTING_AOLIST];
			private _nil = {
				private _aoName = _x param [0,''];

				// todo is this really necessary?
				//[false,_aoName] call round_fnc_loadAO;
				false
			} count _aoList;
		};

		// this will wait for ao to be voted on
		call round_fnc_aoSrv;
		_first = false;
	};

	ten_start6 = diag_tickTime;


	//--- redo round variables etc.
	// delete all sides (namespaces)
	private _sides = missionNamespace getVariable ["mission_round_sides_active",[]];
	{
		if (!isNil '_x' && {!isNull _x}) then {
			deleteVehicle _x;
		};
		false
	} count _sides;
	missionNamespace setVariable ["mission_rounds_played",0,true];
	missionNamespace setVariable ["mission_round_sides_active",[],true];
	missionNamespace setVariable ['mission_round_stage','preStart',true];


	// do the rounds for the first game
	// this will run until the first game(set of rounds) is completed
	call round_fnc_loopSrv;

	sleep 10;

	_gamesPlayed = _gamesPlayed + 1;
	missionNamespace setVariable ["mission_round_gamesPlayed",_gamesPlayed,true];

	if (_gamesPlayed >= _gamesToPlay) then {
		call tasks_fnc_endSrv;
	} else {

		// disable fake end
		true remoteExec ['round_fnc_fakeEnd'];
	};

	// srv code
	private _srvCodeFile = format ["plugins\round\code\srv.sqf",''];

	private _onGameEndCodeSrv = {};
	if (_srvCodeFile call mission_fnc_checkFile) then {
		// load the file
		call compile preprocessFileLineNumbers _srvCodeFile;
		call _onGameEndCodeSrv;
	};
	sleep 20;
};