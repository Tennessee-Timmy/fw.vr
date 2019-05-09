/* ----------------------------------------------------------------------------
Function: loot_fnc_save

Description:
	Saves the gear of a vehicle or ground holder into an array that can be re-created by the loot system

Parameters:
0:	_vehicle				- Vehicle to get the loot from

Returns:
	Array of spawnable loot
Examples:
	[_x] call loot_fnc_save;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

params [['_vehicle',objNull]];

if (isNull _vehicle) exitWith {[['empty']]};

// added create mechanic
// if the vehicle is a crate (not cracked), then just get the variable
private _isCrate = _vehicle getVariable ['loot_holder_lootIsCrate',false];
if (_isCrate) exitWith {
	_crate getVariable ['loot_holder_lootArr',[['empty']]];
};


private _containers = ((everyContainer _vehicle) apply {
	_x param [1,objNull];
});
_containers pushBack _vehicle;

private _items = [];
private _mags = [];
private _weapons = [];
private _bags = [];

private _nil = {
	_items append  (itemCargo _x);
	_mags append (magazinesAmmoCargo _x);
	_weapons append (weaponCargo _x);
	_bags append (backpackcargo _x);
	deleteVehicle _x;
	false
} count _containers;


private _returnArr = [];


private _nil = {
	_returnArr pushBack ['item',_x];
	false
} count _items;

_nil = {
	_x params ['_class','_ammo'];
	_returnArr pushBack ['mag',_class,_ammo];
	false
} count _mags;

_nil = {
	_returnArr pushBack ['weapon',_x];
	false
} count _weapons;

_nil = {
	_returnArr pushBack ['bag',_x];
	false
} count _bags;

// return
_returnArr