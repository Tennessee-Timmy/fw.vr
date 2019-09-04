/* ----------------------------------------------------------------------------
Function: respawn_fnc_srvDeadList

Description:
	Return a list of dead units based on side

Parameters:
0:	_sides		- Array of sides to check for dead players
Returns:
	_deadUnits	- Array of dead players for requested sides
Examples:
	[west,east] call respawn_fnc_srvDeadList;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

if !(isServer) exitWith {};
[_this] params [["_sides", [], [[]]]];
if (_sides isEqualTo []) then {
    _sides = [west,east,resistance,civilian];
};

// Get mission dead list from seed
private _mission_deadlist = ["mission_respawn_deadList",[]] call seed_fnc_getVars;

// init variable
private _deadUnits = [];

// Check all players if they are on the side requested and then check if they are dead
private _deadUnits = PLAYERLIST select {
	(
	 	(_x call respawn_fnc_getSetUnitSide) in _sides
	) && {
		(_x call respawn_fnc_deadCheck)
	}
};

_deadUnits