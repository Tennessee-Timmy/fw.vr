/* ----------------------------------------------------------------------------
Function: loadout_fnc_auto

Description:
	Auto adds stuff to unit/vehicle

Parameters:
0:	_target				- Unit or container

Returns:
	nothing
Examples:
	_this call loadout_fnc_auto;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins
private _enabled = missionNamespace getVariable ["mission_loadout_auto_enabled",LOADOUT_SETTING_AUTO_ENABLED];
if !(_enabled) exitWith {};
_this spawn {
	// wait from 1 to 3 seconds
	// this has to be done so unit can have time to disable it's loadout and hopefully people won't end up naked
	uiSleep (1 + random 2); // todo test
	params ["_target"];

	private _disabled = _target getVariable ["unit_loadout_disabled",false];

	if (isPlayer _target || _disabled) exitWith {};


	if (_target isKindOf "CAManBase") exitWith {
		private _enabledUnit = missionNamespace getVariable ["mission_loadout_auto_unit",LOADOUT_SETTING_AUTO_UNIT];
		if (_enabledUnit) then {
			[_target] call loadout_fnc_unit;

			sleep 1;
			if ((uniform _target) isEqualTo '') then {
				[_target] call loadout_fnc_unit;
			};
		};
	};

	private _enabledCargo = missionNamespace getVariable ["mission_loadout_auto_cargo",LOADOUT_SETTING_AUTO_CARGO];
	if !(_enabledCargo) exitWith {};

	private _maxLoad = getNumber(configfile >> "CfgVehicles" >> (typeOf _target) >> "maximumLoad");

	if !(_maxLoad > 0) exitWith {};

	if (toLower(typeOf _target)find (toLower "weaponholder") > - 1) exitWith {};
	if (_target isKindOf "AllVehicles" || _target isKindOf "ReammoBox_F") then {
		isNil {[_target] call loadout_fnc_cargo};
	};
};