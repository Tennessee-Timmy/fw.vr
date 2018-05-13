/* ----------------------------------------------------------------------------
Function: menus_fnc_addTitle

Description:
	Adds a title to the mission menu item
	AREA SIZE
	w = 14  * GUI_GRID_W;
	h = 20  * GUI_GRID_H;

Parameters:
0:	_text		- String, text to be displayed ( will be parsed into text)
1:	_pos		- Postion and size of the title
2:	_bar		- bool, Add a bar under the title?
3:	_idc		- integer, idc to use for this control
Returns:
	_control 	- control of the title
Examples:
	_zeusTitle = ["ZEUS MENU",[0,0,14,1.2],true]call menus_fnc_addTitle;

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

params ["_text","_pos","_bar",["_idc",-1],"_display","_controlGroup"];
_pos params [["_x",0],["_y",0],["_w",14],["_h",1]];

// find the display and control group of the menu
if (isNil "_display") then {
	_display = (findDisplay 304000);
};
if (_display isEqualTo displayNull) exitWith {};
if (isNil "_controlGroup") then {
	_controlGroup = _display displayCtrl 4110;
};


// Create a title
private _titleCtrl = _display ctrlCreate ["menus_template_title", _idc, _controlGroup];

// change title size
_titleCtrl ctrlSetPosition [(0 + (_x * _GUI_GRID_W)), (0 + (_y * _GUI_GRID_H)),(_w * _GUI_GRID_W),(_h * _GUI_GRID_H)];
_titleCtrl ctrlCommit 0;

// Disable selecting this control (its text only)
_titleCtrl ctrlEnable false;

// Title text
private _title = parseText _text;

// Set title text
_titleCtrl ctrlSetStructuredText _title;

if (_bar) then {
	// Craete the title bar (just looks nice)
	private _titleBarCtrl = _display ctrlCreate ["menus_template_titleBar", 4114, _controlGroup];
	_titleBarCtrl ctrlEnable false;
	// move the bar
	_titleBarCtrl ctrlSetPosition [(0 + (_x * _GUI_GRID_W)), (0 + ((_y + 1.2) * _GUI_GRID_H)),(_w * _GUI_GRID_W),(0.1 * _GUI_GRID_H)];
	_titleBarCtrl ctrlCommit 0;
};
_titleCtrl