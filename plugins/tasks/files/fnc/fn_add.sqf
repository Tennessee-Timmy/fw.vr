/* ----------------------------------------------------------------------------
Function: tasks_fnc_add

Description:
	Adds a task
	Task will not overwrite.
	If all primary and secondary tasks are complete the mission will end!
	If 1 of the primary tasks fails or is canceled, the mission is failed!

	_taskVar must be unique.
	_taskVar can be used as a group for inheritence
	If you do not want a group, set _group as []

	Create a task with "taskMain" _taskVar and then 1 with
	_group = "taskMain" would create a task under tasksmain with the group "task2"

	This allows for missions to be divided into objectives and objectives to be divided into mission


Parameters:
0:	_taskVar		- Unique variable name for the task.

1:	_task			- Parameters for the task
	0:	_target 		- target to give task to (side, group, unit)

	1:	_group 			- string of parent _taskVar or []

	2:	_description 	- array:
		0:	_desc			- string, description
		1:	_dtitle			- string, title
		2:	_dMarker		- string, marker

	3:	_destination	- Destination (object, position or marker) or array:
		0:	_object			- Object to use as destination
		1:	_precision		- bool, false to use position known to owner

	4:	_type			- string, task type as defined in the CfgTaskTypes | https://community.bistudio.com/wiki/Arma_3_Tasks_Overhaul#Default_Task_Types:_Actions

	5:	_state 			- STRING: "CREATED","ASSIGNED","AUTOASSIGNED","SUCCEEDED","FAILED","CANCELED"


2:	_priority		- 1: Primary(critical, succeeds / fails mission),2: Secondary(must be completed, does not fail) 3: Optional(does not have to be completed, does not fail)

3:	_conditions		- Conditions for the task (runs on server)
	0:	_condAdd		- Condition which must be true for the task to be added
	1:	_condWin		- Condition which must be true for the task to be completed
	2:	_condLose		- Condition which must be true for the task to be failed
	3:	_respawn		- respawn units this task was given to on completion

4:	_code			- Code to run on certain stages of the task (runs on server)
	0:	_codeAdd		- Code to run when task is added
	1:	_codeWin		- Code to run when task is completed
	2:	_codeLose		- Code to run when task is failed


Returns:
	nothing
Examples:
	// Simple Task that will not auto-complete!
	["blu_task1",[west,[],["Do this task.","DO","domarker"]]] call tasks_fnc_add;
	// Add task complex
	[
		"blu_task1",
		[west,"","Do this task for me.",player,"Default",false],
		1,
		[{true},{false},{false}],
		[{},{},{}]
	] call tasks_fnc_add;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

if !(isserver) exitWith {};

params ["_taskVar","_task",["_priority",2],["_conditions",[{true},{false},{false}]],["_code",[{},{},{}]]];

private _defRespawn = missionNamespace getVariable ["mission_tasks_respawn",TASKS_SETTING_RESPAWN];
_task params ["_target",["_group",[]],"_description",["_destination",[]],["_type","default"],["_state","CREATED"]];
_conditions params [["_condAdd",{true}],["_condWin",{false}],["_condLose",{false}]];
_code params [["_codeAdd",{}],["_codeWin",{}],["_codeLose",{}],["_respawn",_defRespawn]];


if (_destination isEqualType objNull && {isNull _destination}) then {_destination = []};
if (_destination isEqualType [] && {(_destination param [0]) isEqualType objNull}) then {
	_destination = [];
};
/*
// if destination is an array and it's not a position
if ((_destination isEqualType []) && {!((count _destination) isEqualTo 3)}) then {
	_destination = [_destination,true];
};
*/

// lowercase the taskVar
_taskVar = toLower _taskVar;

// setup group
private _newGroup = [];

// If type is array
if (_group isEqualType []) then {

		// if array is empty, use taskvar(no parent), else use group as parent
	if (_group isEqualTo []) then {
		_newGroup = [_taskVar];
	} else {
		_newGroup pushBack _taskVar;
		_newGroup pushBack (_group select 0);
	};
} else {

	// If group is a string
	if (_group isEqualType '') then {

		// if string is empty, use taskvar(no parent), else use group as parent
		if (_group isEqualTo '') then {
			_newGroup = [_taskVar];
		} else {
			_newGroup = [_taskVar,_group];
		};
	};
};

// Make state uppercase
if (_state isEqualType '') then {
	_state = toUpper _state;
};

// Get task list from profile
_taskList = ["mission_tasks_list",[]] call seed_fnc_getVars;

// check if task already excists and quit if it does
private _matchedTask = (_taskList select {(_x param [0]) isEqualTo _taskVar}) param [0,""];
if !(_matchedTask isEqualTo "") exitWith {systemChat 'task with same ID already exists'};

private _currentState = 'none';
// Add new task to tasklist with all the info
_taskList pushBack [
	_taskVar,
	[_target,_newGroup,_description,_destination,_type,_state],
	_priority,
	[_condAdd,_condWin,_condLose],
	[_codeAdd,_codeWin,_codeLose,_respawn],
	_currentState
];

// Update tasks array on mission and profile
missionNamespace setVariable ["mission_tasks_list",_taskList,true];
["mission_tasks_list",_taskList] call seed_fnc_setVars;