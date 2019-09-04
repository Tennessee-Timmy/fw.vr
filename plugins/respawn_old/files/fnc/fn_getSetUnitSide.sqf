/* ----------------------------------------------------------------------------
Function: respawn_fnc_getSetUnitSide

Description:
	Sets the side of the unit variable "unit_respawn_side"
	Returns the side
	Does not change the side of the group/unit
	Only checks side of the unit not group
Parameters:
0:	_unit 		- unit of which side to get
Returns:
	_unitSide 	- side of the unit (west,east etc.)
Examples:
	_unitSide = _unit call respawn_fnc_getSetUnitSide;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_unit"];
private _last = 0;
private _unitSide = nil;
private _ext = false;

waitUntil {
	if (isNil {_unit} || {isNull _unit}) exitWith {
		_ext = true;
		true
	};
	_unitSide = _unit getVariable ["unit_respawn_side",nil];

	if (isNil "_unitSide") then {
		if (local _unit) then {
			_unitSide = (side (group player));
			if (_unitSide isEqualTo sideUnknown) exitWith {
				_unit setVariable ["unit_respawn_side",_unitSide,true];
				_ext = true;
				true
			};
		} else {
			if ((diag_ticktime - _last) > 1) then {
				sleep 1;
				_unit remoteExec ['respawn_fnc_getSetUnitSide',_unit];
				_last = diag_tickTime;
			};
		};
	};
	if (isNil "_unitSide") exitWith {false};
	!(_unitSide isEqualTo sideUnknown)
};
if (_ext) exitWith {sideUnknown};
if (local _unit) then {
	_unit setVariable ["unit_respawn_side",_unitSide,true];
};
_unitSide