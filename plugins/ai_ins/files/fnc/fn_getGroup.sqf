/* ----------------------------------------------------------------------------
Function: ai_ins_fnc_getGroup

Description:
	finds the group of the target from the groups pads

Parameters:
0:  _unit			- unit of which group to find
Returns:
	pad				- pad with the group or objNull
Examples:
	[_unit] call ai_ins_fnc_getGroup

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_unit"];

// make sure target is defined / exists
if (isNil "_unit" || {_unit isEqualTo objNull}) exitWith {};

// get all groups
private _groups = missionNamespace getVariable ['ai_ins_groups',[]];
private _group = group _unit;
private _pad = objNull;

// loop through all the groups and find a matching group
private _found = {
	private _checkPad = _x;
	private _checkGroup = [_checkPad,"group",grpNull] call ai_ins_fnc_findParam;

	// todo not needed
	//_nr = [_checkPad,"nr",0] call ai_ins_fnc_findParam;
	if (_checkGroup isEqualTo _group) exitWith {
		_pad = _x;
		1
	};
	false
} count _groups;
_pad