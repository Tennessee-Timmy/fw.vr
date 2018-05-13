/* ----------------------------------------------------------------------------
Function: loadout_fnc_cargoFind

Description:
	Determines cargo type

Parameters:
0:	_target			- Object
Returns:
	"role"			- Cargo type determined by maxload
Examples:
	_target call loadout_fnc_cargoFind;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_target"];

// make sure target is not invalid
if (isNil "_target" || {isNull _target} || {(_target isKindOf "CAManBase")}) exitWith {};

// init variables
private _cargoType = [];
private _guns = weaponCargo _target;
private _gunsCount = count _guns;

private _mags = magazineCargo _target;
private _magsCount = count _mags;

private _items = itemCargo _target;
private _itemCount = count _items;
private _itemsMedCount = {(_x) isEqualTo "FirstAidKit"} count _items;
private _itemsCount = _itemCount - _itemsMedCount;

private _bags = backpackCargo _target;
private _bagsCount = count _bags;


// Check if items exist and give add default shit
if (_gunsCount > 0) then {
	for "_i" from 1 to (ceil((_gunsCount)/2)) do {
		_cargoType pushBack "rifle";
	};
};

if (_gunsCount > 3) then {
	for "_i" from 1 to (ceil((_gunsCount)/3)) do {
	_cargoType pushBack "mg";
	};
};
if (_gunsCount > 5) then {
	for "_i" from 1 to (round((_gunsCount)/6)) do {
	_cargoType pushBack "at";
	};
};

if (_magsCount > 10 && _magsCount < 30) then {
	for "_i" from 1 to (round((_magsCount)/10)) do {
	_cargoType pushBack "ammo";
	};
};

if (_magsCount >= 30) then {
	for "_i" from 1 to (ceil((_magsCount)/30)) do {
	_cargoType pushBack "ammoBig";
	};
};

if (_itemsCount > 0) then {
	for "_i" from 1 to (ceil((_itemsCount)/10)) do {
	_cargoType pushBack "generic";
	};
};

if (_itemsMedCount > 1 && _itemsMedCount < 10) then {
	for "_i" from 1 to (ceil((_itemsMedCount)/2)) do {
	_cargoType pushBack "medsSmall";
	};
};
if (_itemsMedCount >= 10) then {
	for "_i" from 1 to (round((_itemsMedCount)/10)) do {
	_cargoType pushBack "meds";
	};
};

if (_bagsCount > 0) then {
	for "_i" from 1 to (ceil((_bagsCount)/1)) do {
	_cargoType pushBack "bags";
	};
};

if (_cargoType isEqualTo []) then {
	_cargoType pushBack "empty";
};

_cargoType