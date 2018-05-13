/* ----------------------------------------------------------------------------
Function: ai_ins_fnc_padPos

Description:
	Sets the pad position to cached unit or group leader

Parameters:
0:  _pad			- pad to move

Returns:
	none
Examples:
	_pad call ai_ins_fnc_padPos;

Author:
	nigel
---------------------------------------------------------------------------- */
//#include "script_component.cpp"
// Code begins

params [['_pad',objNull]];

if (isNull _pad) exitWith {};

private _pos = getpos _pad;

// find the params needed in this script
private _group = [_pad,"group",false] call ai_ins_fnc_findParam;
private _cached = [_pad,"cached",false] call ai_ins_fnc_findParam;
private _cachedPos = [_pad,"cachedPos",[]] call ai_ins_fnc_findParam;
private _garrison = [_pad,"garrisonUnit",false] call ai_ins_fnc_findParam;

// active group check
if !(_cached) exitWith {

	// check if garrison is defined (means unit is from garrison pool)
	if !(_garrison isEqualType false) exitWith {
		_pad setpos (getpos _garrison);
	};
	_pad setpos (getpos (leader _group));
};

// cached checks
if !(_cachedPos isEqualTo []) exitWith {
	_pad setpos (_cachedPos param [0]);
};