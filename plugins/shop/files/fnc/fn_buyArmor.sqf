/* ----------------------------------------------------------------------------
Function: shop_fnc_buyArmor

Description:
	Buys armor for the player.
	Transfers all items from the old vest into the new one and drops the ones that don't fit.

Parameters:
0:	_unit			- unit that will drop the item
1:	_vest			- classnames of new vest
2:	_helmet			- classname for new helmet
Returns:
	nothing
Examples:
	[player,'vest','helmet'] call shop_fnc_buyArmor;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params [['_unit',objNull,[objNull]],['_vest',''],['_helmet','']];

if (isNull _unit) exitWith {};

// add new helmet
call {
	if (_helmet isEqualTo '') exitWith {};

	private _oldHelmet = headgear _unit;
	if !(_oldHelmet isEqualTo '') then {
		[_unit,'item',[_oldHelmet]] call shop_fnc_dropItems;
	};

	_unit addHeadgear _helmet;
};

if (_vest isEqualTo '') exitWith {};

call {
	private _oldVest = vest _unit;
	private _mags = [];
	private _items = [];
	private _weapons = [];

	// remove magazines from the uniform
	private _nil = {
		_x params ['_class','_ammo','_isLoaded','_type','_location'];
		if (_location isEqualTo 'Vest') then {
			_mags pushBack [_class,_ammo];
		};

		false
	} count (magazinesAmmoFull _unit);

	// get all the items from the uniform
	private _nil = {
		_items pushBack _x;
		false
	} count (itemCargo (vestContainer _unit));

	// get all the weapons
	private _nil = {
		_x params ['_class','_acc1','_acc2','_acc3','_mags','_acc4'];
		_gwh addWeaponCargoGlobal [_class,1];

		// add all the accessories
		{
			if !(_x isEqualTo '') then {
				_gwh addItemCargoGlobal ['_x',1];
			};
			false
		} count [_acc1,_acc2,_acc3,_acc4];
		false

	} count (weaponsItemsCargo (vestContainer _unit));

	// remove vest
	removeVest _unit;
	[_unit,'item',[_oldVest,1,true]] call shop_fnc_dropItems;

	_unit addvest _vest;


	{
		if (_unit canAdd (_x#0)) then {
			_unit addMagazine _x;
		} else {
			[_unit,'item',[_x#1,1,true]] call shop_fnc_dropItems;
		};
		false
	} count _mags;

	{
		if (_unit canAdd (_x)) then {
			_unit addItem _x;
		} else {
			[_unit,'item',[_x,1,true]] call shop_fnc_dropItems;
		};
		false
	} count _items;

	{
		if (_unit canAdd _x) then {
			_unit addItem _x;
		} else {
			[_unit, 'item',[_x,1,true]] call shop_fnc_dropItems;
		};
	} count _weapons;
};


