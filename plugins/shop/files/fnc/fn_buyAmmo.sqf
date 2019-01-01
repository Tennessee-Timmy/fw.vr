/* ----------------------------------------------------------------------------
Function: shop_fnc_buyAmmo

Description:
	Buys ammo for the unit

Parameters:
0:	_unit			- unit that will drop the item
1:	_type			- 'primary', 'secondary', 'handgun' or magazine classname
2:	_amount			- How many to have total
3:	_drop			- (default true) True to drop magazines that don't fit any player weapons (to make room)
Returns:
	nothing
Examples:
	[player,'primary',6] call shop_fnc_buyAmmo;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params [['_unit',objNull,[objNull]],['_type',''],['_amount',5,[1]],['_drop',true]];

if (isNull _unit) exitWith {};

private _mag = '';
private _class = '';

// check if type is a weapon type
call {
	if (_type isEqualTo 'primary' || _type isEqualTo 'rifle') exitWith {
		_class = primaryWeapon _unit;
	};

	if (_type isEqualTo 'secondary' || _type isEqualTo 'launcher') exitWith {
		_class = secondaryWeapon _unit;
	};

	if (_type isEqualTo 'handgun' || _type isEqualTo 'pistol') exitWith {
		_class = handgunWeapon _unit;
	};

	// type was not a weapon type, therefor it's a magazine, define magazine
	_mag = _type;
};

// if no magazine was defined (type was a weapon type) get a magazine that matches the weapon class
if (_mag isEqualTo '') then {

	// get a mag that matches
	_mag = ((getArray (configFile >> "CfgWeapons" >> _class >> "magazines")) param [0,'']);
};

if (_drop) then {
	private _keepMagTypes = [];

	// add all the mag clasnames for the weapons unit has
	private _nil = {
		_keepMagTypes append (getArray (configFile >> "CfgWeapons" >> _x >> "magazines"));
		false
	} count [(primaryWeapon _unit),(secondaryWeapon _unit),(handgunWeapon _unit)];

	// always remove the magazines we are buying
	_keepMagTypes = _keepMagTypes - [_mag];


	// go through all the magazines the unit has and remove them
	private _nil = {

		_x params ['_class','_ammo','_isLoaded','_type','_location'];


		call {
			// exit if grenade
			private _isGrenade = ((_class call BIS_fnc_itemType)#1) in ['Grenade','UnknownMagazine','Flare'];
			if (_isGrenade) exitWith {};

			// exit if loeaded
			if (_isLoaded) exitWith {};

			// if the current magazine is the one we are buying, remove it
			if (_mag isEqualTo _class) exitWith {
				_unit removeMagazine _class;
			};

			// if the magazine should not be kept, drop all matching mags (100)
			if (!(_class in _keepMagTypes)) exitWith {
				[_unit, 'item',[_class,100]] call shop_fnc_dropItems;
			};
		};
		false
	} count (magazinesAmmoFull _unit);
};

// add the amount of mags needed
_unit addMagazines [_mag,_amount];