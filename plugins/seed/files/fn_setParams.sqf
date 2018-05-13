/* ----------------------------------------------------------------------------
Function: seed_fnc_setParams

Description:
	Set seed params / runs on server
	It runs in preInit automatically

Parameters:
	none
Returns:
	nothing
Examples:
	call seed_fnc_setParams;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
if !(isServer) exitWith {};

private _reset = ["p_seed_reset", 0] call BIS_fnc_getParamValue;


_reset = [false,true] select _reset;
//if (_reset isEqualTo 1) then {_reset = true;} else {_reset = false;};
missionNamespace setVariable ["seed_reset",_reset,true];