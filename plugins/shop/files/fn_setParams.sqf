/* ----------------------------------------------------------------------------
Function: shop_fnc_setParams

Description:
	Set shop params / runs on server
	It runs in postInit automatically

Parameters:
	none
Returns:
	nothing
Examples:
	call shop_fnc_setParams;

Author:
	nigel
---------------------------------------------------------------------------- */
if !(isServer) exitWith {};
#include "script_component.cpp"
// Script begins
/*
private _real = ["p_settings_reset", 0] call BIS_fnc_getParamValue;
*/
