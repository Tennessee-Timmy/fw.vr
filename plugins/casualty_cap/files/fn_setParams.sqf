/* ----------------------------------------------------------------------------
Function: casualty_cap_fnc_setParams

Description:
	Sets the parameters on the server as publicVariables
Parameters:
	none
Returns:
	nothing
Examples:
	call casualty_cap_fnc_setParams;
	Runs in the postInit from functions.cpp
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

// quit if not the server
if !(isServer) exitWith {};

// get param value
_limit = ["p_casualty_cap_limit", 0] call BIS_fnc_getParamValue;

// Set variables as public

// use settings as default instead, define the values below for override
missionNamespace setVariable ["mission_casualty_cap_limit",_limit,true];