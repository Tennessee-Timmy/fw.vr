/* ----------------------------------------------------------------------------
Function: respawn_wave_fnc_addTime

Description:
	Adds time to the side respawn time
	used to force respawns an bypass waiting

Parameters:
0:	_side	- side to update
1:	_addTime	- time to add ( can be negative )
Returns:
	nothing
Examples:
	[west,1] call respawn_wave_fnc_addTime;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_side",["_addTime",0]];

// Get the current wave time for the side
private _timeVar = format ["respawn_wave_time_%1",_side];

// default time (in seconds)
private _defaultTime = 60 * (missionNamespace getVariable ["respawn_wave_time",RESPAWN_WAVE_PARAM_TIME]);

// get time from seed
private _time = missionNamespace getVariable [_timeVar,_defaultTime];

// add new time
_time = _time + _addTime;

// update the time
[2,_timeVar,_time] call seed_fnc_setVarsTarget;
missionNamespace setVariable [_timeVar,_time,true];