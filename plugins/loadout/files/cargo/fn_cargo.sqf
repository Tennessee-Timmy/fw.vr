/* ----------------------------------------------------------------------------
Function: loadout_fnc_cargo

Description:
	Adds loadout to vehicle/box/cargo
	role/faction can be forced

Parameters:
0:	_target			- Unit or container
1:	_faction		- Faction string or side (defaults to west)
2:	_cargoType		- Cargo type array, default "generic"
Returns:
	nothing
Examples:
	[car] call loadout_fnc_cargo;
	[car,"nato",["ammo","medical"]] call loadout_fnc_cargo;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins
private ["_rifleCargo","_mgCargo","_atCargo","_pistolCargo","_smgCargo","_weaponsCargo","_weaponsbigCargo","_ammoCargo","_ammoBigCargo","_explosivesCargo","_genericCargo","_medsSmallCargo","_medsCargo","_chuteCargo","_chutesCargo","_bagsCargo","_custom1Cargo","_custom2Cargo","_custom3Cargo","_emptyCargo","_radiosCargo","_radiosSRCargo","_radiosLRCargo"];

params ["_target",["_faction",""],"_cargoType"];

if (isNil "_target" || {isNull _target} || {(_target isKindOf "CAManBase")}) exitWith {};

if (!local _target) exitWith {
	_this remoteExec ["loadout_fnc_cargo",_target];
};

// get side for radios
private _side = call {

	if (_faction isEqualType sideEmpty) exitWith {
		_side = _faction;
	};
	private _sideNr = getNumber(configfile >> "CfgVehicles" >> (typeOf _target) >> "side");
	if (_sideNr isEqualTo 0) exitWith {east};
	if (_sideNr isEqualTo 1) exitWith {west};
	if (_sideNr isEqualTo 2) exitWith {resistance};
	if (_sideNr isEqualTo 3) exitWith {civilian};
	west
};

// Get faction override or detect faction
_faction = _target getVariable ["unit_loadout_faction",_faction];
if (isNil "_faction" || {_faction isEqualTo ""}) then {
	_faction = _side;
};

// Detect faction
if (_faction isEqualType sideEmpty) then {
	_faction = call {
		if (_faction isEqualTo west) exitWith {
			missionNamespace getVariable ["mission_loadout_faction_west",LOADOUT_SETTING_FACTION_WEST]
		};
		if (_faction isEqualTo east) exitWith {
			missionNamespace getVariable ["mission_loadout_faction_east",LOADOUT_SETTING_FACTION_EAST]
		};
		if (_faction isEqualTo independent) exitWith {
			missionNamespace getVariable ["mission_loadout_faction_guer",LOADOUT_SETTING_FACTION_GUER]
		};
		if (_faction isEqualTo civilian) exitWith {
			missionNamespace getVariable ["mission_loadout_faction_civ",LOADOUT_SETTING_FACTION_CIV]
		};
		LOADOUT_SETTING_FACTION_CIV
	};
};

if (_faction isEqualTo "disabled") exitWith {};

// Load faction file from "plugins\loadout\loadouts"
private _factionFile = format ["plugins\loadout\loadouts\%1.sqf",_faction];

if !(_factionFile call mission_fnc_checkFile) exitWith {
	(format ['Failed to load %1',_factionFile]) call debug_fnc_log;
};

// load the file
call compile preprocessFileLineNumbers _factionFile;

// find cargoType
if (isNil "_cargoType" || {_cargoType isEqualType [] && {_cargoType isEqualTo []}}) then {
	_cargoType = _target getVariable ["unit_loadout_cargoType",""];
	if (_cargoType isEqualTo "") then {
		_cargoType = (_target call loadout_fnc_cargoFind);
	};
};

_target call loadout_fnc_removeGear;

if (_faction isEqualTo "empty") exitWith {};

// if cargotype is not an array, make it an array
if !(_cargoType isEqualType []) then {
	_cargoType = [_cargoType];
};

private _cargoItems = [];
// load cargoType specific code
private _nil = {
	_x params ["_type",["_amount",1,[1]]];
	private _cargo = (call compile format ["_%1Cargo",_type]);

	// Add items to cargoItems, if array, add the whole array, else push it to the back
	for "_i" from 1 to _amount do {
		if ((_cargo param [0]) isEqualType []) then {
			_cargoItems append _cargo;
		} else {
			_cargoItems pushBack _cargo;
		};
	};
	false
} count _cargoType;

// this will add items etc.
[_target,_cargoItems] call loadout_fnc_cargoGear;