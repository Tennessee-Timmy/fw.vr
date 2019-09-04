/* ----------------------------------------------------------------------------
Function: respawn_fnc_default_respawn

Description:
	Sets the unit in it's teams respawn marker

Parameters:
	none
Returns:
	nothing
Examples:
	call respawn_fnc_default_respawn;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

// Code begins

params ["_unit"];

// decide unit side
_side = _unit call respawn_fnc_getSetUnitSide;

// Get the position for player side
_pos = call {
	if (_side isEqualTo west) exitWith {(getMarkerPos "respawn_west")};
	if (_side isEqualTo east) exitWith {(getMarkerPos "respawn_east")};
	if (_side isEqualTo resistance) exitWith {(getMarkerPos "respawn_resistance")};
	if (_side isEqualTo civilian) exitWith {(getMarkerPos "respawn_civilian")};
};

// move the player to the spawn position
_unit setPos _pos;
_unit setDir (random 360);