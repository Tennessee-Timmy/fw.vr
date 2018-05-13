/* ----------------------------------------------------------------------------
Function: respawn_fnc_base_respawn

Description:
	Sets the unit in it's teams base defined in settings

Parameters:
	none
Returns:
	nothing
Examples:
	call respawn_fnc_base_respawn;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_unit"];


// decide unit side
private _side = _unit call respawn_fnc_getSetUnitSide;

// Get the position for player side
private _posFrom = call {
	if (_side isEqualTo west) exitWith {(mission_respawn_base_location_west)};
	if (_side isEqualTo east) exitWith {(mission_respawn_base_location_east)};
	if (_side isEqualTo resistance) exitWith {(mission_respawn_base_location_resistance)};
	if (_side isEqualTo civilian) exitWith {(mission_respawn_base_location_civilian)};
};

// Use getpos ATL  so positions AND objects work
private _pos = getposATL _posFrom;
_pos params ["_x","_y","_z"];

// Add -1 to 1 for x and y. Add 0.1 to 1.1 for Z
_pos = [(_x + (2.5 - (random 5))),(_y + (2.5 - (random 5))),(_z + (0.25))];

// move the player to the spawn position
_unit setposATL _pos;
_unit setDir (random 360);

[_side,_pos] remoteExec ["respawn_fnc_notify",2];