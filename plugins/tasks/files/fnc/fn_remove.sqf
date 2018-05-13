/* ----------------------------------------------------------------------------
Function: tasks_fnc_remove

Description:
	Adds a task
	Task will not overwrite.

Parameters:
0:	_taskVar		- Unique variable name for the task.
1:	_onlyPlugin		- Task will only be removed from plugin list, it will continue to exist ingame
Returns:
	nothing
Examples:
	// Task that will be removed completely
	"blu_task1" call tasks_fnc_remove;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

if !(isserver) exitWith {};

params ["_taskVar",["_onlyPlugin",false]];

// lowercase the taskVar
_taskVar = toLower _taskVar;

// Find the current task from list
private _taskList = ["mission_tasks_list",[]] call seed_fnc_getVars;

// Search tasks_list
private _matchedTask = (_taskList select {((_x param [0])) isEqualTo (_taskVar)}) param [0,""];
if (_matchedTask isEqualTo "") exitWith {'tasks_fnc_remove cannot find task' call debug_fnc_log;};

private _taskName = _matchedTask param [0];

// remove the task from list
_taskList = _taskList - [_matchedTask];


// Search currentVars
private _mission_tasks_currentVars = missionNamespace getVariable ["mission_tasks_currentVars",[]];
private _searchResult = _mission_tasks_currentVars select {(_x param [0]) isEqualTo _taskVar};

// remove the task from list
_mission_tasks_currentVars = _mission_tasks_currentVars - _searchResult;
// Update current vars list
 missionNamespace setVariable ["mission_tasks_currentVars",_mission_tasks_currentVars,true];


// Update tasks array on mission and profile
missionNamespace setVariable ["mission_tasks_list",_taskList];
["mission_tasks_list",_taskList] call seed_fnc_setVars;

// Exit if task was to be only removed from plugin
if (_onlyPlugin) exitWith {};

// Remove task from ingame tasks
[_taskName] call BIS_fnc_deleteTask;