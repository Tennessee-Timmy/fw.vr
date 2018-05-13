/* ----------------------------------------------------------------------------
Function: respawn_fnc_scriptRemoveUnit

Description:
	Removes script from the unit specificied
	variables used for saving scripts:
		unit_onKilled_scripts
		unit_onRespawn_scripts
		unit_onRespawnUnit_scripts
Parameters:
0:	_target		- Unit to remove the scripts from
1:	_script		- {code} to be removed from the unit
2:	_scriptType	- "onKilled","onRespawn","onRespawnUnit" must be one of these strings
Returns:
	nothing
Examples:
	TO onKilled:
		[_unit,{spec_fnc_exit},"kill"] call respawn_fnc_scriptRemoveUnit;
	TO respawn:
		[_unit,{_this setVariable ['reSpawned',true]},"onRespawnUnit"] call respawn_fnc_scriptRemoveUnit;
	TO onRespawn:
		[_unit,{loadout_fnc_default},"onRespawn"] call respawn_fnc_scriptRemoveUnit;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_unit","_script","_scriptType"];

// Exit if target unit does not exist or isNull or is not a man
if (isNil "_unit" || {isNull _unit} || {!(_unit isKindOf "CAManBase")}) exitWith {};

// Get the scriptType
_scriptTypeName = format ["unit_%1_scripts",_scriptType];

// Grab old scripts
private _unit_scripts = (_unit getVariable [_scriptTypeName,[]]);

// Remove the script from the list
_unit_scripts = _unit_scripts select {!(_x param [0,nil] isEqualTo _script)};

// Update the script array on the unit
_unit setVariable [_scriptTypeName,_unit_scripts];