/* ----------------------------------------------------------------------------
Function: loadout_fnc_unit

Description:
	Adds loadout to player
	role/faction can be forced

	CHANGE ROLE
	unit_loadout_role = "role"
	CHANGE FACTION
	unit_loadout_faction = "faction" or SIDE

Parameters:
0:	_target			- Unit or container
1:	_faction		- Faction string or side, "" to detect unit side automatically
2:	_role			- Force role
Returns:
	nothing
Examples:
	[player] call loadout_fnc_unit;
	[player,"nato","rifleman"] call loadout_fnc_unit;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins
private ["_uniform","_vest","_backPack","_helmet","_goggles","_rifleKit","_carbineKit","_rifleGLKit","_latKit","_matKit","_aaKit","_lmgKit","_mmgKit","_marksmanKit","_pistolKit","_sniperKit","_hatKit","_hatAssKit","_hmgKit","_hmgAssKit","_gmgKit","_gmgAssKit","_mortarKit","_mortarAssKit","_primaryAttachments","_secondaryAttachments","_handgunAttachments","_Binoculars","_LinkItems","_ExtraItems","_MedicalItems","_commonCode","_officerCode","_medicCode","_facCode","_slCode","_tlCode","_pointManCode","_paramedicCode","_latCode","_matCode","_matAssCode","_aaCode","_aaAssCode","_hatCode","_hatAssCode","_lmgCode","_lmgAssCode","_mmgCode","_mmgAssCode","_hmgCode","_hmgAssCode","_gmgCode","_gmgAssCode","_mortarCode","_mortarAssCode","_marksmanCode","_grenadierCode","_riflemanCode","_reconSlCode","_reconTlCode","_reconParamedicCode","_reconScoutCode","_reconlatCode","_reconlmgCode","_reconMarksmanCode","_reconDemoCode","_smgKit","_crewCode","_pilotCode","_heliPilotCode","_engineerCode","_demoCode","_uavCode","_sniperCode","_spotterCode","_diverCode","_custom1Code","_custom2Code","_custom3Code","_custom4Code","_custom5Code","_handGun","_secondaryWeapon","_primaryWeapon","_faces","_voices"];

params ["_target",["_faction",""],"_role"];

if (isNil "_target" || {isNull _target} || {!(_target isKindOf "CAManBase")}) exitWith {};

if (!local _target) exitWith {
	_this remoteExec ["loadout_fnc_unit",_target];
};

// quit if player is dead
if (isPlayer _target && {_target call respawn_fnc_deadCheck}) exitWith {};

private _side = side _target;
// Get faction override
_faction = _target getVariable ["unit_loadout_faction",_faction];

// Detect faction
if (isNil "_faction" || {_faction isEqualTo ""}) then {
	_faction = call {
		if ((_side) isEqualTo west) exitWith {
			missionNamespace getVariable ["mission_loadout_faction_west",LOADOUT_SETTING_FACTION_WEST]
		};
		if ((_side) isEqualTo east) exitWith {
			missionNamespace getVariable ["mission_loadout_faction_east",LOADOUT_SETTING_FACTION_EAST]
		};
		if ((_side) isEqualTo independent) exitWith {
			missionNamespace getVariable ["mission_loadout_faction_guer",LOADOUT_SETTING_FACTION_GUER]
		};
		if ((_side) isEqualTo civilian) exitWith {
			missionNamespace getVariable ["mission_loadout_faction_civ",LOADOUT_SETTING_FACTION_CIV]
		};
		LOADOUT_SETTING_FACTION_CIV
	};
};

// If faction is a side, convert it to faction
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

_target call loadout_fnc_removeGear;

if (_faction isEqualTo "empty") exitWith {};

// Load faction file from "plugins\loadout\loadouts"
private _factionFile = format ["plugins\loadout\loadouts\%1.sqf",_faction];

if !(_factionFile call mission_fnc_checkFile) exitWith {
	(format ['Failed to load %1',_factionFile]) call debug_fnc_log;
};


// load the file
call compile preprocessFileLineNumbers _factionFile;

// find role
if (isNil "_role") then {
	_role = _target getVariable ["unit_loadout_role",""];
	if (_role isEqualTo "") then {
		_role = (_target call loadout_fnc_roleFind);
	};
};

// run default code
_primaryWeapon = _rifleKit;
_handGun = "";
_secondaryWeapon = "";

call _commonCode;

// load role specific code
private _code = call compile format ["_%1Code",_role];
if (isNil "_code") exitWith {
	format ["LOADOUT: %1 code not found",_role] call debug_fnc_log;
};
call _code;

// this will add items etc.
call loadout_fnc_unitGear;