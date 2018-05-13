/* ----------------------------------------------------------------------------
Function: tasks_fnc_loop

Description:
	Loops through tasks, creates, wins, fails etc.

Parameters:
	none
Returns:
	nothing
Examples:
	call tasks_fnc_loop;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

if !(isserver) exitWith {};


private _mission_tasks_currentVars = missionNamespace getVariable ["mission_tasks_currentVars",[]];

private _taskList = ["mission_tasks_list",[]] call seed_fnc_getVars;
private _taskListNew = [];


private _countPrimary = 0;
private _countPrimaryComplete = 0;

private _countSecondary = 0;
private _countSecondaryComplete = 0;

private _taskTarget = nil;

private _nil = {

	// get values
	_x params ["_taskVar","_task",["_priority",1],"_conditions","_code",["_currentState",'none']];

	// get values to save later...
	_task params ["_target","_group","_description",["_destination",[]],["_type","default"],["_state","CREATED"]];
	_conditions params [["_condAdd",{true}],["_condWin",{false}],["_condLose",{false}]];
	_code params [["_codeAdd",{}],["_codeWin",{}],["_codeLose",{}],["_respawn",false]];

	if (_destination isEqualType objNull && {isNull _destination}) then {_destination = []};
	if (_destination isEqualType [] && {(_destination param [0]) isEqualType objNull}) then {
		_destination = [];
	};

	// Search current vars for this taskVar
	private _searchResult = _mission_tasks_currentVars select {(_x param [0]) isEqualTo _taskVar};

	// Task main handler
	call {

		// Check the target, to make sure it exists
		_taskTarget = _target;

		// if taskTarget is a string and compiling it produces nothing, quit
		if (_taskTarget isEqualType "" && {isNil {call compile _taskTarget}}) exitWith {};
		while {(_taskTarget isEqualType "")} do {
			_taskTarget = call compile _taskTarget;
		};


		// If task state is none or it was not in search results
		if (_currentState isEqualTo 'none' || {(_searchResult isEqualTo [])}) exitWith {

			if (call _condAdd) then {

				if !(_description isEqualType []) then {
					_description = [_description];
				};

				// Skip the task if target is not there yet. (for ex. a player is not slotted)
				if (isNil "_taskTarget" || {([_taskTarget] isEqualTypeArray [objNull,grpNull]) && {isNull _taskTarget}}) exitWith {};

				private _taskID = [
					_taskTarget,	//target
					_group,			//name
					_description,	//description
					_destination,	//destination
					_state,			//state
					0,				//priority
					true,			//show notification
					_type,			//image type
					true			//share
				] call BIS_fnc_taskCreate;

				// Call added code
				call _codeAdd;

				// Task was just created, set the currentstate as added
				_currentState = 'added';
			} else {
				_currentState = 'none';
			};

			// Add to the list of tasks added in this mission
			_mission_tasks_currentVars pushBack [_taskVar,(_description param [1]),_currentState];
		};

		// make sure the game has started before changing task status
		if (time < 15) exitWith {};

		// Check if task is done yet
		if (!(_currentState isEqualTo 'done') && {call _condWin}) then {
			private _taskIDUpdate = [_taskVar, "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
			call _codeWin;
			_currentState = 'done';
			if (_respawn && ("respawn" in mission_plugins)) then {
				[_taskTarget] call respawn_fnc_respawn;
			};
		};

		// Check if task is failed yet
		if (!(_currentState isEqualTo 'failed') && {call _condLose}) then {
			private _taskIDUpdate = [_taskVar, "FAILED",true] spawn BIS_fnc_taskSetState;
			call _codeLose;
			_currentState = 'failed';

			if (_priority isEqualTo 1) then {

				// end mission if auto ending is enabled
				private _endingEnabled = missionNamespace getVariable ["tasks_setting_ending_enable",TASKS_SETTING_ENDING_ENABLE];
				if (_endingEnabled) then {

					// everryone other than the target will win
					[_taskTarget,false] call tasks_fnc_setWinners;

					// call the ending
					call tasks_fnc_endSrv;
				};
			};
		};
	};

	// Count primary tasks
	if (_priority isEqualTo 1) then {
		_countPrimary = _countPrimary + 1;
		if (_currentState isEqualTo 'done') then {
			_countPrimaryComplete = _countPrimaryComplete + 1;
		};
	};
	// Count secondary tasks
	if (_priority isEqualTo 2) then {
		_countSecondary = _countSecondary + 1;
		if (_currentState in ['done','failed']) then {
			_countSecondaryComplete = _countSecondaryComplete + 1;
		};
	};

	// check if search result already exists
	if !(_searchResult isEqualTo []) then {

		// check if searchresult has changed
		if !(_searchResult isEqualTo [_taskVar,(_description param [1]),_currentState]) then {

			// Remove old search result from current vars
			_mission_tasks_currentVars = _mission_tasks_currentVars - _searchResult;

			// Add new vars to currentVars
			_mission_tasks_currentVars pushBack [_taskVar,(_description param [1]),_currentState];
		};
	};

	// add new updated data to new list
	_taskListNew pushBack [
		_taskVar,
		[_target,_group,_description,_destination,_type,_state],
		_priority,
		[_condAdd,_condWin,_condLose],
		[_codeAdd,_codeWin,_codeLose,_respawn],
		_currentState
	];
	false
} count _taskList;

// Check if all tasks are complete yet
if ((_countSecondary isEqualTo _countSecondaryComplete) && {_countPrimaryComplete isEqualTo _countPrimary}) then {

	// check if auto ending is enabled
	private _endingEnabled = missionNamespace getVariable ["tasks_setting_ending_enable",TASKS_SETTING_ENDING_ENABLE];
	if (_endingEnabled && time > 10) then {

		call {
			// make sure the game has started before changing task status
			if (time < 15) exitWith {};

			// Target will win, everyone else lose !
			// todo, this will not work, because we don't know which task was last checked...
			[_taskTarget,true] call tasks_fnc_setWinners;
			// end the mission
			call tasks_fnc_endSrv;
		};
	};
};

// Update current vars list, if it's changed
if (isNil "mission_tasks_currentVars" || {!(_mission_tasks_currentVars isEqualTo mission_tasks_currentVars)}) then {
	missionNamespace setVariable ["mission_tasks_currentVars",_mission_tasks_currentVars,true];
};
if (isNil "mission_tasks_currentVars") then {
	mission_tasks_currentVars = [];
};

// Update tasks array on mission and profile
missionNamespace setVariable ["mission_tasks_list",_taskListNew,true];
["mission_tasks_list",_taskListNew] call seed_fnc_setVars;