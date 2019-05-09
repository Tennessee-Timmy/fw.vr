/* ----------------------------------------------------------------------------
Function: loot_fnc_onLootSpawn

Description:
	Runs when loot is created(ground weapon holder)

Parameters:
0:	_gwh			- Ground weapon holder

Returns:
	nothing
Examples:
	[_gwh] call loot_fnc_onLootSpawn;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

params [['_gwh',objNull]];
if (isNull _gwh) exitWith {};

private _fnc = missionNamespace getVariable ['mission_loot_onLootSpawn',{}];

// exit if it's not a code block
if !(_fnc isEqualType {}) exitWith {};

_gwh call _fnc;