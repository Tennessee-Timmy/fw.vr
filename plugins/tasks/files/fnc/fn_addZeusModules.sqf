/* ----------------------------------------------------------------------------
Function: tasks_fnc_addZeusModules

Description:
	Add custom module to zeus
	Requires achilles

Parameters:
	none
Returns:
	nothing
Examples:
	// Use this to register custom modules
	call tasks_fnc_addZeusModules;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// code begins

// Leave if achilles is not loaded
if !(isClass (configFile >> "CfgPatches" >> "achilles_modules_f_achilles")) exitWith {};

["* Mission Tasks", "Update status",
{
	[] spawn {
		disableSerialization;
		missionNamespace setVariable ["tasks_menu_selectedTask",nil];
		missionNamespace setVariable ["tasks_menu_stateTask",nil];

	    private _newDisplay = (findDisplay 312) call menus_fnc_addDisplay;
		private _ctrlGroup = [[15,3,15,15],-1,_newDisplay] call menus_fnc_addGroup;
		private _background = [[0.2,0.2,0.2,1],[0,0,11.5,6.5],-1,_newDisplay,_ctrlGroup] call menus_fnc_addBackground;
		private _title = ["Update task status",[0,0,11.5,1],true,-1,_newDisplay,_ctrlGroup]call menus_fnc_addTitle;
		private _closeButton = ["x",[10.5,0,1,1],"(ctrlParent (_this select 0)) closeDisplay 1;",-1,_newDisplay,_ctrlGroup] call menus_fnc_addButton;

		// Select a task
		_dropList = [
			"Choose A Task to Update",
			[0.5,1.5,10.5,1],
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
				((findDisplay 1000) displayCtrl 6001) ctrlSetText(_this select 1);
				((findDisplay 1000) displayCtrl 6002) ctrlShow true;
			},
			true,
			6001,_newDisplay,_ctrlGroup
		] call menus_fnc_dropList;
		_dropList ctrlSetTooltip "Choose which task will be updated";

		// Select a state
		_dropList2 = [
			"New State",
			[0.5,3,5,1],
			{
				[
					["Reset",["CREATED","Reset"],"Task will be reset to uncompleted/unfailed"],
					["Succeeded",["SUCCEEDED","Succeeded"],"Task will be set as succeeded"],
					["Failed",["FAILED","Failed"],"Task will be set as failed"],
					["Canceled",["CANCELED","Canceled"],"Task will be set as canceled"]
				]
			},
			{
				missionNamespace setVariable ["tasks_menu_stateTask",(_this select 0)];
				((findDisplay 1000) displayCtrl 6002) ctrlSetText (_this select 1);
				((findDisplay 1000) displayCtrl 6003) ctrlShow true;
			},
			true,
			6002,
			_newDisplay,
			_ctrlGroup
		] call menus_fnc_dropList;
		_dropList2 ctrlSetTooltip "Select new task state";
		_dropList2 ctrlShow false;

		// Confirm changes
		private _tasksButton1 = ["Confirm Changes",[6,3,5,1],
			"
				_task = tasks_menu_selectedTask;
				_state = tasks_menu_stateTask;
				[_task,_state] remoteExec ['tasks_fnc_update',2];
				(ctrlParent (_this select 0)) closeDisplay 1;
			",
			6003,_newDisplay,_ctrlGroup
		] call menus_fnc_addButton;
		_tasksButton1 ctrlSetTooltip "Update the selected task with new state";
		_tasksButton1 ctrlShow false;
	};
}] call Ares_fnc_RegisterCustomModule;





// Set task location
["* Mission Tasks", "Update Location",
{
	hint 'TIP: This module can be placed on objects to use object position';
	disableSerialization;
    private _module_position = param [0,[0,0,0],[[]]];
    private _selected_object = param [1,ObjNull,[ObjNull]];
	private _position = _module_position;
	if !(_selected_object isEqualTo objNull) then {
		_position = _selected_object;
	};

    private _newDisplay = (findDisplay 312) call menus_fnc_addDisplay;
	private _ctrlGroup = [[15,3,15,15],-1,_newDisplay] call menus_fnc_addGroup;
	private _background = [[0.2,0.2,0.2,1],[0,0,11.5,5],-1,_newDisplay,_ctrlGroup] call menus_fnc_addBackground;
	private _title = ["Update task destination",[0,0,11.5,1],true,-1,_newDisplay,_ctrlGroup]call menus_fnc_addTitle;
	private _closeButton = ["x",[10.5,0,1,1],"(ctrlParent (_this select 0)) closeDisplay 1;",-1,_newDisplay,_ctrlGroup] call menus_fnc_addButton;

	// Select a task
	_dropList = [
		"Choose Task to move here!",
		[0.5,1.65,10.5,1],
		{
			private _array = [];
			private _nil = {
				_x params ["_name","_value"];
				private _toolTip = ('Update the destination of this task');
				_value = [_value,_name];
				_array pushBack [_name,_value,_toolTip];
				false
			} count ([] call tasks_fnc_list);
			_array
		},
		{
			private _newPos = ((findDisplay 1000) displayCtrl 6001) getVariable ["tasks_newPos",[]];
			[(_this select 0),nil,nil,_newPos] remoteExec ["tasks_fnc_update",2];
			(findDisplay 1000) closeDisplay 1;
		},
		true,
		6001,
		_newDisplay,
		_ctrlGroup
	] call menus_fnc_dropList;

	_dropList ctrlSetTooltip "Choose which task will recieve the new destination";
	_dropList setVariable ["tasks_newPos",_position];

}] call Ares_fnc_RegisterCustomModule;


// description update
["* Mission Tasks", "Update Description",
{
	[] spawn {
		disableSerialization;
		missionNamespace setVariable ["tasks_menu_selectedTask",nil];
		missionNamespace setVariable ["tasks_menu_stateTask",nil];

	    private _newDisplay = (findDisplay 312) call menus_fnc_addDisplay;
		private _ctrlGroup = [[15,3,15,15],-1,_newDisplay] call menus_fnc_addGroup;
		private _background = [[0.2,0.2,0.2,1],[0,0,11.5,9.5],-1,_newDisplay,_ctrlGroup] call menus_fnc_addBackground;
		private _title = ["Update task description",[0,0,11.5,1],true,-1,_newDisplay,_ctrlGroup]call menus_fnc_addTitle;
		private _closeButton = ["x",[10.5,0,1,1],"(ctrlParent (_this select 0)) closeDisplay 1;",-1,_newDisplay,_ctrlGroup] call menus_fnc_addButton;

		// Complete a task
		_dropList = [
			"Choose a Task to Update",
			[0.5,1.5,10.5,1],
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
				((findDisplay 1000) displayCtrl 6001) ctrlSetText(_this select 1);
				((findDisplay 1000) displayCtrl 6002) ctrlShow true;
				((findDisplay 1000) displayCtrl 6003) ctrlShow true;
				((findDisplay 1000) displayCtrl 6004) ctrlShow true;
			},
			true,
			6001,_newDisplay,_ctrlGroup
		] call menus_fnc_dropList;
		_dropList ctrlSetTooltip "Choose which task will be updated";

		// Title box
		_textBox = ["Insert task title here!",[0.5,3,10.5,1],6002,_newDisplay,_ctrlGroup] call menus_fnc_addTextBox;
		_textBox ctrlSetTooltip "Leave untouched or empty to keep original";
		_textBox ctrlShow false;

		_textBox2 = [("Insert task description here!"),[0.5,4.5,10.5,3],6003,_newDisplay,_ctrlGroup]call menus_fnc_addTextBox;
		_textBox2 ctrlSetTooltip "Leave untouched or empty to keep original!";
		_textBox2 ctrlShow false;

		private _tasksButton1 = ["Update!",[6,8,5,1],
			"
				private _task = tasks_menu_selectedTask;

				private _title = ctrlText ((findDisplay 1000) displayCtrl 6002);
				if (_title isEqualTo 'Insert task title here!') then {
					_title = nil;
				};

				private _description = ctrlText ((findDisplay 1000) displayCtrl 6003);
				if (_description isEqualTo ('Insert task description here!')) then {
					_description = nil;
				};

				[_task,nil,nil,nil,[_description,_title]] remoteExec ['tasks_fnc_update',2];

				(ctrlParent (_this select 0)) closeDisplay 1;
			",
			6004,_newDisplay,_ctrlGroup
		]call menus_fnc_addButton;
		_tasksButton1 ctrlSetTooltip "Update the selected task with the new description / title";
		_tasksButton1 ctrlShow false;
	};
}] call Ares_fnc_RegisterCustomModule;

// description update
["* Mission Tasks", "Add Task",
{
	_this spawn {
	    private _module_position = param [0,[0,0,0],[[]]];
	    private _selected_object = param [1,ObjNull,[ObjNull]];

		disableSerialization;
		missionNamespace setVariable ["tasks_menu_priority",nil];

	    private _newDisplay = (findDisplay 312) call menus_fnc_addDisplay;
		private _ctrlGroup = [[15,3,15,15],-1,_newDisplay] call menus_fnc_addGroup;
		private _background = [[0.2,0.2,0.2,1],[0,0,11.5,8],-1,_newDisplay,_ctrlGroup] call menus_fnc_addBackground;
		private _title = ["Add a new task",[0,0,11.5,1],true,-1,_newDisplay,_ctrlGroup]call menus_fnc_addTitle;
		private _closeButton = ["x",[10.5,0,1,1.2],"(ctrlParent (_this select 0)) closeDisplay 1;",-1,_newDisplay,_ctrlGroup] call menus_fnc_addButton;

		_textBox = [format["blu_task_%1",ceil random 100],[0.5,2,10.5,1],6001,_newDisplay,_ctrlGroup] call menus_fnc_addTextBox;
		_textBox ctrlSetTooltip "A unique variable to reference the task with";

		_textBox2 = ["west",[0.5,3.5,10.5,1],6002,_newDisplay,_ctrlGroup] call menus_fnc_addTextBox;
		_textBox2 setVariable ["tasks_target",_selected_object];
		_textBox2 ctrlSetTooltip "Target side, unit or group. Set as MODULE to use module target(task reciever)";

		_textBox3 = [('["Grab the loot from enemies!","GRAB BOOTY"]'),[0.5,5,10.5,1],6003,_newDisplay,_ctrlGroup]call menus_fnc_addTextBox;
		_textBox3 ctrlSetTooltip "ARRAY, [<DESCRIPTION>,<NAME>]";

		_dropList2 = [
			"Priority",
			[0.5,6.5,5,1],
			{
				[
					["Primary",[1,"Primary"],"Critical Task. Must be completed to win and failure will cause mission to end"],
					["Secondary",[2,"Secondary"],"Can be failed, required to be completed to win"],
					["Optional",[3,"Optional"],"Not required to win or lose"]
				]
			},
			{
				missionNamespace setVariable ["tasks_menu_priority",(_this select 0)];
				((findDisplay 1000) displayCtrl 6004) ctrlSetText (_this select 1);
				((findDisplay 1000) displayCtrl 6005) ctrlShow true;
			},
			true,
			6004,
			_newDisplay,
			_ctrlGroup
		] call menus_fnc_dropList;
		_dropList2 ctrlSetTooltip "Priority of the task";

		private _tasksButton1 = ["Add task",[6,6.5,5,1],
			"
				private _taskVar = ctrlText ((findDisplay 1000) displayCtrl 6001);
				private _target = ctrlText ((findDisplay 1000) displayCtrl 6002);
				if (_target isEqualTo 'MODULE') then {
					private _target = ((findDisplay 1000) displayCtrl 6002) getVariable ['tasks_target',objNull];
					if (_target isEqualTo objNull) exitWith {systemChat 'Adding new task failed. Invalid target'};
				};
				private _targetCheck = call compile _target;

				if (isNil '_targetCheck') exitWith{
					systemChat 'Adding new task failed. Invalid target.'
				};

				private _description = ctrlText ((findDisplay 1000) displayCtrl 6003);
				private _desc = call compile _description;
				if (!(_desc isEqualType [])||{!((count _desc) isEqualTo 2)}) exitWith {
					systemChat 'Adding new task failed. Invalid description/name';
					systemChat 'Try [""Destroy the cache"",""Destroy Cache""]';
				};
				_priority = missionNamespace getVariable ['tasks_menu_priority',3];

				[_taskVar,[_target,[],_desc],_priority] remoteExec ['tasks_fnc_add',2];

				(ctrlParent (_this select 0)) closeDisplay 1;
			",
			6005,_newDisplay,_ctrlGroup
		] call menus_fnc_addButton;
		_tasksButton1 ctrlSetTooltip "Task with your settings will be created";
		_tasksButton1 ctrlShow false;
	};
}] call Ares_fnc_RegisterCustomModule;
