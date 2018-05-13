/* ----------------------------------------------------------------------------
Function: ai_ins_fnc_check

Description:
	Runs in the main loop. Checks if the units are dead and if
	the array needs to be deleted

Parameters:
0:  _pad			- pad to check

Returns:
0:	_bool			- True if groups is good, false if it's bad and got deleted
Examples:
	_arr call ai_ins_fnc_check;

Author:
	nigel
---------------------------------------------------------------------------- */
//#include "script_component.cpp"
// Code begins

params [['_pad',objNull]];

// get pads, so we can delete from
private _pads = missionNamespace getVariable ['ai_ins_pads',[]];
private _gPads = missionNamespace getVariable ['ai_ins_gPads',[]];

// delete if pad is not there
if (isNull _pad) exitWith {
	_pads deleteAt (_pads find _pad);
	false
};

// find the params needed in this script
private _group = [_pad,"group",false] call ai_ins_fnc_findParam;
private _cached = [_pad,"cached",false] call ai_ins_fnc_findParam;
private _cachedPos = [_pad,"cachedPos",[]] call ai_ins_fnc_findParam;
private _garrison = [_pad,"garrisonUnit",false] call ai_ins_fnc_findParam;

// active group check
if !(_cached) exitWith {

	// check if garrison is defined (means unit is from garrison pool)
	if (!(_garrison isEqualType false) && {isNull _garrison || {!alive _garrison}}) exitWith {

		// delete from pads
		_gPads deleteAt (_gPads find _pad);
		false
	};

	// check if group exists and there are alive units
	if (isNil {_group} || {_group isEqualType false || {((units _group) select {alive _x}) isEqualTo []}}) then {

		// delete from pads
		_pads deleteAt (_pads find _pad);
		false
	};
	true
};

// cached checks
if (_cached && _cachedPos isEqualTo []) exitWith {

	// if garrison is enabled
	if !(_garrison isEqualType false) exitWith {

		// delete from pads
		_gPads deleteAt (_gPads find _pad);
		false
	};

	// if it's from groups
	if !(_group isEqualType false) then {

		// delete from pads
		_pads deleteAt (_pads find _pad);
		false
	};
};
true