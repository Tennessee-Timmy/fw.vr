/* ----------------------------------------------------------------------------
Function: respawn_wave_fnc_onRespawnUnit

Description:
	Clears wave timer and tells you how many waves are remaining
	Teslls you how many waves you've got remaining
TODO:
	Replace hint with dialog
Parameters:
0:	_unit	- unit which respawns (local)
Returns:
	nothing
Examples:
	_unit call respawn_wave_fnc_onRespawnUnit;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_unit"];
// currently disabled
/*
// Get/set unit side
private _unitSide = _unit call respawn_fnc_getSetUnitSide;

// Check how many waves there are left
private _wavesVar = format ["respawn_wave_count_%1",_unitSide];
private _availableWaves = missionNamespace getVariable [_wavesVar,0];

private _timeVar = format ["respawn_wave_time_%1",_unitSide];
private _time = missionNamespace getVariable [_timeVar,0];

private _text = 'There are no longer any respawn waves for your side';
if (_availableWaves > 0) then {
	if (_time < 3) then {_availableWaves = (_availableWaves -1);};
	_text = format ["Your side has %1 respawn waves remaining",(_availableWaves)];
};
[_text,true,3] call respawn_fnc_deadText;*/