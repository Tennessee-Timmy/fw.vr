/* ----------------------------------------------------------------------------
Function: loadout_fnc_addWeaponKit

Description:
	Adds weapon kit to unit/conntainer

Parameters:
0:	_target				- Unit or container
1:	_kit				- Weapon kit to add
	0:	_weapon			- Classname of weapon to be added (can be array of [class,amount])
	1:	_mag			- Amount of weapons added (only for container)
		0:	_magClass	- Magazine classname (can be array of [class,bullets])
		1:	_magAmount	- Amount of magazines to add

2:	_kitAmount			- How many instances of this kit will be added
Returns:
	nothing
Examples:
	[player,["arifle_MX_F",["30Rnd_65x39_caseless_mag",5],[""]],1] call loadout_fnc_addWeaponKit;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_target","_kit",["_kitAmount",1]];

if (isNil "_target" || {isNull _target} || {isNil "_kit"} || {_kit isEqualTo ""} || {_kit isEqualTo []}) exitWith {};

if (!local _target) exitWith {
	_this remoteExec ["loadout_fnc_addWeaponKit",_target];
};

private _weapon = _kit deleteAt 0;
private _mags = _kit;


for "_i" from 1 to _kitAmount do {
	private _nil = {
		_x params ["_mag","_amount"];
		[_target,_mag,_amount] call loadout_fnc_AddMagazines;
		false
	} count _mags;
	[_target,_weapon] call loadout_fnc_addWeapon;
};