/* ----------------------------------------------------------------------------
Function: menus_fnc_postInit

Description:
	Runs in the postinit from CfgFunctions
	Adds the map event handeler to player

Parameters:
	none
Returns:
	nothing
Examples:
	call menus_fnc_postInit;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// Stop if no interface (server/hc)
if !(hasInterface) exitWith {};

// Add map open eventhandler
menus_openMap_handle = addMissionEventHandler ["Map",{
	params ["_mapIsOpened","_mapIsForced"];

	// If map is opened open the menu
	if (_mapIsOpened) then {
		//[] spawn {findDisplay 46 createDisplay "menus_main_start"}; // causes ace map functions to not work
	} else {

		// If map is closed, close the displays
		false call menus_fnc_MenusClose;
	};
}];

// Add admin unconscious menu
if (call menus_fnc_isAdmin) then {
	call menus_fnc_enableUnconsciousMenu;
};

// Allow keys to open menu
call menus_fnc_enableMenuButtons;