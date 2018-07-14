/* ----------------------------------------------------------------------------
Function: respawn_fnc_onRespawn

Description:
	Runs when unit "respawns", which happens 0.1 second after death
	Moves _newUnit to [0,0,50] and freezes him
	Sets _newUnit as dead
	Disallows damage from _newUnit
	Runs respawn_fnc_runOnRespawnScipts
Parameters:
0:	_newUnit		- New Unit
1:	_oldUnit		- Old unit
2:	_respawn		- Respawn type
3:	_respawnDelay	- Respawn delay
Returns:
	nothing
Examples:
	player addEventHandler ["Respawn", {_this call respawn_fnc_onRespawn;}];
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_newUnit","_oldUnit","_respawn","_respawnDelay"];

if (isNil "_oldUnit") then {_oldUnit = _newUnit};
// Set unit side
_nul = _newUnit call respawn_fnc_getSetUnitSide;

// todo move this to spectator scripts maybe
// toggle unit dead state

// sets newunit as dead, moves him to 0,0,50 and disables simulation and damage
// todo allow changing this
_deadToggle = missionNamespace getVariable ["mission_respawn_deadToggle",{call respawn_fnc_deadToggle}];
[_newUnit,true] call _deadToggle;

// Respawn type

// Cancel any respawn type scripts that are currently running
if !(isNil "mission_respawn_type_loaded") then {
	terminate mission_respawn_type_loaded;
};

// Call respawn type code
// Code/function must be {code}

// Defaults to instant respawn type
_spawnScript = missionNamespace getVariable ["mission_respawn_type",{}];
mission_respawn_type_loaded = _newUnit call _spawnScript;

// Run all respawn scripts
[_newUnit,_oldUnit] call respawn_fnc_runOnRespawnScripts;