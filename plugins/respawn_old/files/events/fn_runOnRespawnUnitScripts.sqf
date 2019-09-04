/* ----------------------------------------------------------------------------
Function: respawn_fnc_runOnRespawnUnitScripts

Description:
	Runs "unit_onRespawnUnit_scripts" from unit
	Runs "mission_onRespawnUnit_scripts" from missionNamespace
	^ can be disabled with "unit_onRespawnUnit_enableDefaultScripts"
	and "mission_onRespawnUnit_enableDefaultScripts"
	Calls the scripts
	Code/function must be {code}
Parameters:
0:	_unit	- unit the scripts are run on
Returns:
	nothing
Examples:
	_unit call respawn_fnc_runOnRespawnUnitScripts;
Author:
	nigel
---------------------------------------------------------------------------- */
// Code begins

params ["_unit"];

// setup the array so it won't be edited
private _respawnUnitscripts = [];

// Gather all scripts
_unit_respawnUnitscripts = (_unit getVariable ["unit_onRespawnUnit_scripts",[]]);

// Add unit scripts to list
_respawnUnitscripts append _unit_respawnUnitscripts;

// Check if default scripts enabled
_mission_enableDefaultScripts = missionNamespace getVariable ["mission_onRespawnUnit_enableDefaultScripts",true];

// Check if default scripts enabled for old unit
_enableDefaultScripts = _unit getVariable ["unit_onRespawnUnit_enableDefaultScripts",_mission_enableDefaultScripts];

// Add default scripts to unit scripts
if (_enableDefaultScripts) then {
	_mission_respawnUnitScripts = missionNamespace getVariable ["mission_onRespawnUnit_scripts",[]];
	_respawnUnitscripts append _mission_respawnUnitScripts;
};

// Call all the code for the unit
// Code/function must be [{code/function},true]
_nul = {
	_x params ["_code"];
	_unit call _code;
	true
} count _respawnUnitscripts;

// Keep keepable scripts
// Return array of scripts which have keep, true or undefined.
_unit_respawnUnitscripts = _unit_respawnUnitscripts select {_x param [1, true]};
_unit setVariable ["unit_onRespawnUnit_scripts",_unit_respawnUnitscripts];