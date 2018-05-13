/* ----------------------------------------------------------------------------
Function: menus_fnc_addDisplay

Description:
	Creats a dialog on top

Parameters:
0:	_display	- Display on top of which this will be created (Mission display - 46) by default
Returns:
	_newDisplay	- Display which was just created
Examples:
	_newDisplay = call menus_fnc_addDisplay;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// code begins

// Allow to save displays and controls as variables
disableSerialization;

params [["_display",(findDisplay 46)]];

if (_display isEqualType displayNull) then {
	if (_display isEqualTo displayNull) then {
		_display = (findDisplay 46)
	};
} else {
	_display = (findDisplay 46);
};

private _newDisplay = _display createDisplay "menus_template_display";

// return the display
_newDisplay