/* ----------------------------------------------------------------------------
Function: ai_ins_fnc_setParams

Description:
	Set ai ins params / runs on server
	It runs in postInit automatically

Parameters:
	none
Returns:
	nothing
Examples:
	call ai_ins_fnc_setParams;

Author:
	nigel
---------------------------------------------------------------------------- */
if !(isServer) exitWith {};
#include "script_component.cpp"
// Script begins

private _amt = ["p_ai_ins_amt", 1] call BIS_fnc_getParamValue;
private _skill = ["p_ai_ins_skill", 1] call BIS_fnc_getParamValue;

missionNamespace setVariable ["mission_ai_ins_amt",_amt,true];
missionNamespace setVariable ["mission_ai_ins_skill",_skill,true];