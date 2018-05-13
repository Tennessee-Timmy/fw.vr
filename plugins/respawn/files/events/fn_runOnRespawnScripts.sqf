/* ----------------------------------------------------------------------------
Function: respawn_fnc_runOnRespawnScripts

Description:
	Runs "mission_respawn_type" from missionNamespace
	Gathers "unit_onRespawn_scripts" from unit
	Gathers "mission_onRespawn_scripts" from missionNamespace
	Calls the scripts
	"mission_onRespawn_enableDefaultScripts" and
	"onRespawn_enableDefaultScripts" from _oldUnit
	Are both checked to use "mission_onRespawn_scripts"
	The _oldUnit one overrides mission
Parameters:
0:	_newUnit	- New unit that will be used from now on
1:	_oldUnit	- old unit that is now dead and not used
Returns:
	nothing
Examples:
	[_newUnit,_oldUnit] call respawn_fnc_runOnRespawnScripts;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_newUnit","_oldUnit"];

// Setup the array so it won't be edited
private _onRespawnScripts = [];

// Gather all scripts
private _unit_onRespawnScripts = (_oldUnit getVariable ["unit_onRespawn_scripts",[]]);

// Add unit scripts to list
_onRespawnScripts append _unit_onRespawnScripts;

// Check if default scripts enabled
_mission_enableDefaultScripts = missionNamespace getVariable ["mission_onRespawn_enableDefaultScripts",true];

// Check if default scripts enabled for old unit
_enableDefaultScripts = _oldUnit getVariable ["onRespawn_enableDefaultScripts",_mission_enableDefaultScripts];

// Add default scripts to unit scripts
if (_enableDefaultScripts) then {
	_mission_onRespawnScripts = missionNamespace getVariable ["mission_onRespawn_scripts",[]];
	_onRespawnScripts append _mission_onRespawnScripts;
};

// Call all the code for the new unit
// Code/function must be {code}
_nul = {
	_x params ["_code"];
	[_newUnit,_oldUnit] call _code;
	true
} count _onRespawnScripts;

// Keep old unit scripts that have keep for the newUnit
// Return array of scripts which have keep, true or undefined.
_unit_onRespawnScripts = _unit_onRespawnScripts select {_x param [1, true]};
_newUnit setVariable ["unit_onRespawn_scripts",_unit_onRespawnScripts];