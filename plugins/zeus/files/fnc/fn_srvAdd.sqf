/* ----------------------------------------------------------------------------
Function: zeus_fnc_srvAdd

Description:
	Adds zeus to unit
	Must run on server

Parameters:
0:	_unit		- Unit which to add zeus to
Returns:
	nothing
Examples:
	// Adds zeus to player it's called from
	player remoteExec ["zeus_fnc_srvAdd",2];

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// Only run on server
if !(isServer) exitWith {};

params ["_player"];

// Quit if player does not exist, is headless cleint, or is already a zeus
if (isNull _player || {_player isKindOf "HeadlessClient_F"} || {!(isNull (getAssignedCuratorLogic _player))}) exitWith {};

private _zeusList = missionNamespace getVariable ["mission_zeus_list",[]];
private _uid = (getPlayerUID _player);
private _zeus = nil;

{
	if ((_x getVariable ["zeus_uid",""]) isEqualTo _uid) exitWith {
		_zeus = _x;
		_player assignCurator _zeus;
	};
} forEach _zeusList;

if !(isNil "_zeus") exitWith {};

_zeusList = _zeusList select {
	private _owner = _x getVariable 'owner';
	(isNil '_owner')
};
if (_zeusList isEqualTo []) exitWith {};
_zeus = _zeusList param [0];
_zeus setVariable ["owner",_uid,true];
_zeus setVariable ["zeus_uid",_uid,true];
_player assignCurator _zeus;
_zeus addCuratorEditableObjects [(vehicles + allUnits), true];

// onAdd function (will allow moving units to hc)
remoteExec ["zeus_fnc_onAdd",_player];