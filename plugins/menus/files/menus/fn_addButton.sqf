/* ----------------------------------------------------------------------------
Function: menus_fnc_addButton

Description:
	Adds a button to the mission menu item
	AREA SIZE
	w = 14  * GUI_GRID_W;
	h = 20  * GUI_GRID_H;

Parameters:
0:	_text		- String, name that will be displayed on the button
1:	_pos		- Postion and size of the button
2:	_code		- String of code to run when button is pressed
3:	_idc		- integer, idc to use for this control
Returns:
	_control 	- control of the button
Examples:
	_becomeZeusButton = ["Become Zeus",[1,1,3,1],"player remoteExec ['zeus_fnc_srvAdd',2];"] call menus_fnc_addButton;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// code begins

//	Define grid for use if controls are created / edited in this dialog
private _GUI_GRID_W = (safezoneW / 40);
private _GUI_GRID_H = (safezoneH / 25);
private _GUI_GRID_X = (0);
private _GUI_GRID_Y = (0);

// Allow to save displays and controls as variables
disableSerialization;

params ["_text","_pos","_code",["_idc",-1],"_display","_controlGroup"];
_pos params [["_x",0],["_y",1],["_w",5],["_h",1]];

// find the display and control group of the menu
if (isNil "_display") then {
	_display = (findDisplay 304000);
};
if (_display isEqualTo displayNull) exitWith {};
if (isNil "_controlGroup") then {
	_controlGroup = _display displayCtrl 4110;
};


// Create a button
private _buttonCtrl = _display ctrlCreate ["menus_template_button", _idc, _controlGroup];

// change button size
_buttonCtrl ctrlSetPosition [(0 + (_x * _GUI_GRID_W)), (0 + (_y * _GUI_GRID_H)),(_w * _GUI_GRID_W),(_h * _GUI_GRID_H)];
_buttonCtrl ctrlCommit 0;

// Set button text
_buttonCtrl ctrlSetText _text;

// Run the code when button is clicked
_buttonCtrl ctrlSetEventHandler ["buttonClick",_code];

// return the control
_buttonCtrl