/* ----------------------------------------------------------------------------
Function: menus_fnc_dropList

Description:
	Adds a dropList button
	Click on this and it will turn into a list
	Click on item to run code
	AREA SIZE
	w = 14  * GUI_GRID_W;
	h = 20  * GUI_GRID_H;

Parameters:
0:	_text		- String, text to be displayed
1:	_pos		- Postion and size of the button
2:	_listCode	- Code to create array, which will be made into the list
	Array must contain:
	0:	_name		- String, name of the item
	1:	_value		- value of the item, (optional) (defaults to compile _name)
	2:	_toolTip	- Tooltip for this item (optional)
3:	_selectCode	- Code to run when an item is selected
4:	_sort		- bool, sort the list (ABC)?
5:	_idc		- integer, idc to use for this control
Returns:
	_control 	- control of the title
Examples:
	_dropList = [
		"Respawn Player",	//0
		[0,1.3,5,1],		//1
		{
			private _array = [];
			private _nil = {
				private _value = _x;
				private _name = name _value;
				private _toolTip = ('Respawn '  +  _name);
				_value = str _value;
				_array pushBack [_name,_value,_toolTip];
				false
			} count PLAYERLIST;
			_array
		},					//2
		{[_this] call respawn_fnc_respawn}		//3
	] call menus_fnc_dropList;

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

params ["_text","_pos","_listCode","_selectCode",["_sort",true],["_idc",-1],"_display","_controlGroup"];
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

// Add info to the control so it can be grabbed in the eventhandler
_buttonCtrl setVariable ["param_info",[_text,_listCode,_selectCode,_sort,_display,_controlGroup]];

// Add eventhandler to button so it works
_buttonCtrl ctrlSetEventHandler ["buttonClick","call menus_fnc_listEHButtonClick"];

_buttonCtrl