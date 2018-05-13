/* ----------------------------------------------------------------------------
Function: tasks_fnc_list

Description:
	Returns the array of all tasks ( to be used in lists, duuh )

Parameters:
0:	_listState		- Array of strings Only list tasks in these states ('none','added','done','failed')
Returns:
	_taskListReturn		- Array containing:
		_taskName		- Name of the task (appears ingame)
		_taskVar		- Variable to access task with tasks_fnc_update
Examples:
	// return all tasks
	_allTasksList = [] call tasks_fnc_list;
	// return added tasks (not complete, not failed, but added to the list)
	_addedTasksList = ['added'] call tasks_fnc_list;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

[_this] params [["_listState", [], [[]]]];
if (_listState isEqualTo []) then {
    _listState = ['none','added','done','failed'];
};

// Get task list from mission ( we might not be the server, so can't get it from the server seed )
private _taskList = missionNamespace getVariable ["mission_tasks_currentVars",[]];
private _taskListReturn = [];

// Loop through all the tasks
private _nil = {
	private _taskArray = _x;
	_taskArray params ["_taskVar","_taskName",["_taskState","none"]];

	// if taskstate is in the required states, add it to the list
	if (_taskState in _listState) then {
		_taskListReturn pushBack [_taskName,_taskVar];
	};
	false
} count _taskList;

_taskListReturn