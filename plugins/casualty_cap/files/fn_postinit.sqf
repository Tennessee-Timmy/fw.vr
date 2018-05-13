/* ----------------------------------------------------------------------------
Function: casualty_cap_fnc_postInit

Description:
	Runs the loop on the server and does everything casualty cap does

Parameters:
	none
Returns:
	nothing
Examples:
	call casualty_cap_fnc_postInit;
	Runs in the postInit from functions.cpp

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// server only
if !(isServer) exitWith {};

[] spawn {

	// wait until game has actually started
	sleep 10;

	// tiny local function, used twice, it ends the mission
	private _endMission = {
		private _side = _this;
		private _wavesLeft = false;
		call {
			private _nil = {
				private _wavesVar = format ["respawn_wave_count_%1",_x];
				private _availableWaves = missionNamespace getVariable [_wavesVar,0];
				if ("respawn_wave" in mission_plugins && {_availableWaves > 0}) exitWith {
					_wavesLeft = true;
					false
				};
				false
			} count _side;

		};
		if (_wavesLeft) exitWith {};

		private _winSides = [west,east,resistance,civilian] - _side;
		missionNamespace setVariable ["mission_tasks_winSides",_winSides,true];
		call tasks_fnc_endSrv;
		casualty_cap_stop = false;
	};

	// wait until there's atleast 1 player
	waitUntil {!(PLAYERLIST isEqualTo [])};

	// loop
	while {isNil "casualty_cap_stop"} do {

		// getvariables
		private _sides = missionNamespace getVariable ["mission_casualty_cap_sides",CASUALTY_CAP_SETTING_SIDES];
		private _empty = missionNamespace getVariable ["mission_casualty_cap_empty",CASUALTY_CAP_SETTING_EMPTY];
		private _percentage = missionNamespace getVariable ["mission_casualty_cap_limit",CASUALTY_CAP_PARAM_LIMIT];

		// if percentage is 0, it's disabled for 10 seconds
		if (_percentage isEqualTo 0) then {
			sleep 10;
		} else {
			_percentage = _percentage * 10;

			// loop through sides
			private _nil = {
				private _checkSide = _x;

				// checkside needs to be an array
				if !(_checkSide isEqualType []) then {
					_checkSide = [_checkSide];
				};

				// Get all players on the side
				private _players = (allPlayers - (entities "HeadlessClient_F")) select {(_x call respawn_fnc_getSetUnitSide) in _checkSide};

				// Check if empty should end it and if it's empty
				if (_empty && {_players isEqualTo []}) exitWith {
					_checkSide call _endMission;
				};

				// Get count of alive and dead people
				private _playerCount = count _players;
				private _deadCount = {_x call respawn_fnc_deadCheck} count _players;

				// Check the percentage of dead dudes
				if (_playerCount > 0 && {(100/_playerCount)*_deadCount >= _percentage}) exitWith {
					_checkSide call _endMission;
				};

				false
			} count _sides;
		};

		// small sleep, because it might be the difference of win/lose
		sleep 0.1;
	};

};