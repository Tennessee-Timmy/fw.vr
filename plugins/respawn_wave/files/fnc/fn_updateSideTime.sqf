/* ----------------------------------------------------------------------------
Function: respawn_wave_fnc_updateSideTime

Description:
	If respawn_wave_requested_(side) is true
	Updates the respawn_wave_time_(side)
	Calls the side respawn and resets the requests / time
	To override time just manually update respawn_wave_time_(side)
	Run only on the server

	"respawn_wave_delay" - sets the time for the respawn window
	"respawn_wave_count" - from paraameters used for the max waves allowed
Parameters:
0:	_side	- side to update
Returns:
	nothing
Examples:
	west call respawn_wave_fnc_updateSideTime;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_side"];
// Check how many waves we've used up
private _wavesVar = format ["respawn_wave_count_%1",_side];
private _defaultWaves = missionNamespace getVariable ["respawn_wave_count",RESPAWN_WAVE_PARAM_COUNT];
private _availableWaves = missionNamespace getVariable [_wavesVar,_defaultWaves];

// Quit if we run out of waves
if (_availableWaves <= 0) exitWith {};

// Check if time is requested for this side
private _requestedVar = format ["respawn_wave_requested_%1",_side];
private _requested = missionNamespace getVariable [_requestedVar,false];

// allowed respawn sent to clients
private _allowedVar = format ["respawn_wave_allowed_%1",_side];
private _allowed = missionNamespace getVariable [_allowedVar,false];

private _didRespawn = false;

if (_requested) then {

	// Get the current wave time for the side
	private _timeVar = format ["respawn_wave_time_%1",_side];

	// default time (in seconds)
	private _defaultTime = 60 * (missionNamespace getVariable ["respawn_wave_time",RESPAWN_WAVE_PARAM_TIME]);

	// get time in seconds
	private _time = [_timeVar,_defaultTime] call seed_fnc_getVars;
	_time = _time - 1;

	// Wave delay is used to leave a window of time for units who just died
	private _delay = missionNamespace getVariable ["respawn_wave_delay",RESPAWN_WAVE_PARAM_DELAY];

	// Check if we have not passed the delay window
	if (_time > - (_delay)) then {

		// If we still wait then remove 1 from time
		[_timeVar,_time] call seed_fnc_setVars;
		missionNamespace setVariable [_timeVar,_time,true];


		// If we have waited enough respawn the units every second
		if (_time <= 0 && _time > -(_delay)) then {
			[_side] call respawn_fnc_respawn;
			_didRespawn = true;
		};
	} else {

		// respawn all dead units for side
		[_side] call respawn_fnc_respawn;
		_didRespawn = true;

		// reset time
		[_timeVar,nil] call seed_fnc_setVars;
		missionNamespace setVariable [_timeVar,nil,true];

		// remove a wave
		[_wavesVar,(_availableWaves - 1)] call seed_fnc_setVars;
		missionNamespace setVariable [_wavesVar,(_availableWaves - 1),true];

		// close the request
		missionNamespace setVariable [_requestedVar,false,true];
	};
};

// setvariable to allowe custom sided to respawn themselves
if (_didRespawn && !_allowed) then {
	missionNamespace setVariable [_allowedVar,true,true];
};
if (_allowed && !_didRespawn) then {
	missionNamespace setVariable [_allowedVar,false,true];
};