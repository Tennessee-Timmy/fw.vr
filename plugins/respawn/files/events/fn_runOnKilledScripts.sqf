/* ----------------------------------------------------------------------------
Function: respawn_fnc_runOnKilledScripts

Description:
	Gathers "onKilled_scripts" from unit
	Gathers "mission_onKilled_scripts" from missionNamespace
	Calls the scripts
	"mission_onKilled_enableDefaultScripts" and
	"onKilled_enableDefaultScripts" from _oldUnit
	Are both checked to use "mission_onKilled_scripts"
	The _oldUnit one overrides mission
Parameters:
0:	_oldUnit		- unit that died
1:	_killer			- unit that killed
2:	_respawn		- respawn type (not used)
3:	_respawnDelay	- respawn time (not used)
Returns:
	nothing
Examples:
	[_oldUnit,_killer,_respawn,_respawnDelay] call respawn_fnc_runOnKilledScripts;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_oldUnit","_killer","_respawn","_respawnDelay"];

// Setup the array so it won't be edited
private _onKilledScripts = [];

// Gather all scripts
private _unit_onKilledScripts = (_oldUnit getVariable ["unit_onKilled_scripts",[]]);

// Add unit scripts to list
_onKilledScripts append _unit_onKilledScripts;

// Check if default scripts enabled
_mission_enableDefaultScripts = missionNamespace getVariable ["mission_onKilled_enableDefaultScripts",true];

// Check if default scripts enabled for old unit
_enableDefaultScripts = _oldUnit getVariable ["onKilled_enableDefaultScripts",_mission_enableDefaultScripts];

// Add default scripts to unit scripts
if (_enableDefaultScripts) then {
	_mission_onKilledScripts = missionNamespace getVariable ["mission_onKilled_scripts",[]];
	_onKilledScripts append _mission_onKilledScripts;
};

// Call all the code for the old unit
// Code/function must be {code}
_nul = {
	_x params ["_code"];
	[_oldUnit,_killer] call _code;
	true
} count _onKilledScripts;

// Keep keepable scripts
// Return array of scripts which have keep, true or undefined.
_onKilledScripts = _onKilledScripts select {_x param [1, true]};
_oldUnit setVariable ["unit_onKilled_scripts",_onKilledScripts];