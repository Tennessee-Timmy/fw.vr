/* ----------------------------------------------------------------------------
Function: revive_fnc_onKilled

Description:
	Throws players out of vehicles (so revive can operate properly)

Parameters:
0:	_oldUnit		- the unit that died
1:	_killer			- Suspected killer

Returns:
	nothing
Examples:
	_unit call revive_fnc_onKilled;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_oldUnit",'_killer'];

// exit if player on foot
if (isNull objectParent _oldUnit) exitWith {};

// move body out of vehicle
_oldUnit setPosASL (getPosASL _oldUnit);

// check if unit has been moved out or not
[_oldUnit] spawn {
	params ['_oldUnit'];
	sleep 1;
	if (isNull objectParent _oldUnit) exitWith {};

	// create a new body
	private _newUnit = (createGroup west) createUnit ["B_Soldier_F", [0,0,0], [], 0, "NONE"];

	// hide the new body
	[_newUnit,true] remoteExec ['hideObjectGlobal',2];


	// change his loadout
	_newUnit setUnitLoadout (getUnitLoadout _oldUnit);

	// copy variables from old unit
	{
		_newUnit setVariable [_x,(_oldUnit getVariable [_x,nil]),true];
		false
	} count [
		'unit_revive_canBeRevived',
		'unit_cleaner_disabled',
		'unit_revive_newUnit'
	];

	// stop it from being deleted
	removeFromRemainsCollector [_newUnit];

	// get new player unit
	private _unit = _newUnit getVariable ['unit_revive_newUnit',objNull];

	// if player unit exists, set the new unit as the oldunit
	if (!isNull _unit) then {
		_unit setVariable ['unit_revive_oldUnit',_newUnit,true];
	};

	// wait for everything to change
	sleep 0.1;

	// move the new unit
	_newUnit setPosASL (getPosASL _oldUnit);

	// kill him
	_newUnit setDamage 1;

	// attempt to delete old unit
	deleteVehicle _oldUnit;
	sleep 1;

	// reveal the new unit

	// hide the new body
	[_newUnit,false] remoteExec ['hideObjectGlobal',2];
};