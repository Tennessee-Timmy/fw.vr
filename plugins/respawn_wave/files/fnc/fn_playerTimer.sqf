/* ----------------------------------------------------------------------------
Function: respawn_wave_fnc_playerTimer

Description:
	hintSilent's the time until next wave
	Quits if time < 1 seconds or unit_respawn_dead is false
TODO:
	Custom dialog for timer
Parameters:
0:	_unit	- unit that will have the timer (local)
Returns:
	nothing
Examples:
	_unit call respawn_wave_fnc_playerTimer;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_unit"];

// Get unitSide
private _unitSide = _unit call respawn_fnc_getSetUnitSide;

// choose player side based on settings
_unitSide = call {
	if (_unitSide isEqualTo west) then {
		missionNamespace getVariable ['mission_respawn_wave_side_west',RESPAWN_WAVE_SETTING_SIDE_WEST];
	};
	if (_unitSide isEqualTo east) then {
		missionNamespace getVariable ['mission_respawn_wave_side_east',RESPAWN_WAVE_SETTING_SIDE_EAST];
	};
	if (_unitSide isEqualTo resistance) then {
		missionNamespace getVariable ['mission_respawn_wave_side_guer',RESPAWN_WAVE_SETTING_SIDE_GUER];
	};
	if (_unitSide isEqualTo civilian) then {
		missionNamespace getVariable ['mission_respawn_wave_side_civi',RESPAWN_WAVE_SETTING_SIDE_CIVI];
	};

	// default to west
	west
};

// get individual side and override
_unitSide = _unit getVariable ['unit_respawn_wave_side',_unitSide];


// Get wave time for unit side
private _requestedVar = format ["respawn_wave_requested_%1",_unitSide];
private _timeVar = format ["respawn_wave_time_%1",_unitSide];

// Get amount of waves remaining
private _wavesVar = format ["respawn_wave_count_%1",_unitSide];
private _availableWaves = missionNamespace getVariable [_wavesVar,RESPAWN_WAVE_PARAM_COUNT];

// get allowed respawn variable.
private _allowedVar = format ["respawn_wave_allowed_%1",_unitSide];


private _text = format ["Your side has %1 waves remaining",_availableWaves];
[_text,true,7] call respawn_fnc_deadText;

private _lastTime = 0;
private _showWaveAt = 0;

// WaitUntil time is less than 1
waitUntil {

	// Check if player has respawened already
	if (!(_unit getVariable ["unit_respawn_dead",true])) exitWith {true};

	// Check how many waves there are left
	private _availableWaves = missionNamespace getVariable [_wavesVar,RESPAWN_WAVE_PARAM_COUNT];

	if (_availableWaves <= 0) then {

		// if there are no waves, tell the player that there are no waves every 15 seconds
		if (time > _showWaveAt) then {
			private _text = "There are currently no respawn waves remaining for your side";
			[_text,false,3] call respawn_fnc_deadText;
			_showWaveAt = time + 15;
		};
	} else {

		// if the player has been told that there are no waves
		if (_showWaveAt > 0) then {
			// tell player that there are now waves
			private _text = format ["Your side now has %1 waves remaining",_availableWaves];
			[_text,true,7] call respawn_fnc_deadText;
			_showWaveAt = 0;
		};

		// Check the time
		private _time = missionNamespace getVariable [_timeVar,nil];

		// If there is no time
		if (isNil "_time") then {

			// Check if time has already been requested
			private _requested = missionNamespace getVariable [_requestedVar,false];

			// Request time if not requested
			if !(_requested) then {
				missionNamespace setVariable [_requestedVar,true,true];
			};
		} else {

			// If time is bigger than 0
			if (_time > 0) then {

				if (!(_time isEqualTo _lastTime)) then {
					// save lasttime for checking if time has even changed
					_lastTime = _time;

					// Turn time into readable format
					private _readableTime = _time call respawn_fnc_readableTime;
					private _text = format ["<t align='center'>Next respawn wave in <br />%1</t>",_readableTime];

					[_text,false,1] call respawn_fnc_deadText;
				};
			} else {
				["Respawn imminent...",false,1] call respawn_fnc_deadText;
			};
		};
	};

	// check if respawn is allowed
	private _allowed = missionNamespace getVariable [_allowedVar,false];
	if (_allowed) exitWith {
		[_unit] call respawn_fnc_respawn;
		true
	};

	// Wait 1 second(s)
	sleep 1;

	// Stop if out of time or unit is not dead anymore
	!(_unit getVariable ["unit_respawn_dead",true])
};