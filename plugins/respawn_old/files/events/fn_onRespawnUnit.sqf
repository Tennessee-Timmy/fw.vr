/* ----------------------------------------------------------------------------
Function: respawn_fnc_onRespawnUnit

Description:
	respawns the unit best used locally, to ensure evrything works
	deadToggles the unit
TODO:
	sides / locations
Parameters:
0:	_unit	- unit to respawn
Returns:
	nothing
Examples:
	_unit call respawn_fnc_onRespawnUnit;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_unit"];

// Move unit to respawn marker, enable simulation allow damage
// todo sides / locations
// dead toggle

// Toggles unit dead state (allowdamage, enablesimulation)
_deadToggle = missionNamespace getVariable ["mission_respawn_deadToggle",{call respawn_fnc_deadToggle}];
[_unit] call _deadToggle;


// Run respawn location script (can be setPos or spawn screen or both) defined in mission_respawn_location
_locationScript = missionNamespace getVariable ["mission_respawn_location",{call respawn_fnc_base_respawn}];
_unit call _locationScript;

// Cancel any respawn scripts that are currently running as a failsafe
if !(isNil "mission_respawn_type_loaded") then {
	terminate mission_respawn_type_loaded;
};

// Run all respawn unit scripts
_unit call respawn_fnc_runOnRespawnUnitScripts;
