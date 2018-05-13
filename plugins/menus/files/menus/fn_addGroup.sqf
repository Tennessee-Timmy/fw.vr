/* ----------------------------------------------------------------------------
Function: menus_fnc_addGroup

Description:
	Adds a control group

Parameters:
0:	_pos		- Postion and size of the button
1:	_idc		- integer, idc to use for this control
Returns:
	_control 	- control of the button
Examples:
	_ctrlGroup = [[10,6,20,6],-1,_display] call menus_fnc_addGroup;

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

params ["_pos",["_idc",-1],"_display"];
_pos params [["_x",0],["_y",1],["_w",5],["_h",1]];

// find the display and control group of the menu
if (isNil "_display") then {
	_display = (findDisplay 304000);
};
if (_display isEqualTo displayNull) exitWith {'menus_addGroup_fail' call debug_fnc_log};

// Create a group
private _group = _display ctrlCreate ["menus_template_group", _idc];

// change group size
_group ctrlSetPosition [(safezoneX + (_x * _GUI_GRID_W)), (safezoneY + (_y * _GUI_GRID_H)),(_w * _GUI_GRID_W),(_h * _GUI_GRID_H)];
_group ctrlCommit 0;

// return the control
_group