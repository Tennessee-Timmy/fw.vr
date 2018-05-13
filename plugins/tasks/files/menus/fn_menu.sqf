/* ----------------------------------------------------------------------------
Function: tasks_fnc_menu

Description:
	Creates the dialog in the mission menu (menus plugin)

Parameters:
	none
Returns:
	nothing
Examples:
	call tasks_fnc_menu;
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
private _title = ["ADMIN TASKS MENU",[0,0,14,1.2],true]call menus_fnc_addTitle;

missionNamespace setVariable ["tasks_menu_selectedTask",nil];
missionNamespace setVariable ["tasks_menu_stateTask",nil];




// Update tasks
_dropList = [
	"Choose A Task to Update",
	[1.5,1.5,11,1],
	{
		private _array = [];
		private _nil = {
			_x params ["_name","_value"];
			private _toolTip = ('Select this task to be updated');
			_value = [_value,_name];
			_array pushBack [_name,_value,_toolTip];
			false
		} count ([] call tasks_fnc_list);
		_array
	},
	{
		missionNamespace setVariable ["tasks_menu_selectedTask",(_this select 0)];
		ctrlSetText [6001, (_this select 1)];
		ctrlShow [6002, true];
		ctrlShow [6004, true];
		ctrlShow [6005, true];
		ctrlShow [6006, true];
		ctrlShow [6007, true];
	},
	true,
	6001
] call menus_fnc_dropList;
_dropList ctrlSetTooltip "Choose which task will be updated";

_dropList2 = [
	"New State",
	[1.5,3,5,1],
	{
		[
			["Reset",["CREATED","Reset"],"Task will be reset to uncompleted/unfailed"],
			["Succeeded",["SUCCEEDED","Succeeded"],"Task will be set as succeeded"],
			["Failed",["FAILED","Failed"],"Task will be set as failed"],
			["Canceled",["CANCELED","Cancled"],"Task will be set as canceled"]
		]
	},
	{
		missionNamespace setVariable ["tasks_menu_stateTask",(_this select 0)];
		ctrlSetText [6002, (_this select 1)];
		ctrlShow [6003, true];
	},
	true,
	6002
] call menus_fnc_dropList;
_dropList2 ctrlSetTooltip "Select new task state";
_dropList2 ctrlShow false;

private _tasksButton1 = ["Update!",[7.5,3,5,1],"
	_task = tasks_menu_selectedTask;
	_state = tasks_menu_stateTask;
	[_task,_state] remoteExec ['tasks_fnc_update',2];
",6003]call menus_fnc_addButton;
_tasksButton1 ctrlSetTooltip "Update the selected task with new state";
_tasksButton1 ctrlShow false;




// Change description
private _title2 = ["Change Description",[0,4.5,14,1],true,6007]call menus_fnc_addTitle;
_title2 ctrlShow false;

_textBox = ["Insert task title here!",[0.5,6,13,1],6004] call menus_fnc_addTextBox;
_textBox ctrlSetTooltip "Leave untouched or empty to keep original";
_textBox ctrlShow false;

_textBox2 = [("Insert task description here!"+ endl + ""),[0.5,7.5,13,2],6005]call menus_fnc_addTextBox;
_textBox2 ctrlSetTooltip "Leave untouched or empty to keep original!";
_textBox2 ctrlShow false;

private _tasksButton1 = ["Update Description!",[2,10,10,1],
	"
		private _task = tasks_menu_selectedTask;

		private _title = ctrlText ((findDisplay 304000) displayCtrl 6002);
		if (_title isEqualTo 'Insert task title here!') then {
			_title = nil;
		};

		private _description = ctrlText ((findDisplay 304000) displayCtrl 6003);
		if (_description isEqualTo ('Insert task description here!')) then {
			_description = nil;
		};

		[_task,nil,nil,nil,[_description,_title]] remoteExec ['tasks_fnc_update',2];

		(ctrlParent (_this select 0)) closeDisplay 1;
	",
	6006
]call menus_fnc_addButton;
_tasksButton1 ctrlSetTooltip "Update the selected task with the new description / title";
_tasksButton1 ctrlShow false;




// New task
missionNamespace setVariable ["tasks_menu_priority",nil];
private _title = ["Add a new task",[0,11.5,14,1],true,-1]call menus_fnc_addTitle;

_textBox = [format["blu_task_%1",ceil random 100],[0.5,13,10.5,1],7001] call menus_fnc_addTextBox;
_textBox ctrlSetTooltip "A unique variable to reference the task with";

_textBox2 = ["west",[0.5,14.5,10.5,1],7002] call menus_fnc_addTextBox;
_textBox2 ctrlSetTooltip "Target side, unit or group.";

_textBox3 = [('["Grab the loot from enemies!","GRAB BOOTY"]'),[0.5,16,10.5,1],7003]call menus_fnc_addTextBox;
_textBox3 ctrlSetTooltip "ARRAY, [<DESCRIPTION>,<NAME>]";

_dropList2 = [
	"Priority",
	[0.5,17.5,5,1],
	{
		[
			["Primary",[1,"Primary"],"Critical Task. Must be completed to win and failure will cause mission to end"],
			["Secondary",[2,"Secondary"],"Can be failed, required to be completed to win"],
			["Optional",[3,"Optional"],"Not required to win or lose"]
		]
	},
	{
		missionNamespace setVariable ["tasks_menu_priority",(_this select 0)];
		((findDisplay 304000) displayCtrl 7004) ctrlSetText (_this select 1);
		((findDisplay 304000) displayCtrl 7005) ctrlShow true;
	},
	true,
	7004
] call menus_fnc_dropList;
_dropList2 ctrlSetTooltip "Priority of the task";

private _tasksButton1 = ["Add task",[6,17.5,5,1],
	"
		private _taskVar = ctrlText ((findDisplay 304000) displayCtrl 7001);
		private _target = ctrlText ((findDisplay 304000) displayCtrl 7002);
		private _targetCheck = call compile _target;

		if (isNil '_targetCheck') exitWith{
			systemChat 'Adding new task failed. Invalid target.'
		};

		private _description = ctrlText ((findDisplay 304000) displayCtrl 7003);
		private _desc = call compile _description;
		if (!(_desc isEqualType [])||{!((count _desc) isEqualTo 2)}) exitWith {
			systemChat 'Adding new task failed. Invalid description/name';
			systemChat 'Try [""Destroy the cache"",""Destroy Cache""]';
		};
		_priority = missionNamespace getVariable ['tasks_menu_priority',3];

		[_taskVar,[_target,[],_desc],_priority] remoteExec ['tasks_fnc_add',2];
	",
	7005
] call menus_fnc_addButton;
_tasksButton1 ctrlSetTooltip "Task with your settings will be created";
_tasksButton1 ctrlShow false;

// End mission
private _title = ["End Mission",[0,19,14,1],true,-1]call menus_fnc_addTitle;
private _extender = ["",[0,19,14,10],false,-1]call menus_fnc_addTitle;

_endList = [
	"Winner ending",
	[0.5,20.5,5,1],
	{
		call tasks_fnc_getEndings;
	},
	{
		missionNamespace setVariable ["tasks_setting_ending_win",(_this select 0)];
		((findDisplay 304000) displayCtrl 8001) ctrlSetText (_this select 1);
	},
	true,
	8001
] call menus_fnc_dropList;
_endList ctrlSetTooltip "Choose winner ending";


_endList2 = [
	"Loser ending",
	[7.5,20.5,5,1],
	{
		call tasks_fnc_getEndings;
	},
	{
		missionNamespace setVariable ["tasks_setting_ending_lose",(_this select 0)];
		((findDisplay 304000) displayCtrl 8002) ctrlSetText (_this select 1);
	},
	true,
	8002
] call menus_fnc_dropList;
_endList2 ctrlSetTooltip "Choose loser ending.";


private _titleend = ["Winning sides:",[0,21.5,5,1],false,-1]call menus_fnc_addTitle;
_titleend ctrlSetTooltip "Select no one to make everyone lose!";

_checkbox1 = _display ctrlCreate ["menus_template_checkBox",8011,_controlGroup];
_checkbox1 ctrlSetPosition [(1. * _GUI_GRID_W),(23*_GUI_GRID_H)];
_checkbox1 ctrlSetBackgroundColor [0,0,1,1];
_checkbox1 ctrlSetActiveColor [0,0,1,1];
_checkbox1 ctrlSetTextColor [0,0,1,1];
_checkbox1 ctrlSetForegroundColor [0,0,1,1];
_checkbox1 ctrlSetTooltipColorBox [0,0,1,1];
_checkbox1 ctrlSetTooltipColorText [0,0,1,1];
_checkbox1 ctrlCommit 0;
_checkbox1 ctrlSetTooltip "Everyone on blufor will be a winner";

_checkbox2 = _display ctrlCreate ["menus_template_checkBox",8012,_controlGroup];
_checkbox2 ctrlSetPosition [(4.5 * _GUI_GRID_W),(23*_GUI_GRID_H)];
_checkbox2 ctrlSetBackgroundColor [0.9,0,0,1];
_checkbox2 ctrlSetActiveColor [0.9,0,0,1];
_checkbox2 ctrlSetTextColor [0.9,0,0,1];
_checkbox2 ctrlSetForegroundColor [0.9,0,0,1];
_checkbox2 ctrlSetTooltipColorBox [0.9,0,0,1];
_checkbox2 ctrlSetTooltipColorText [0.9,0,0,1];
_checkbox2 ctrlCommit 0;
_checkbox2 ctrlSetTooltip "Everyone on opfor will be a winner";

_checkbox3 = _display ctrlCreate ["menus_template_checkBox",8013,_controlGroup];
_checkbox3 ctrlSetPosition [(7.5 * _GUI_GRID_W),(23*_GUI_GRID_H)];
_checkbox3 ctrlSetBackgroundColor [0,0.8,0,1];
_checkbox3 ctrlSetActiveColor [0,0.8,0,1];
_checkbox3 ctrlSetTextColor [0,0.8,0,1];
_checkbox3 ctrlSetForegroundColor [0,0.8,0,1];
_checkbox3 ctrlSetTooltipColorBox [0,0.8,0,1];
_checkbox3 ctrlSetTooltipColorText [0,0.8,0,1];
_checkbox3 ctrlCommit 0;
_checkbox3 ctrlSetTooltip "Everyone on indfor will be a winner";

_checkbox4 = _display ctrlCreate ["menus_template_checkBox",8014,_controlGroup];
_checkbox4 ctrlSetPosition [(10.5 * _GUI_GRID_W),(23*_GUI_GRID_H)];
_checkbox4 ctrlSetBackgroundColor [0.4,0,0.5,1];
_checkbox4 ctrlSetActiveColor [0.4,0,0.5,1];
_checkbox4 ctrlSetTextColor [0.4,0,0.5,1];
_checkbox4 ctrlSetForegroundColor [0.4,0,0.5,1];
_checkbox4 ctrlSetTooltipColorBox [0.4,0,0.5,1];
_checkbox4 ctrlSetTooltipColorText [0.4,0,0.5,1];
_checkbox4 ctrlCommit 0;
_checkbox4 ctrlSetTooltip "Everyone on civilian will be a winner";

private _endbutton = ["END MISSION",[2,24.5,10,1],
	"
		private _west = cbChecked ((findDisplay 304000) displayCtrl 8011);
		private _east = cbChecked ((findDisplay 304000) displayCtrl 8012);
		private _guer = cbChecked ((findDisplay 304000) displayCtrl 8013);
		private _civ = cbChecked ((findDisplay 304000) displayCtrl 8014);
		private _winners = [];

		if (_west) then {
			_winners pushBack west;
		};
		if (_east) then {
			_winners pushBack east;
		};
		if (_guer) then {
			_winners pushBack independent;
		};
		if (_civ) then {
			_winners pushBack civilian;
		};

		missionNamespace setVariable ['mission_tasks_winSides',_winners];
		remoteExec ['tasks_fnc_endSrv',2];
	",
	8003
] call menus_fnc_addButton;
_endbutton ctrlSetTooltip "CAUTION! The mission will END";
/*
_endList3 = [
	"Winner Side",
	[2,21.5,10,1],
	{
		[
			["BLUFOR",[[west],"BLUFOR"],"All blufor will win, everyone else will lose"],
			["OPFOR",[[east],"OPFOR"],"All opfor will win, everyone else will lose"],
			["INDFOR",[[independent],"INDFOR"],"All independent will win, everyone else will lose"],
			["CIV",[[civilian],"CIV"],"All civilans will win, everyone else will lose"],
			["BLUFOR & OPFOR",[[west,east],"BLUFOR & OPFOR"],"All blufor and opfor will win, everyone else will lose"],
			["BLUFOR & INDFOR",[[west,resistance],"BLUFOR & INDFOR"],"All blufor and opfor will win, everyone else will lose"],
			["BLUFOR & CIV",[[west,civilian],"BLUFOR & CIV"],"All blufor and civilians will win, everyone else will lose"],

			["BLUFOR & OPFOR & INDFOR",[[west,east,resistance],"BLUFOR & OPFOR & INDFOR"],"All blufor,opfor, indep. will win, everyone else will lose"],
			["BLUFOR & OPFOR & INDFOR",[[west,east,resistance],"BLUFOR & OPFOR & INDFOR"],"All blufor,opfor, indep. will win, everyone else will lose"],
			["BLUFOR & OPFOR & INDFOR & CIVILIAN",[[west,east,resistance],"BLUFOR & OPFOR & INDFOR"],"All blufor,opfor, indep. will win, everyone else will lose"],

			["OPFOR & INDFOR",[[east],"OPFOR"],"All opfor will win, everyone else will lose"]
		]
	},
	{
		missionNamespace setVariable ["mission_tasks_winSides",[(_this select 0)]];
		((findDisplay 304000) displayCtrl 8003) ctrlSetText (_this select 1);
	},
	true,
	8003
] call menus_fnc_dropList;
_endList3 ctrlSetTooltip "Choose loser ending";
*/