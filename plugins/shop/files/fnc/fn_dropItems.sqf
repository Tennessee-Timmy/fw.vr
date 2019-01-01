/* ----------------------------------------------------------------------------
Function: shop_fnc_dropItems

Description:
	Drops weapons and / or items on the ground

Parameters:
0:	_unit			- unit that will drop the item
1:	_type			- 'primary', 'secondary', 'handgun', 'item'
2:	_extra			- extra params
Returns:
	nothing
Examples:
	[player,'primary'] call shop_fnc_dropItems;
	[player,'item',['_oldHelmet']] call shop_fnc_dropItems;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params [['_unit',objNull,[objNull]],['_type','primary'],['_extra',[]]];

if (isNull _unit) exitWith {};

// find a near ground weapon holder
private _gwh = (_unit nearObjects ['GroundWeaponHolder',1.7]) param [0,objNull];

// if no nearby holder, create one
if (isNull _gwh) then {

	// create a weapon holder for dropping items into
	_gwh = createVehicle ['GroundWeaponHolder',[0,0,0], [], 0, 'CAN_COLLIDE'];
	private _pos = (_unit modelToWorldVisualWorld [0,0.5,0]);

	//_gwh setPosASL (_unit modelToWorldVisualWorld [0,1,0]);

	_gwh setPosATL [_pos#0,_pos#1,0];
	_gwh setDir (random 360);
};

private _codes = [
	{primaryWeapon _unit},	// get weapon
	{primaryWeaponItems _unit}	// get weapon items
];

// choose which weapon to drop
call {
	if (_type isEqualTo 'primary') exitWith {

		// default is already primary
	};

	if (_type isEqualTo 'handgun' || _type isEqualTo 'pistol') exitWith {
		_codes = [
			{handgunWeapon _unit},	// get weapon
			{handgunItems _unit}	// get weapon items
		];
	};

	if (_type isEqualTo 'secondary' || _type isEqualTo 'launcher') exitWith {
		_codes = [
			{secondaryWeapon _unit},
			{secondaryWeaponItems _unit}
		];
	};
};

// check all the types
if !(_type isEqualTo 'item' || _type isEqualTo 'items') exitWith {

	//private _weapon = primaryWeapon _unit;
	private _weapon = call (_codes # 0);

	// if no weapon, then our job is done
	if (_weapon isEqualTo '') exitWith {};

	//private _items = primaryWeaponItems _unit;
	private _items = call (_codes # 1);

	private _magazines = [];

	// get all the magazines that fit into this gun
	private _magazineClasses = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");

	// EXTRA: magazines to keep
	// First extra element can be an array which will contain classnames of magazines to keep
	// example:
	// _extra = [['30Rnd_65x39_caseless_mag_Tracer']]
	private _keep = _extra param [0,[],[[]]];
	if !(_keep isEqualTo []) then {
		_magazineClasses = _magazineClasses - _keep;
	};

	// check all the players magazines to see if they should be dropped
	private _nil = {
		_x params ['_class','_ammo','_isLoaded','_type','_location'];
		call {
			// if the class is used on the dropped weapon, add it to the list
			if (_class in _magazineClasses) exitWith {
				_magazines pushBack [_class,_ammo]
			};

			// if the magazine is loaded and supposed to be kept, drop it(so it won't be destroyed)
			if (_class in _keep && _isLoaded) exitWith {_magazines pushBack [_class,_ammo,true]};
		};
		false
	} count (magazinesAmmoFull _unit);


	//
	// now that all the data is collected, time to get rid of everything and put it on the ground
	_unit removeWeapon _weapon;
	_gwh addWeaponCargoGlobal [_weapon,1];
	{
		_x params ['_class','_ammo',['_skip',false]];
		call {
			_gwh addMagazineAmmoCargo [_class,1,_ammo];
			if (_skip) exitWith {};
			_unit removeMagazine _class;
		};
		false
	} count _magazines;

	// dropping all the items on the ground
	{_gwh addItemCargoGlobal [_x,1]; false} count _items;
};

_extra params [['_class',''],['_amount',1],['_onlyDrop',false]];

if (_class isEqualTo '') exitWith {};

private _typeArr = (_class call BIS_fnc_itemType);

// determine item type
private _cat = toLower(_typeArr#0);
private _type = toLower(_typeArr#1);

if (_cat isEqualTo 'item') exitWith {
	for '_i' from 1 to _amount do {
		_gwh addItemCargoGlobal [_class,1];
		if (_onlyDrop) then {
			_unit removeItem _class;
		};
	};
};
if (_cat isEqualTo 'magazine') exitWith {

	// find the matching magazines
	private _matchingMags = [];
	_matchedCount = 0;

	private _nil = {
		_x params ['_mag','_ammo','_isLoaded','_type','_location'];

		// exit if we have enough mags to drop
		if (_matchedCount >= _amount) exitWith {};

		call {
			if !(_mag isEqualTo _class) exitWith {};
			if (_isLoaded) exitWith {};
			_matchingMags pushBack _ammo;
			_matchedCount = _matchedCount + 1;
		};
	} count (magazinesAmmoFull _unit);

	{
		_gwh addMagazineAmmoCargo [_class,1,_x];
		if (_onlyDrop) then {
			_unit removeMagazine _class;
		};
		false
	} count _matchingMags;
};
if (_cat isEqualTo 'weapon') exitWith {
	for '_i' from 1 to _amount do {
		_gwh addWeaponCargoGlobal [_class,1];
		if (_onlyDrop) then {
			_unit removeWeapon _class;
		};
	};
};

// if the item being removed it a container
if (_cat isEqualTo 'equipment') exitWith {

	// backpacks won't be processed
	if (_type isEqualTo 'backpack') exitWith {};

	// remove glasses
	if (_type isEqualTo 'glasses') exitWith {
		for '_i' from 1 to _amount do {
			if (_onlyDrop) then {
				removeGoggles _class;
			};
			_gwh addItemCargoGlobal [_class,1];
		};
	};

	// remove helmet
	if (_type isEqualTo 'headgear') exitWith {
		for '_i' from 1 to _amount do {

			if (_onlyDrop) then {
				removeHeadgear _class;
			};
			_gwh addItemCargoGlobal [_class,1];
		};
	};

	private _codes = [
		'Uniform',		// type for magazinesAmmoFull
		{uniformContainer _unit},	// to get itemCargo from
		{removeUniform _unit}		// remove command
	];

	if (_type isEqualTo 'vest') then {
		_codes = [
			'Vest',		// type for magazinesAmmoFull
			{vestContainer _unit},	// to get itemCargo from
			{removeVest _unit}		// remove command
		];
	};

	call {

		// add the equipment item
		_gwh addItemCargoGlobal [_class,1];

		// remove magazines from the uniform
		private _nil = {
			_x params ['_class','_ammo','_isLoaded','_type','_location'];
			if (_location isEqualTo _codes#0) then {
				_gwh addMagazineAmmoCargo [_class,1,_ammo];
			};

			false
		} count (magazinesAmmoFull _unit);


		// get all the items from the uniform
		private _nil = {
			_gwh addItemCargoGlobal [_x,1];
			false
		} count (itemCargo (call (_codes param [1,{}])));

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

		} count (weaponsItemsCargo (call (_codes param [1,{}])));
	};

	if (_onlyDrop) then {
		call (_codes param [2,{}]);
	};
};
