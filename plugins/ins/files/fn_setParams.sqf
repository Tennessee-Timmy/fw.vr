/* ----------------------------------------------------------------------------
Function: ins_fnc_setParams

Description:
	Set ins params / runs on server
	It runs in postInit automatically

Parameters:
	none
Returns:
	nothing
Examples:
	call ins_fnc_setParams;

Author:
	nigel
---------------------------------------------------------------------------- */
if !(isServer) exitWith {};
#include "script_component.cpp"
// Script begins

private _diff = ["p_ins_diff", 1] call BIS_fnc_getParamValue;

missionNamespace setVariable ["mission_ins_diff",_diff,true];