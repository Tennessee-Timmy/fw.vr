/* ----------------------------------------------------------------------------
Function: briefing_fnc_keyDown

Description:
	keydown function for the roster

Parameters:
	none
Returns:
	nothing
Examples:
	call briefing_fnc_keyDown
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// Allow saving display as variable
disableSerialization;
params ["_ctrl", "_dikCode", "_shift", "_ctrlKey", "_alt"];

// if  J is pressed
private _keys = [0x24];
if ((_dikCode in _keys)) then {

	// If menu exists, open it, if it does not, close it!
	if (findDisplay 603000 isEqualTo displayNull) then {
		[] spawn briefing_fnc_roster;
	} else {
		[603000] call menus_fnc_displayCloser;
	};
	true
};