/* ----------------------------------------------------------------------------
Function: loot_fnc_setParams

Description:
	Set loot params / runs on server
	It runs in postInit automatically

Parameters:
	none
Returns:
	nothing
Examples:
	call loot_fnc_setParams;

Author:
	nigel
---------------------------------------------------------------------------- */
if !(isServer) exitWith {};
#include "script_component.cpp"
// Script begins
/*DISABLED
private _real = ["p_settings_reset", 0] call BIS_fnc_getParamValue;
*/
