/* ----------------------------------------------------------------------------
Function: respawn_fnc_onKilled

Description:
	Runs on units death
	Sets the _oldUnit "unit_respawn_dead" as true
	Disables the respawn button -does not work
	Runs respawn_fnc_runOnKilledScripts
Parameters:
0:	_oldUnit		- Unit which is dead
1:	_killer			- Killer
2:	_respawn		- Respawn type
3:	_respawnDelay	- Respawn delay
Returns:
	nothing
Examples:
	player addEventHandler ["Killed", {_this call respawn_fnc_onKilled;}];
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_oldUnit","_killer","_respawn","_respawnDelay"];

// Set unit as dead
_oldUnit setVariable ["unit_respawn_dead",true,true];

// Update dead player list with this units UID
//todo

// Run onKilled scripts
[_oldUnit,_killer,_respawn,_respawnDelay] call respawn_fnc_runOnKilledScripts;