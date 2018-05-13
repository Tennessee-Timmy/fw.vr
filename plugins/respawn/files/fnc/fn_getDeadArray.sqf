/* ----------------------------------------------------------------------------
Function: respawn_fnc_getDeadArray

Description:
	Returns the array of all dead players connected to the server for side(s)
	based on _unit getVariable ["unit_respawn_dead"]
	Defaults to all sides
Parameters:
0:	_sides - Array of sides
Returns:
	_deadUnits - array of dead units
Examples:
	[west,east] call respawn_fnc_getDeadArray;
	[] call respawn_fnc_getDeadArray
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

[_this] params [["_sides", [], [[]]]];
if (_sides isEqualTo []) then {
    _sides = [west,east,resistance,civilian];
};


// Check all players if they are on the side requested and then check if they are dead
private _deadUnits = PLAYERLIST select {
	(
	 	(_x call respawn_fnc_getSetUnitSide) in _sides
	) && {
		(_x call respawn_fnc_deadCheck)
	}
};

_deadUnits