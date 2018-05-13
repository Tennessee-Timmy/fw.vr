/* ----------------------------------------------------------------------------
Function: jip_fnc_teleport

Description:
	Teleports player

Parameters:
0:	_unit			- unit to be teleported
1:	_toAny			- bool, true allows for unit to be teleported to anyone
Returns:
	nothing
Examples:
	call jip_fnc_teleport;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

params ["_unit",["_toAny",false]];

private _targets = [(units _unit),(PLAYERLIST)] select _toAny;

_targets = _targets select {
	(_x != _unit) &&
	((side _x) isEqualTo (side _unit)) &&
	((_x findNearestEnemy _x) distanceSqr _x) > JIP_SETTINGS_TELEPORT_DIST &&
	!(_x getVariable ["ACE_isUnconscious",false]) &&
	!(_x call respawn_fnc_deadCheck)
};

if (_targets isEqualTo []) exitWith {systemChat 'Teleport failed, no valid targets'};
private _target = [_unit, _targets] call CBA_fnc_getNearest;
_targets = (_targets - [_target]);
_targets pushBack _target;
reverse _targets;

private _teleported = {
	private _vehicle = vehicle _x;
	private _moved = if (_x != _vehicle) then {
		_unit moveInAny _vehicle;
	} else {
		private _position = getPosATL _x findEmptyPosition [1, 30, typeOf _unit];
		if (count _position > 0) exitWith {
			_unit setPosATL _position;
			true
		};

		false
	};

	if (_moved) exitWith {true};

	false
} forEach _targets;

if (_teleported) then {
	_unit setVariable ["unit_jip_used",true];
};