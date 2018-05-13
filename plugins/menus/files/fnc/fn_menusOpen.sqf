/* ----------------------------------------------------------------------------
Function: menus_fnc_menusOpen

Description:
	Opens the mission menu and closes
	the button and menu if they are open

Parameters:
	none
Returns:
	nothing
Examples:
	call menus_fnc_menusOpen;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// Close the menu button and/or the menu if it's already open
[303000,304000] call menus_fnc_displayCloser;

// Create the menu
createDialog 'menus_main_menu';