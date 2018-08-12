/* ----------------------------------------------------------------------------
Function: vd_fnc_postInit

Description:
	postInit script for vd plugin

Parameters:
	none
Returns:
	nothing
Examples:
	Runs in postinit (from functions.cpp)

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Script begins


if ("menus" in mission_plugins) then {
	[["View Dist Plugin","call vd_fnc_menu",[{true},{false}],false],[player]] call menus_fnc_registerItem;
};