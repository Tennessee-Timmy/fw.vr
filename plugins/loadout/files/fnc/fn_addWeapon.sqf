/* ----------------------------------------------------------------------------
Function: loadout_fnc_addWeapon

Description:
	Adds weapon to unit/conntainer

Parameters:
0:	_target			- Unit or container
1:	_weapon			- Classname of weapon to be added
2:	_amount			- Amount of weapons added (only for container)
Returns:
	nothing
Examples:
	[player,"arifle_MX_F"] call loadout_fnc_addWeapon;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_target","_weapon",["_amount",1]];

if (isNil "_target" || {isNull _target} || {isNil "_weapon"} || {!(_weapon isEqualType "")} || {_weapon isEqualTo ""}) exitWith {};

if (!local _target) exitWith {
	_this remoteExec ["loadout_fnc_addWeapon",_target];
};

if (_target isKindOf "CAManBase") exitWith {
	_target addWeapon _weapon;
};

_target addWeaponCargoGlobal [_weapon,_amount];