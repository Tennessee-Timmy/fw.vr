/* ----------------------------------------------------------------------------
Function: menus_fnc_ctrlHider

Description:
	Toggles the controls on/off
	Force hide/show possible with 2nd element

Parameters:
0:	_display		- Display which contains the contorls
1:	_controls		- Array of control idd-s
Returns:
	nothing
Examples:
	// 4105 will be forced hidden
	[_display,[[4105,true],4106]] call menus_fnc_ctrlHider;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// Serialization must be disabled because controls / displays are saved as variables
disableSerialization;
params ["_display",["_ctrls",[]]];

// Exit if display is not defined
if (isNil "_display") exitWith {};

// Exit if array is empty
if (_ctrls isEqualTo []) exitWith {};

// Loop thorugh all controls
_nul = {
	// Find the control
	_x params ["_ctrl","_close"];
	_ctrl = (_display displayCtrl _ctrl);

	// If close is not forced then
	if (isNil "_close") then {
		// If control is enabled, set _close as true
		_close = (ctrlEnabled _ctrl);
	};

	// reverse close because there is no ctrlHide
	_close = !_close;

	// hide and disable control if it's enabled or forced to hide
	_ctrl ctrlShow _close;
	_ctrl ctrlEnable _close;
	false
} count _ctrls;