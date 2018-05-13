/* ----------------------------------------------------------------------------
Function: menus_fnc_addBackground

Description:
	Adds a button to the mission menu item
	AREA SIZE
	w = 14  * GUI_GRID_W;
	h = 20  * GUI_GRID_H;

Parameters:
0:	_color		- array
	0:	_r		- Red
	1:	_g		- Green
	2:	_b		- Blue
	3:	_a		- Opacity (1 = 100% visible / 0 = invisible)
1:	_pos		- Postion and size of the button
2:	_idc		- integer, idc to use for this control
Returns:
	_control 	- control of the button
Examples:
	_greenBackGround = [[0.5,1,0,1],[1,1,3,1]] call menus_fnc_addBackground;

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

params ["_color","_pos",["_idc",-1],"_display","_controlGroup"];
_pos params [["_x",0],["_y",1],["_w",5],["_h",1]];
_color params [["_r",1],["_g",1],["_b",1],["_a",0.5]];
_color = [_r,_g,_b,_a];

// find the display and control group of the menu
if (isNil "_display") then {
	_display = (findDisplay 304000);
};
if (_display isEqualTo displayNull) exitWith {};
if (isNil "_controlGroup") then {
	_controlGroup = _display displayCtrl 4110;
};

// Create a background
private _background = _display ctrlCreate ["menus_template_background", _idc, _controlGroup];

// change background size
_background ctrlSetPosition [(0 + (_x * _GUI_GRID_W)), (0 + (_y * _GUI_GRID_H)),(_w * _GUI_GRID_W),(_h * _GUI_GRID_H)];
_background ctrlCommit 0;

// Set background color
_background ctrlSetBackgroundColor _color;

// Disable selecting this control (its background)
_background ctrlEnable false;

// return the control
_background