/* ----------------------------------------------------------------------------
Function: tasks_fnc_endSrv

Description:
	Ends the mission from server
	"mission_tasks_winSides" or "mission_tasks_winPlayers" can be defined to	make certain players/sides winners
	Everyone else will be a loser.
	If "mission_tasks_winPlayers" is defined, side won't be used.
Parameters:
	none
Returns:
	nothing
Examples:
	call tasks_fnc_endSrv;
	remoteExec ["tasks_fnc_endSrv",2];

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

if !(isServer) exitWith {};

private _srvEndCodes = missionNamespace getVariable ["mission_tasks_srvEndCodes",[]];
{
	call _x;
	false
} count _srvEndCodes;

// Get winners
private _winSides = missionNamespace getVariable ["mission_tasks_winSides",TASKS_SETTING_ENDING_SIDES_AUTO];

private _winPlayers = [];
private _losePlayers = [];

// default winners based on side
private _nil = {
	if ((_x call respawn_fnc_getSetUnitSide) in _winSides) then {
		_winPlayers pushBack _x;
	};
	false
} count PLAYERLIST;

// get real winners
_winPlayers = missionNamespace getVariable ["mission_tasks_winPlayers",_winPlayers];

// get losers
private _nil = {
	if !(_x in _winPlayers) then {
		_losePlayers pushBack _x;
	};
	false
} count PLAYERLIST;

// stops task loop
missionNamespace setVariable ["tasks_serverLoop_running",false];

// endgame on other clients
[true] remoteExec ["tasks_fnc_end",_winPlayers];
[false] remoteExec ["tasks_fnc_end",_losePlayers];

[true] call tasks_fnc_end;