/* ----------------------------------------------------------------------------
Function: tasks_fnc_setWinners

Description:
	Sets the winners for the mission
	"mission_tasks_winPlayers"
	or
	"mission_tasks_winSides" if _targets inserted are sides

	You can also insert the losers

Parameters:
0:	_target			- Side, group or player
1:	_winners		- True for winner, false for loser
Returns:
	nothing
Examples:
	// West will win
	[west,true] call tasks_fnc_setWinners;
	// player will win
	[player,true] call tasks_fnc_setWinners;
	// Everyone other than op_0_1 will win
	[op_0_1,false] call tasks_fnc_setWinners;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

if !(isServer) exitWith {};

params ["_target",["_winners",true]];

// Target is side
if (_target isEqualType sideEmpty) exitWith {

	if (_winners) then {
		missionNamespace setVariable ["mission_tasks_winSides",[_target],true];
	} else {

		private _winsides = [west,east,resistance,civilian,sideEmpty] - [_target];
		missionNamespace setVariable ["mission_tasks_winSides",_winsides,true];
	};
};

// Target is group
if (_target isEqualType grpNull) exitWith {

	private _targetUnits = (PLAYERLIST select {(group _x) isEqualTo _target});

	if (_winners) then {
		missionNamespace setVariable ["mission_tasks_winPlayers",_targetUnits,true];
	} else {
		_winUnits = PLAYERLIST - _targetUnits;
		missionNamespace setVariable ["mission_tasks_winPlayers",_winUnits,true];
	};
};

// Target is object/player
if (_target isEqualType objNull) exitWith {
	if (_winners) then {
		missionNamespace setVariable ["mission_tasks_winPlayers",[_target],true];
	} else {
		_winUnits = PLAYERLIST - [_target];
		missionNamespace setVariable ["mission_tasks_winPlayers",_winUnits,true];
	};
};