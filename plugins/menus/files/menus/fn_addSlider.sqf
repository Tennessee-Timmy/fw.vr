/* ----------------------------------------------------------------------------
Function: menus_fnc_addSlider

Description:
	Adds a button to the mission menu item
	AREA SIZE
	w = 14  * GUI_GRID_W;
	h = 20  * GUI_GRID_H;

Parameters:
0:	_slide		- Array [min,max,step,default]
1:	_pos		- Postion and size of the button
2:	_code		- String of code to run when button is pressed
3:	_idc		- integer, idc to use for this control
Returns:
	_control 	- control of the button
Examples:
	_becomeZeusButton = [[100,3600,50,viewDistance],[1,1,3,1],"player remoteExec ['zeus_fnc_srvAdd',2];"] call menus_fnc_addSlider;

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

params ["_slide","_pos","_code",["_idc",-1],"_display","_controlGroup"];
_slide params ['_slideMin','_slideMax','_slideStep','_def'];
_pos params [["_x",0],["_y",1],["_w",5],["_h",1]];

// find the display and control group of the menu
if (isNil "_display") then {
	_display = (findDisplay 304000);
};
if (_display isEqualTo displayNull) exitWith {};
if (isNil "_controlGroup") then {
	_controlGroup = _display displayCtrl 4110;
};

// create progress bar
private _progCtrl = _display ctrlCreate ["menus_template_progress", _idc + 100, _controlGroup];

private _progH = (_h*0.625);
private _progW = (_w * 0.97);
private _progX = (_x + ((_progW / _w)*0.65));
_progW = _progW - (_progW / _w);

// change progress bar size
_progCtrl ctrlSetPosition [(0 + (_progX * _GUI_GRID_W)), (0 + (_y * _GUI_GRID_H)),(_progW * _GUI_GRID_W),(_progH * _GUI_GRID_H)];
_progCtrl ctrlCommit 0;


// create text
private _textCtrl = ["0",[_progX,_y,_progW,_progH],false,_idc + 200]call menus_fnc_addTitle;

// Create a slider
private _sliderCtrl = _display ctrlCreate ["menus_template_slider", _idc, _controlGroup];

_sliderCtrl sliderSetRange [_slideMin,_slideMax];
_sliderCtrl sliderSetSpeed [_slideStep,_slideStep*4];


// change slider size
_sliderCtrl ctrlSetPosition [(0 + (_x * _GUI_GRID_W)), (0 + (_y * _GUI_GRID_H)),(_w * _GUI_GRID_W),(_h * _GUI_GRID_H)];
_sliderCtrl ctrlCommit 0;


// Run the code when slider is clicked
//_sliderCtrl ctrlAddEventHandler ["sliderPosChanged",_code];

_sliderCtrl setVariable ['menus_ctrl_sliderCode',_code];
_sliderCtrl setVariable ['menus_ctrl_prog',_progCtrl];
_sliderCtrl setVariable ['menus_ctrl_text',_textCtrl];

_sliderCtrl ctrlAddEventHandler ["sliderPosChanged",{
	params ['_control','_newValue'];
	disableSerialization;
	private _sliderCode = _control getVariable ['menus_ctrl_sliderCode',{}];
	private _progCtrl = _control getVariable ['menus_ctrl_prog',controlNull];
	private _textCtrl = _control getVariable ['menus_ctrl_text',controlNull];
	private _progText = _control getVariable ['menus_ctrl_prog_text',(str _newValue)];
	private _sliderRange = sliderRange _control;

	private _mult = call {
		if (_newValue >= 1000) exitWith {100};
		if (_newValue >= 100) exitWith {10};
		if (_newValue >= 10) exitWith {1};
		0.1
	};

	private _v = linearConversion [(_sliderRange#0),(_sliderRange#1),/*((round(_newValue*_mult))/_mult)*/_newValue,0,1,true];

	_textCtrl ctrlSetStructuredText parseText('<t size = "0.5">'+_progText+'</t>');
	_progCtrl progressSetPosition _v;

	[_control,_newValue,_progCtrl,_textCtrl,_v] call _sliderCode;
}];

// set for default value
private _v = _def;
private _progText = (str _v);
private _sliderRange = [_slideMin,_slideMax];
_v = linearConversion [(_sliderRange#0),(_sliderRange#1),_v,0,1,true];
_textCtrl ctrlSetStructuredText parseText('<t size = "0.5">'+_progText+'</t>');
_progCtrl progressSetPosition _v;
_sliderCtrl sliderSetPosition _def;


// return the control
_sliderCtrl