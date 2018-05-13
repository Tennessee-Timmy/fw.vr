/* ----------------------------------------------------------------------------
Function: loadout_fnc_cargoGear

Description:
	Load cargo stuff

Parameters:
	none
Returns:
	nothing
Examples:
	used in loadout_fnc_cargo
	[_target,_cargoGear] call loadout_fnc_cargoGear;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_target","_cargoGear"];

// Loop through cargolist
private _nil = {
	_x params ["_item",["_amount",1],["_bag",false]];
	if !(_amount isEqualType 1) then {
		_amount = 1;
	};
	if (!isNil "_item" && {!(_item isEqualTo "")}) then {

		// if item is an array, use it's first element instead
		_item = str _item splitString "[""" select 0;

		// if item is a string and is not an empty string, add the item
		if (!isNil "_item" && {_item isEqualType "" && {!(_item isEqualTo "")}}) then {
			if (_bag isEqualType false && {_bag}) then {
				_target addBackpackCargoGlobal [_item,_amount];
			} else {
				_target addItemCargoGlobal [_item,_amount];
			};
		};
	};
	false
} count _cargoGear;