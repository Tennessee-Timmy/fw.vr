/* ----------------------------------------------------------------------------
Function: menus_fnc_addTextBox

Description:
	Adds a textBox to the mission menu item
	AREA SIZE
	w = 14  * GUI_GRID_W;
	h = 20  * GUI_GRID_H;

Parameters:
0:	_text		- String, name that will be displayed on the button
1:	_pos		- Postion and size of the button
3:	_idc		- integer, idc to use for this control
Returns:
	_control 	- control of the button
Examples:
	_textBox = ["Insert Text Here",[1,1,3,1],6005]call menus_fnc_addTextBox;

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

params ["_text","_pos",["_idc",-1],"_display","_controlGroup"];
_pos params [["_x",0],["_y",1],["_w",5],["_h",1]];

// find the display and control group of the menu
if (isNil "_display") then {
	_display = (findDisplay 304000);
};
if (_display isEqualTo displayNull) exitWith {};
if (isNil "_controlGroup") then {
	_controlGroup = _display displayCtrl 4110;
};


// Create a editBox
private _editCtrl = _display ctrlCreate ["menus_template_editBox", _idc, _controlGroup];

// change editBox size
_editCtrl ctrlSetPosition [(0 + (_x * _GUI_GRID_W)), (0 + (_y * _GUI_GRID_H)),(_w * _GUI_GRID_W),(_h * _GUI_GRID_H)];
_editCtrl ctrlCommit 0;

// Set editBox text
_editCtrl ctrlSetText _text;

// return the control
_editCtrl