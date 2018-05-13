/* ----------------------------------------------------------------------------
Function: menus_fnc_menusClose

Description:
	Closes the mission menu
	re-creates the button (if on map)
	Optional full-close (no button on map)

Parameters:
0:	_button		- Allow to create a button to reopen on map (default true)
Returns:
	nothing
Examples:
	// Button will not be created on map
	false call menus_fnc_menusClose;
	// Button will be created when on map
	call menus_fnc_menusClose;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params [["_button",true,[false]]];

// Call te display closer
[303000,304000] call menus_fnc_displayCloser;

// if map visible and button creation is allowed...
if (visibleMap && _button) then {
	// Create the start button
	[] spawn {findDisplay 46 createDisplay "menus_main_start"};
};