/* ----------------------------------------------------------------------------
Function: loot_fnc_create

Description:
	Creates loot on position, accepts loot array as well.
	If no loot array given, uses loot_fnc_findLoot to create a randomized loot array

Parameters:
0:	_pos				- Array of position
1:	_lootArr			- array containing loot to spawn

Returns:
	array - created weapon holder and loot created
Examples:
	// used in loot_fnc_clusterSpawn
	[_pos] call loot_fnc_create;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

params [['_pos',[]],['_lootArr',[]]];

if (_pos isEqualTo []) exitWith {};

if (_lootArr isEqualTo []) then {
	private _lootCat = _pos param [3,'default'];

	// loot array now done when the box is cracked
	//_lootArr = [_lootCat] call loot_fnc_findLoot;
};

if (_lootArr isEqualTo [] || (_lootArr param [0,'empty']) isEqualTo 'empty') exitWith {
	[objNull,'empty']
};

private _gwh = "GroundWeaponHolder" createVehicle [0,0,0];

if (isServer && hasInterface) then {
	(allCurators select 0) addCuratorEditableObjects [[_gwh],false];
};

private _position = +_pos;
_position resize 3;

_gwh setPosATL _position;
private _posLoot = getPosASL _gwh;
_posLoot set [2,((_posLoot select 2)-((visiblePosition _gwh)select 2))-0.1];
_gwh setPosASL _posLoot;

{
	_x params [['_type','item'],['_class',''],['_param1',999]];
	call {
		if (_type isEqualTo 'item') exitWith {
			_gwh addItemCargoGlobal [_class,1];
		};
		if (_type isEqualTo 'gun') exitWith {
			_gwh addWeaponCargoGlobal [_class,1];
		};
		if (_type isEqualTo 'bag') exitWith {
			_gwh addBackpackCargoGlobal [_class,1];
		};
		if (_type isEqualTo 'mag') exitWith {
			_gwh addMagazineAmmoCargo  [_class,1,_param1];
		};
	};
	false
} count _lootArr;
_gwh setVariable ['loot_holder_lootArr',_lootArr];
[_gwh,_lootArr]