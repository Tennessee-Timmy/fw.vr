/* ----------------------------------------------------------------------------
Function: revive_fnc_setParams

Description:
	Sets the parameters on the server as publicVariables
Parameters:
	none
Returns:
	nothing
Examples:
	call revive_fnc_setParams;
	Runs in the postInit from functions.cpp
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

// quit if not the server
if !(isServer) exitWith {};

// get param value
_waveTime = ["p_revive_time", 10] call BIS_fnc_getParamValue;

// use settings as default instead, define the values below for override
missionNamespace setVariable ["revive_time",_waveTime,true];