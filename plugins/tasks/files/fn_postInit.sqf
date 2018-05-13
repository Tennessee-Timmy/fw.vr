/* ----------------------------------------------------------------------------
Function: tasks_fnc_postInit

Description:
	postInit script for tasks plugin

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


if (hasInterface) then {
	// Add admin menus
	if ("menus" in mission_plugins) then {
		[["Tasks Plugin","call tasks_fnc_menu",[{true},{false}],true],[player]] call menus_fnc_registerItem;
	};
	// Add zeus modules
	if ("zeus" in mission_plugins && "menus" in mission_plugins) then {
		call tasks_fnc_addZeusModules;
	};
};
// include tasks on server
if (isServer) then {
	#include "..\tasks.sqf"
	call tasks_fnc_srvLoop;
};