/* ----------------------------------------------------------------------------
Function: menus_fnc_enableMenuButtons

Description:
	Allows for the menu to be opened by buttons ctrl+J

Parameters:
	none
Returns:
	nothing
Examples:
	call menus_fnc_enableMenuButtons;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// init value to disable

// Use spawn so a loop can be used
[] spawn {
	// wait until mission display exists
	waitUntil {!((findDisplay 46) isEqualTo displayNull)};

	// Add keydown eventhandeler to the disable mouse display
	private _keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", {
		params ["_ctrl", "_dikCode", "_shift", "_ctrlKey", "_alt"];

		// if ctrl + J is pressed
		private _keys = [0x24];
		if (_ctrlKey && {(_dikCode in _keys)}) then {

			// If menu exists, open it, if it does not, close it!
			if (findDisplay 304000 isEqualTo displayNull) then {
				call menus_fnc_menusOpen;
			} else {
				[304000] call menus_fnc_displayCloser;
			};
			true
		};
	}];
};