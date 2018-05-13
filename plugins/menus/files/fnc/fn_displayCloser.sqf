/* ----------------------------------------------------------------------------
Function: menus_fnc_displayCloser

Description:
	Closes the displays if they are open based on the idd

Parameters:
0:	_displays		- Array of display idd-s
Returns:
	nothing
Examples:
	[303000,304000] call menus_fnc_displayCloser;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// Serialization must be disabled because controls / displays are saved as variables
disableSerialization;

[_this] params [["_displays",[]]];

// Exit if array is empty
if (_displays isEqualTo []) exitWith {};

// Loop through all displays
_nul = {
	// Find the display
	_display = findDisplay _x;

	// If it exists...
	if !(_display isEqualTo displayNull) then {
		// Close the display
		(_display) closeDisplay 1;
	};
	false
} count _displays;