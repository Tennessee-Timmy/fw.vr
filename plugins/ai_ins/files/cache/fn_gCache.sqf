/* ----------------------------------------------------------------------------
Function: ai_ins_fnc_gCache

Description:
	caching for garrisond units

Parameters:
0:  _pad			- pad to cache
Returns:
	nothing
Examples:
	call ai_ins_fnc_gCache;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params [['_pad',objNull]];

if (isNull _pad) exitWith {};

private _cached = [_pad,"cached",false] call ai_ins_fnc_findParam;

if (_cached) exitWith {};

// get the unit object
private _unit = [_pad,"garrisonUnit",objNull] call ai_ins_fnc_findParam;

// getpostATL
private _pos = getposATL _unit;
[_pad,"cached",true] call ai_ins_fnc_setParam;
[_pad,"cachedPos",[_pos]] call ai_ins_fnc_setParam;
[_pad,"cachedTime",time] call ai_ins_fnc_setParam;
deleteVehicle _unit;