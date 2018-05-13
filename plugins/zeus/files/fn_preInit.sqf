/* ----------------------------------------------------------------------------
Function: zeus_fnc_preInit

Description:
	preInit script for zeus plugin

Parameters:
	none
Returns:
	nothing
Examples:
	Runs in preinit (from functions.cpp)

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Script begins

if (!isServer) exitWith {};
private _addons = [];
private _cfgPatches = configFile >> "cfgpatches";
for "_i" from 0 to (count _cfgPatches - 1) do {
	_class = _cfgPatches select _i;
	if (isClass _class) then {_addons pushBack configname _class;};
};
_addons call BIS_fnc_activateAddons;