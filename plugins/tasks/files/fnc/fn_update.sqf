/* ----------------------------------------------------------------------------
Function: tasks_fnc_update

Description:
	Updates the task state and/or conditions
	nil to keep some parts the same
	Setting a primary task as cancled or failed will fail the mission(default)

Parameters:
0:	_taskVar		- Unique variable name for the task to update

1:	_stateNew 			- STRING: "CREATED","ASSIGNED","AUTOASSIGNED","SUCCEEDED","FAILED","CANCELED"

2:	_newConditions		- Conditions for the task (runs on server)
	0:	_newCondAdd		- Condition which must be true for the task to be added
	1:	_newCondWin		- Condition which must be true for the task to be completed
	2:	_newCondLose		- Condition which must be true for the task to be failed

3:	_newDestination		- Destination (object, position or marker) or array:
		0:	_object			- Object to use as destination
		1:	_precision		- bool, false to use position known to owner

4:	_newDescription		- Description
	0:	_newDesc				- string, description
	1:	_newDTitle				- string, title

Returns:
	nothing
Examples:
	// Task will be completed
	["blu_task1","SUCCEEDED"] remoteExec ["tasks_fnc_update",2];

	// Task will get new condition {true}, which means it will automatically complete
	["blu_task1",nil,[{true},{true}]] remoteExec ["tasks_fnc_update",2];

	// Task will get new destination
	["blu_task1",nil,nil,player] remoteExec ["tasks_fnc_update",2];

	// Task will get new description
	["blu_task1",nil,nil,nil,["Ohh my, oh my, where are my manners?","Excuse me"]] remoteExec ["tasks_fnc_update",2];

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

if !(isserver) exitWith {};

params ["_taskVarNew"];

// lowercase the taskVar
_taskVarNew = toLower _taskVarNew;

// Find the current task from list
private _taskList = ["mission_tasks_list",[]] call seed_fnc_getVars;

private _matchedTask = (_taskList select {((_x param [0])) isEqualTo (_taskVarNew)}) param [0,""];
if (_matchedTask isEqualTo "") exitWith {'tasks_fnc_update cannot find task' call debug_fnc_log;};

// remove the task from list
_taskList = _taskList - [_matchedTask];

// get old values
_matchedTask params ["_taskVarOld","_task","_priority","_conditionsOld","_code","_currentState"];

// get old values to save later...
_task params ["_target","_group","_description",["_destination",[]],["_type","default"],["_state","CREATED"]];
_conditionsOld params [["_condAdd",{true}],["_condWin",{false}],["_condLose",{false}]];
_code params [["_codeAdd",{}],["_codeWin",{}],["_codeLose",{}],["_respawn",false]];
_description params [["_desc",''],["_dtitle",'']];

// get new values (use old as defaults)
_this params ["_taskVarNew",["_stateNew",_state],["_newConditions",_conditionsOld],["_newDestination",_destination],["_newDescription",_description]];
_newConditions params [["_newCondAdd",_condAdd],["_newCondWin",_condWin],["_newCondLose",_condLose]];
_newDescription params [["_newDesc",_desc],["_newDTitle",_dtitle]];


if (_newDesc isEqualTo "") then {
	_newDesc = _desc;
};
if (_newDTitle isEqualTo "") then {
	_newDTitle = _dtitle;
};

// Check if description has changed and if so, update description
if (!(_newDesc isEqualTo _desc) || {!(_newDTitle isEqualTo _dtitle)}) then {
	[_taskVarNew, [_newDesc,_newDTitle,""]] call BIS_fnc_taskSetDescription;
	_newDescription = [_newDesc,_newDTitle];
};


// if state is empty string (not nil) set it as old state
if (_stateNew isEqualTo "") then {
	_stateNew = _state;
};

// Make state uppercase
if (_stateNew isEqualType "") then {
	_stateNew = toUpper _stateNew;
};

private _currentStateNew = _currentState;

if !(_stateNew isEqualTo _state) then {

	private _taskID = [_taskVarNew, _stateNew,true] spawn BIS_fnc_taskSetState;

	call {

		// get tasktarget
		private _taskTarget = _target;
		if (_taskTarget isEqualType "") then {
			_taskTarget = call compile _taskTarget;
		};
		if ((toUpper _stateNew) isEqualTo "SUCCEEDED") exitWith {
			call _codeWin;
			_currentStateNew = 'done';
			if (_respawn && ("respawn" in mission_plugins)) then {
				[_taskTarget] call respawn_fnc_respawn;
			};

		};
		if ((toUpper _stateNew) in ["ASSIGNED","CREATED","AUTOASSIGNED","RESET"]) exitWith {
			_currentStateNew = 'added';
		};
		if ((toUpper _stateNew) in ["FAILED","CANCELED"]) exitWith {
			if (_priority isEqualTo 1) then {

				// end mission if auto ending is enabled
				private _endingEnabled = missionNamespace getVariable ["tasks_setting_ending_enable",TASKS_SETTING_ENDING_ENABLE];
				if (_endingEnabled) then {


					[_taskTarget,false] call tasks_fnc_setWinners;

					call {
						// make sure the game has started before changing task status
						if (time < 15) exitWith {};
					};
					// call the ending
					call tasks_fnc_endSrv;
				};
			};
			call _codeLose;
			_currentStateNew = 'failed';
		};
	};
};

// If new dest. is a object, make it into array.
if (_newDestination isEqualType objNull && {!(isNull _newDestination)}) then {
	_newDestination = [_newDestination,true];
};

// if new dest. is not exactly the same as old dest. update destination
if !(_newDestination isEqualTo _destination) then {
	// update destination
	[_taskVarNew,_newDestination] call BIS_fnc_taskSetDestination;
};

// Add updated info to tasklist with all the info
_taskList pushBack [
	_taskVarNew,
	[_target,_group,_newDescription,_newDestination,_type,_stateNew],
	_priority,
	[_newCondAdd,_newCondWin,_newCondLose],
	[_codeAdd,_codeWin,_codeLose,_respawn],
	_currentStateNew
];

// Update tasks array on mission and profile
missionNamespace setVariable ["mission_tasks_list",_taskList,true];
["mission_tasks_list",_taskList] call seed_fnc_setVars;


// Check currentvars
private _mission_tasks_currentVars = missionNamespace getVariable ["mission_tasks_currentVars",[]];
private _searchResult = _mission_tasks_currentVars select {(_x param [0]) isEqualTo _taskVarNew};

// check if search result already exists
if !(_searchResult isEqualTo []) then {

	// check if searchresult has changed
	if !(_searchResult isEqualTo [_taskVarNew,(_newDTitle),_currentStateNew]) then {

		// Remove old search result from current vars
		_mission_tasks_currentVars = _mission_tasks_currentVars - _searchResult;

		// Add new vars to currentVars
		_mission_tasks_currentVars pushBack [_taskVarNew,(_newDTitle),_currentStateNew];
	};
};

// Update current vars list, if it's changed
if !(_mission_tasks_currentVars isEqualTo mission_tasks_currentVars) then {
	missionNamespace setVariable ["mission_tasks_currentVars",_mission_tasks_currentVars,true];
};
