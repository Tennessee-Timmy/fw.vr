/* ----------------------------------------------------------------------------
Function: loadout_fnc_removeGear

Description:
	Removes all gear from unit / container

Parameters:
	none
Returns:
	nothing
Examples:
	call loadout_fnc_removeGear;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params [["_target",player]];

if (!local _target) exitWith {
	remoteExec ["loadout_fnc_cleanGear",_target];
};

if (_target isKindOf "CAManBase") exitWith {
	removeAllWeapons _target;
	removeAllItems _target;
	removeAllAssignedItems _target;
	removeUniform _target;
	removeVest _target;
	removeBackpack _target;
	removeHeadgear _target;
	removeGoggles _target;
};

clearBackpackCargoGlobal _target;
clearItemCargoGlobal _target;
clearMagazineCargoGlobal _target;
clearWeaponCargoGlobal _target;