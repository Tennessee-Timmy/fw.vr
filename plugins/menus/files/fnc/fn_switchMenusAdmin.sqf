/* ----------------------------------------------------------------------------
Function: menus_fnc_switchMenusAdmin

Description:
	Switches to the admin menu
	Used to switch from mission menu to admin menu

Parameters:
	none
Returns:
	nothing
Examples:
	call menus_fnc_switchMenusAdmin;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// Serialization must be disabled because controls / displays are saved as variables
disableSerialization;

// Get displays and controls
_display = findDisplay 304000;
_topBarCtrl = (_display displayCtrl 4101);

// Change color and text
_topBarCtrl ctrlsetText "Admin Menu";
_topBarCtrl ctrlSetBackgroundColor [0.9,0,0,1];

// hide / show controls
[_display,[[4105,false],[4107,false],[4106,true],[4104,true]]] call menus_fnc_ctrlHider;