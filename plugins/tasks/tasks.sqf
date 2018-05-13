/* ----------------------------------------------------------------------------
tasks.sqf

Description:
	Add your tasks to this file.
	for more in-depth info read the header of fn_add.sqf in "files\fnc\"

	Mission will end once ALL primary and secondary tasks are complete. The winners will be automatic (TASKS_SETTINGS_ENDING_SIDES_AUTO) or "mission_tasks_winSides" or "mission_tasks_winPlayers"
		To also make the player win, add player to "mission_tasks_winPlayers"
	Mission will fail if a primary task is failed/cancled, winners will be everyone who the failed task was not assigned to.

	If target of the task is a group or a player, make it into string

Examples:
	// simple task, that will need to be ended manually (admin or zeus)
	["blu_task1",[west,[],["Do this task.","DO","domarker"]]] call tasks_fnc_add;
	// Add more complex task
	[
		"blu_task1",	//unique taskID
		[
			west,	// target (side,unit,group)
			[],		// parent taskID
			["Liberate the town by any means.","LIBERATE TOWN"],		// description
			town_3,		//location or object
			"Attack",	//https://community.bistudio.com/wiki/Arma_3_Tasks_Overhaul#Default_Task_Types:_Actions
			"CREATED"
		],
		1,			// priority (1 - critical; 2 - secondary 3 - optional)
		[{true},{false},{false}],	//{condition to add},{condition to win},{condition to lose}
		[{},{},{},false]				//{code on add},{code on win},{code on lose},(respawn on complete)
	] call tasks_fnc_add;

	To update a task state mid mission:
		// set blu_task1 as canceled
		["blu_task1","CANCELED"] remoteExec ["tasks_fnc_update",2];

	Possible states: "CREATED","SUCCEEDED","FAILED","CANCELED"
	MORE in fn_update.sqf

Author:
	nigel
---------------------------------------------------------------------------- */
#include "files\script_component.cpp"
// Script begins

// ----------------------------------------- TASK1 -----------------------------------------
// id
private _taskID = "blu_task1";
// task info
private _task = [
	west,	// target (side,unit,group)
	[],		// parent taskID
	["Liberate the town by any means.","LIBERATE TOWN"],		// description
	town_3,		//location or object
	"Attack",	//https://community.bistudio.com/wiki/Arma_3_Tasks_Overhaul#Default_Task_Types:_Actions
	"CREATED"
];

// conditions
private _conditions = [
	{true},		// condition to add the task
	{({(side _x isEqualTo east) && {(_x distanceSqr town_3) < 10000}} count allUnits) < 5},	// condition to succeed the task
	{!isNil "task1_fail"}		// condition to fail the task
];

// code to run
private _code = [
	{},		// code to run when task is added
	{
		missionNamespace setVariable ["mission_task1_complete",true,true];	// set a variable for the 2nd task
	},		// code to run when task is succeeded
	{},		// code to run when task is failed
	true	// respawns on completion
];

// Assemble the array and add the task
[
	_taskID,		// unique taskID
	_task,			// task info
	2,				// priority (1 critical/primary - [can't be failed],secondary - [can be failed],optional - [does not have to be completed])
	_conditions,	// conditions
	_code			// code to run
] call tasks_fnc_add;

// --------------------------------------- TASK1 END ---------------------------------------


// ----------------------------------------- TASK2 -----------------------------------------
// id
private _taskID = "blu_task2";
// task info
private _task = [
	west,	// target (side,unit or group)
	["blu_task1"],		// this task is a child to first task
	["Defend this town at all costs.","DEFEND TOWN"],		// description
	town_3,
	"Defend",
	"CREATED"
];

// conditions
private _conditions = [
	{
		!isNil "mission_task1_complete" && {mission_task1_complete}		// Task will only be added when mission_task1_complete is true
	},
	{false},	// This task will never autocomplete (completes in code below)
	{false}		// This task will never autofail
];

// code to run
private _code = [
	{
		[] spawn {
			sleep 10;		// after 60 seconds the task will be canceled
			["blu_task2","CANCELED"] remoteExec ["tasks_fnc_update",2];

		};
	},
	{missionNamespace setVariable ["mission_task2_complete",true,true];},
	{missionNamespace setVariable ["mission_task2_complete",true,true];},
	true
];

// Assemble the array and add the task
[_taskID,_task,2,_conditions,_code] call tasks_fnc_add;

// --------------------------------------- TASK2 END ---------------------------------------

// ----------------------------------------- TASK3 -----------------------------------------
[

// Unique task id
"blu_task3",
[

// target (side,unit,group)
west,
[

// Task parent
"blu_task2"
],
[

// Description
"You've been overwhelmed, retreat.",

// Title
"RETREAT!"
],

// Task destination
town_3,

// Task Icon
"Defend",

// Task state on creation
"CREATED"
],

// Priority
1,
[{

// Condition to add the task
!isNil "mission_task2_complete" && {mission_task2_complete}		// Task will only be added when mission_task1_complete is true
},{

// Condition to complete
private _aliveList = ALIVELIST;		// list of alive players
private _awayCount = {_x distance town_3 > 300}count _aliveList;	//count units that are 300m from the town_3
((count _aliveList) isEqualTo _awayCount)		// Compare amount of alive units to the amount of units away from
},{

// Condition to fail the task
false
},true]] call tasks_fnc_add;

// --------------------------------------- TASK3 END ---------------------------------------



//--- TASK4 ---
// This task will not auto-complete.
// It can only be set as complete by zeus/admin
// Only blu_0_1 will recieve this task (commander)
["blu_task4",["blu_0_1",[],["Tell a hilarious, funny joke!","Optional: TELL A JOKE"]],3] call tasks_fnc_add;
//--- TASK4 END ---

// quick 'n dirty
["blu_task5",[west,[],
["The commander is about to tell you a hilarious joke, this one will hurt your sides, better prepare yourself!",
"Optional: LISTEN TO JOKE"],
[],"listen"],
3,
[{!isNil "blu_0_1"},{false},{false}],
[{},{},{},false]
] call tasks_fnc_add;