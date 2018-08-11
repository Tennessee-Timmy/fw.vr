/* ----------------------------------------------------------------------------
Function: vd_fnc_menu

Description:
	Creates the dialog in the mission menu (menus plugin)

Parameters:
	none
Returns:
	nothing
Examples:
	call vd_fnc_menu;
	call it on the tasks menu item

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
disableSerialization;

//	Get display and ctrlgroup
private _display = (findDisplay 304000);
if (_display isEqualTo displayNull) exitWith {};
private _controlGroup = _display displayCtrl 4110;

//	Define grid for use if controls are created / edited in this dialog
private _GUI_GRID_W = (safezoneW / 40);
private _GUI_GRID_H = (safezoneH / 25);
private _GUI_GRID_X = (0);
private _GUI_GRID_Y = (0);

// Create a control already defined in dialogs.hpp
private _title = ["VIEW DISTANCE MENU",[0,0,14,1.2],true]call menus_fnc_addTitle;

private _y = 1.5;

// Update tasks
_slider = [
	[100,20000,50,viewDistance],
	[1.5,_y,11,1],
	{
		params ['_control','_newValue','_progCtrl','_textCtrl','_v'];
		setViewDistance _newValue;
		missionNamespace setVariable ['mission_vd_lastDist',_newValue];
	},
	6001
] call menus_fnc_addSlider;
_slider ctrlSetTooltip "Change View distance";

_y = _y + 1.5;

_slider2 = [
	[100,16000,50,(getObjectViewDistance#0)],
	[1.5,_y,11,1],
	{
		params ['_control','_newValue','_progCtrl','_textCtrl','_v'];
		setObjectViewDistance [_newValue,(getObjectViewDistance#1)];
		missionNamespace setVariable ['mission_vd_lastDistO',_newValue];
	},
	6002
] call menus_fnc_addSlider;
_slider2 ctrlSetTooltip "Change Object View distance";

_y = _y + 1.5;

_slider3 = [
	[20,1000,5,(getObjectViewDistance#1)],
	[1.5,_y,11,1],
	{
		params ['_control','_newValue','_progCtrl','_textCtrl','_v'];
		setObjectViewDistance [(getObjectViewDistance#0),_newValue];
	},
	6003
] call menus_fnc_addSlider;
_slider3 ctrlSetTooltip "Change Shadow View distance";

_y = _y + 1.5;

private _tasksButton1 = ["Enable Auto",[1.5,_y,5,1],"
	true call vd_fnc_auto;
",6004]call menus_fnc_addButton;
_tasksButton1 ctrlSetTooltip "View distance will be based on your FOV(zoom)";

private _tasksButton2 = ["Disable Auto",[7,_y,5,1],"
	false call vd_fnc_auto;
",6005]call menus_fnc_addButton;
_tasksButton2 ctrlSetTooltip "View distance will be based on your FOV(zoom)";

_y = _y + 1.5;

_slider4 = [
	[0.5,10,0.1,(missionNamespace getVariable ['mission_vd_fovRatio',0.5])],
	[1.5,_y,11,1],
	{
		params ['_control','_newValue','_progCtrl','_textCtrl','_v'];
		missionNamespace setVariable ['mission_vd_fovRatio',_newValue];

		// force fov script to update
		missionNamespace setVariable ['mission_vd_lastFov',0];
	},
	6006
] call menus_fnc_addSlider;
_slider4 ctrlSetTooltip "AUTO FOV Terrain/Object ratio";

_y = _y + 1.5;


_slider6 = [
	[100,6000,50,(missionNamespace getVariable ['mission_vd_fovMin',500])],
	[1.5,_y,11,1],
	{
		params ['_control','_newValue','_progCtrl','_textCtrl','_v'];
		missionNamespace setVariable ['mission_vd_fovMin',_newValue];

		// force fov script to update
		missionNamespace setVariable ['mission_vd_lastFov',0];
	},
	6007
] call menus_fnc_addSlider;
_slider6 ctrlSetTooltip "AUTO FOV View distance MIN";

_y = _y + 1.5;


_slider5 = [
	[100,30000,50,(missionNamespace getVariable ['mission_vd_fovMax',3000])],
	[1.5,_y,11,1],
	{
		params ['_control','_newValue','_progCtrl','_textCtrl','_v'];
		missionNamespace setVariable ['mission_vd_fovMax',_newValue];

		// force fov script to update
		missionNamespace setVariable ['mission_vd_lastFov',0];
	},
	6008
] call menus_fnc_addSlider;
_slider5 ctrlSetTooltip "AUTO FOV View distance MAX";