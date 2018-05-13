/* ----------------------------------------------------------------------------
Function: tasks_fnc_end

Description:
	Ends the mission from server
	"mission_tasks_winSides" or "mission_tasks_winPlayers" must be defiened

Parameters:
0:	_win		- bool, true for win, false for lose
Returns:
	nothing
Examples:
	true call tasks_fnc_end;
	true remoteExec ["tasks_fnc_end",-2];

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params [["_win",true]];

if (_win) then {
	private _end = missionNamespace getVariable ["tasks_setting_ending_win",TASKS_SETTING_ENDING_WIN];
	_end call BIS_fnc_endMission;
} else {
	private _end = missionNamespace getVariable ["tasks_setting_ending_lose",TASKS_SETTING_ENDING_LOSE];
	_end call BIS_fnc_endMission;
};