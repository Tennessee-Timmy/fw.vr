/* ----------------------------------------------------------------------------
Function: respawn_instant_fnc_onRespawn

Description:
	Respawns the unit instantly
	Runs respawn_fnc_respawnUnit instantly

Parameters:
0:	_unit	- unit that will respawn
Returns:
	nothing
Examples:
	_unit call respawn_instant_fnc_onRespawn;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_unit"];

// Respawn unit if he's actually dead
if (_unit getVariable ["unit_respawn_dead",true]) then {
	_unit call respawn_fnc_respawnUnit;
};