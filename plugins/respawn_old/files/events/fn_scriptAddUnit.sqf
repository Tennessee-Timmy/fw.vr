/* ----------------------------------------------------------------------------
Function: respawn_fnc_scriptAddUnit

Description:
	Adds respawn script to specified unit

	variables used for saving scripts:
		unit_onKilled_scripts
		unit_onRespawn_scripts
		unit_onRespawnUnit_scripts
Parameters:
0:	_target		- Unit to which the scripts will be added
1:	_script		- {code} to be added to the unit
2:	_scriptType	- "onKilled","onRespawn","onRespawnUnit" must be one of these strings
3:	_keep		- True by default, will the script be kept after first use
Returns:
	nothing
Examples:
	TO onKilled:
		[_unit,{call spec_fnc_exit},"kill",false] call respawn_fnc_scriptAddUnit;
	TO respawn:
		[_unit,{_this setVariable ['respawned',true]},"onRespawnUnit",true] call respawn_fnc_scriptAddUnit;
	TO onRespawn:
		[_unit,{call loadout_fnc_default},"onRespawn",false] call respawn_fnc_scriptAddUnit;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_unit","_script","_scriptType",["_keep",true]];

// Exit if target unit does not exist or isNull or is not a man
if (isNil "_unit" || {isNull _unit} || {!(_unit isKindOf "CAManBase")}) exitWith {};

// Get the scriptType
private _scriptTypeName = format ["unit_%1_scripts",_scriptType];

// Grab old scripts
private _unit_respawn_scripts = (_unit getVariable [_scriptTypeName,[]]);

// Add the script to the list
_nul = _unit_respawn_scripts pushBack [_script,_keep];

// Update the script array on the unit
_unit setVariable [_scriptTypeName,_unit_respawn_scripts];