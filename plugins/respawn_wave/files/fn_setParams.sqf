/* ----------------------------------------------------------------------------
Function: respawn_wave_fnc_setParams

Description:
	Sets the parameters on the server as publicVariables
Parameters:
	none
Returns:
	nothing
Examples:
	call respawn_wave_fnc_setParams;
	Runs in the postInit from functions.cpp
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

// quit if not the server
if !(isServer) exitWith {};

// get param value
_waveTime = ["p_respawn_wave_time", 10] call BIS_fnc_getParamValue;
_waveDelay = ["p_respawn_wave_delay", 1] call BIS_fnc_getParamValue;
_waveCount = ["p_respawn_wave_count", 1] call BIS_fnc_getParamValue;

// use settings as default instead, define the values below for override
missionNamespace setVariable ["respawn_wave_time",_waveTime,true];
missionNamespace setVariable ["respawn_wave_delay",_waveDelay,true];
missionNamespace setVariable ["respawn_wave_count",_waveCount,true];