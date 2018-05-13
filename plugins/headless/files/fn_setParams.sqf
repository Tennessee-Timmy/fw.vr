/* ----------------------------------------------------------------------------
Function: headless_fnc_setParams

Description:
	Set headless params / runs on server
	It runs in postInit automatically

Parameters:
	none
Returns:
	nothing
Examples:
	call headless_fnc_setParams;

Author:
	nigel
---------------------------------------------------------------------------- */
if !(isServer) exitWith {};
#include "script_component.cpp"
// Script begins

private _enabled = ["p_headless_enabled", 2] call BIS_fnc_getParamValue;

missionNamespace setVariable ["mission_headless_enabled",_enabled,true];