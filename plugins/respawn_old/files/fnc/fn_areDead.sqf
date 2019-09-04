/* ----------------------------------------------------------------------------
Function: respawn_fnc_areDead

Description:
	Checks if all the units in the list are dead

Parameters:
0:	_targets		- Array of targets
Returns:
	_dead		- True if players is in list in the deadlist
				False if no array as parameter
Examples:
	_dead = [player,blu_1_1] call respawn_fnc_areDead;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

private _targets = [_this] param [0];

if !(_targets isEqualType []) exitWith {systemChat "areDead fail no array";false};

// Get mission dead list from seed
private _deadArray =  missionNamespace getVariable ["mission_respawn_deadList",[]];

private _dead = false;
private _units = [];
{
	if (_x isEqualType "") then {
		private _target = missionNamespace getVariable [_x,nil];
		if (!isNil "_target") then {
			_units pushBackUnique _target;
		};
	};
	if (_x isEqualType objNull) then {
		_units pushBackUnique _x;
	};
} forEach _targets;

_units = _units select {
	!(isNil "_x") &&
	{!isNull _x}
};

private _deadCount = {
	private _unit = _x;
	if (isPlayer _unit) then {
		(_unit call respawn_fnc_deadCheck)
	} else {
		(!alive _unit)
	};
} count _units;

(count _units) isEqualTo _deadCount