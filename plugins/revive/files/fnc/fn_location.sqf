/* ----------------------------------------------------------------------------
Function: revive_fnc_location

Description:
	respawn location script
	Must run on clients(uses player)

Parameters:
	none

Returns:
	nothing

Examples:
	call revive_fnc_location;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

if (!hasInterface) exitWith {};

private _isRevived = player getVariable ['unit_revive_isRevived',false];
private _oldUnit = player getVariable ['unit_revive_oldUnit',objNull];

// no old unit or not revived means normal respawn
if (isNull _oldUnit || !_isRevived) exitWith {
	call respawn_fnc_base_respawn;
};

// make player unconscious
[player,true,0.5,true] call ace_medical_fnc_setUnconscious;

private _loadOut = getUnitLoadout _oldUnit;
if (_loadOut isEqualTo []) then {
	_loadOut = _oldUnit getVariable ['unit_revive_oldLoadout',[]];
};
player setUnitLoadout _loadOut;

// wait for player to be unconscious and then respawn him
[_oldUnit] spawn {
	sleep 0.1;

	params [['_oldUnit',objNull]];

	private _pos = getPosASL _oldUnit;
	private _vdu = [(vectorDir _oldUnit),(vectorUp _oldUnit)];


	player setPosASL _pos;
	player setVectorDirAndUp _vdu;

	player setVariable ['unit_revive_isRevived',false,true];

	_oldUnit setVariable ['unit_revive_canBeRevived',false,true];

	//deleteVehicle _oldUnit;
	[_oldUnit,true] remoteExec ['hideObjectGlobal',2];
	[_oldUnit,false] remoteExec ['enableSimulationGlobal',2];
	_oldUnit setpos [0,0,0];
};