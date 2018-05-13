/* ----------------------------------------------------------------------------
Function: menus_fnc_openMainMenu

Description:
	Runs when the menu is opened(onLoad)

Parameters:
0:	_displays		- Array of display idd-s
Returns:
	nothing
Examples:
	call menus_fnc_openMainMenu;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// Serialization must be disabled because controls / displays are saved as variables
disableSerialization;
params ["_display"];

// Wait until the display exists
waitUntil {!(_display isEqualTo displayNull)};

// make the default dialog
[] spawn menus_fnc_menuList_default;

// spawn the menu update loop
[] spawn {
	disableSerialization;
	_display = (findDisplay 304000);
	waitUntil {
		private _nul = call menus_fnc_updateList;
		(_display isEqualTo displayNull)
	};
	missionNamespace setVariable ["menu_items_current",[]];
};

// Check if player is logged in as admin
// todo player steam uid list for admins
if (call menus_fnc_isAdmin) then {
	// if admin, leave the admin menu button available
	[_display,[[4104,false],[4105,true],[4106,false],[4107,true]]] call menus_fnc_ctrlHider;
} else {
	// if not admin, hide the admin button
	[_display,[4105,4106,4107]] call menus_fnc_ctrlHider;
};