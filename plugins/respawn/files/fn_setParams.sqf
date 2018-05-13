/* ----------------------------------------------------------------------------
Function: respawn_fnc_setParams

Description:
	Sets the parameters on the server as publicVariables
Parameters:
	none
Returns:
	nothing
Examples:
	call respawn_fnc_setParams;
	Runs in the postInit from functions.cpp
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

// quit if not the server
if !(isServer) exitWith {};

// get param value
_type = ["p_respawn_type", 0] call BIS_fnc_getParamValue;
_location = ["p_respawn_location", 0] call BIS_fnc_getParamValue;

// Set variables as public

// use settings as default instead, define the values below for override
missionNamespace setVariable ["respawn_location",_location,true];

/*
--- NOT USED ---

_rounds = ["p_respawn_rounds", 3] call BIS_fnc_getParamValue;
missionNamespace setVariable ["respawn_rounds",_rounds,true];

*/