/* ----------------------------------------------------------------------------
Function: respawn_fnc_respawnUnit

Description:
	respawns the player, even if unit is not local
TODO:
	sides / locations
Parameters:
0:	_unit	- player to respawn
Returns:
	nothing
Examples:
	_unit call respawn_fnc_respawnUnit;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_unit"];

// Exit if target unit does not exist or isNull or is not a man or is not dead
if (isNil "_unit" || {isNull _unit} || {!(_unit isKindOf "CAManBase")} || {!(_unit getVariable ["unit_respawn_dead",false])}) exitWith {};

// If unit is local run the onRespawnUnit script
if (local _unit) exitWith {
	_unit call respawn_fnc_onRespawnUnit;
};

// If unit is not local remotexec the script for the unit
_unit remoteExec ["respawn_fnc_onRespawnUnit",_unit];