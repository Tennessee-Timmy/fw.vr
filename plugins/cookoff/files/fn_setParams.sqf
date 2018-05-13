/* ----------------------------------------------------------------------------
Function: cookoff_fnc_setParams

Description:
	Set cookoff params / runs on server
	It runs in postInit automatically

Parameters:
	none
Returns:
	nothing
Examples:
	call cookoff_fnc_setParams;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Script begins

// exit non servers
if (!isServer) exitWith {};

private _enabled = ["p_cookoff_enabled", COOKOFF_PARAM_ENABLED] call BIS_fnc_getParamValue;
private _burn = ["p_cookoff_burn", COOKOFF_PARAM_BURN] call BIS_fnc_getParamValue;

private _enabledBool = [false,true] select _enabled;
private _burnBool = [false,true] select _burn;
missionNamespace setVariable ["mission_cookoff_enabled",_enabledBool];
missionNamespace setVariable ["mission_cookoff_burn",_burnBool];