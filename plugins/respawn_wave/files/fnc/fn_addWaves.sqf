/* ----------------------------------------------------------------------------
Function: respawn_wave_fnc_addWaves

Description:
	Add waves to the side
Parameters:
0:	_side		- side to add waves to
1:	_addWaves	- amount of waves added
Returns:
	nothing
Examples:
	[west,1] call respawn_wave_fnc_addWaves;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_side",["_addWaves",1]];
// Check how many waves we've used up
private _wavesVar = format ["respawn_wave_count_%1",_side];
private _defaultWaves = missionNamespace getVariable ["respawn_wave_count",RESPAWN_WAVE_PARAM_COUNT];
private _availableWaves = missionNamespace getVariable [_wavesVar,_defaultWaves];

_availableWaves = _availableWaves + _addWaves;

// update waves
[2,_wavesVar,_availableWaves] call seed_fnc_setVarsTarget;
missionNamespace setVariable [_wavesVar,_availableWaves,true];