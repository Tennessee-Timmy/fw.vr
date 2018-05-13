/* ----------------------------------------------------------------------------
Function: tpb_fnc_setParams

Description:
	Sets the parameters on the server as publicVariables
Parameters:
	none
Returns:
	nothing
Examples:
	call tpb_fnc_setParams;
	Runs in the postInit from functions.cpp
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

// quit if not the server
if !(isServer) exitWith {};

// get param value
private _mode = ["p_tpb_mode", 0] call BIS_fnc_getParamValue;

// Set variables as public
missionNamespace setVariable ["mission_tpb_mode",_mode,true];