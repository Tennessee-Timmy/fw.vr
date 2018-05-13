/* ----------------------------------------------------------------------------
Function: menus_fnc_switchMenusMission

Description:
	Switches to the misison menu
	Used to switch from admin menu to mission menu

Parameters:
	none
Returns:
	nothing
Examples:
	call menus_fnc_switchMenusMission;

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
_topBarCtrl ctrlsetText "Mission Menu";
_topBarCtrl ctrlSetBackgroundColor [1,0.5,0.0,1];

// hide / show controls
// 4104 = mission list, 4105 = admin list, 4106 = admin button, 4107 = mission button
[_display,[[4104,false],[4105,true],[4106,false],[4107,true]]] call menus_fnc_ctrlHider;