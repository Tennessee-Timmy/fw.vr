/* ----------------------------------------------------------------------------
Function: zoom_fnc_maxZoom

Description:
	find the max zoom on the current weapon(highest initzoom)

Parameters:
	none
Returns:
	nothing
Examples:
	call zoom_fnc_maxZoom

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

private _items = call {
	private _weapon = currentWeapon player;
	if (_weapon isEqualTo primaryWeapon player) exitWith {
		primaryWeaponItems player;
	};
	if (_weapon isEqualTo secondaryWeapon player)  exitWith {
		secondaryWeaponItems player;
	};
	if (_weapon isEqualTo handgunWeapon player)  exitWith {
		handgunItems player;
	};
	[]
};
private _maxZoom = 1;
if !(currentWeapon player isEqualTo '') then {
	_maxZoom = [(currentWeapon player),{(getNumber (configFile >> 'CfgWeapons' >> (currentWeapon player) >> 'opticsZoomInit'))}] call zoom_fnc_readCache;
};
{
	private _item = _x;
	if (_item != '') then {
		private _zoom = [_item,{
			private _modes = ('true' configClasses (configFile >> 'CfgWeapons' >> _this >> 'ItemInfo' >> 'OpticsModes'));
			private _maxZoom = 1;
			{
				private _zoom = getNumber(_x >> "opticsZoomInit");
				if (_zoom < _maxZoom && _zoom != 0) then {_maxZoom = _zoom};
			} count _modes;
			_maxZoom
		},_item] call zoom_fnc_readCache;
		if (_zoom < _maxZoom && _zoom != 0) then {_maxZoom = _zoom};
	};
	false
} count _items;
_maxZoom