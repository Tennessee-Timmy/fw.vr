/* ----------------------------------------------------------------------------
Function: shop_fnc_buyWeapon

Description:
	Buys a new weapon for the player (comes with 1 mag)

Parameters:
0:	_unit			- unit that will drop the item
1:	_type			- 'primary', 'secondary', 'handgun'
2:	_class			- Weapon classnames
3:	_items			- array of weapon items (and/or magazine) to be attached to the weapon
4:	_addMag			- automatically add 1 magazine
Returns:
	nothing
Examples:
	[player,'primary',"hgun_Pistol_heavy_02_F",[],true] call shop_fnc_buyWeapon;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params [['_unit',objNull,[objNull]],['_type','primary'],['_class',''],['_items',[],[[]]],['_addMag',false]];

if (isNull _unit) exitWith {};

// remove old weapon, but keep the mags
[_unit,_type,[getArray (configFile >> "CfgWeapons" >> _class >> "magazines")]] call shop_fnc_dropItems;

_unit addWeapon _class;

// determine what type of code to run based on the type
private _code = {_unit addPrimaryWeaponItem _x};
if (_type isEqualTo 'secondary' || _type isEqualTo 'launcher') then {
	_code = {_unit addSecondaryWeaponItem _x};
};
if (_type isEqualTo 'pistol' || _type isEqualTo 'handgun') then {
	_code = {_unit addHandgunItem _x};
};

if (_addMag) then {
	_items pushBack ((getArray (configFile >> "CfgWeapons" >> _class >> "magazines")) param [0,'']);
};
// add the items
{
	call _code;
	false
} count _items;