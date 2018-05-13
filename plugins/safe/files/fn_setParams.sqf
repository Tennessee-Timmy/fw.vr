/* ----------------------------------------------------------------------------
Function: safe_fnc_setParams

Description:
	Sets the parameters on the server as publicVariables
Parameters:
	none
Returns:
	nothing
Examples:
	call safe_fnc_setParams;
	Runs in the postInit from functions.cpp
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

// quit if not the server
if !(isServer) exitWith {};

// get param value
private _time = ["p_safe_time", 0] call BIS_fnc_getParamValue;
private _restrict_time = ["p_safe_restrict_time", 0] call BIS_fnc_getParamValue;

// Set variables as public
missionNamespace setVariable ["mission_safe_time",_time,true];
missionNamespace setVariable ["mission_safe_restrict_time",_restrict_time,true];