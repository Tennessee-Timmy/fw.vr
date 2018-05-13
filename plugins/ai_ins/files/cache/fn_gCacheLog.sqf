/* ----------------------------------------------------------------------------
Function: ai_ins_fnc_gCacheLog

Description:
	caching logic for garrisond units

Parameters:
0:  _pad			- pad to run cache logic for
Returns:
	nothing
Examples:
	call ai_ins_fnc_gCacheLog;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params [['_pad',objNull]];

if (isNull _pad) exitWith {};

private _pos = getpos _pad;

// get parameters
private _gCached = [_pad,"cached",false] call ai_ins_fnc_findParam;
private _cacheRange = [_pad,"cachingRange",[800,900]] call ai_ins_fnc_findParam;
private _cachedTime = [_pad,"cachedTime",0] call ai_ins_fnc_findParam;
private _cachedTimeBuffer = [_pad,"cachedTimeBuffer",5] call ai_ins_fnc_findParam;
private _cachedPos = [_pad,"cachedPos",[_pos]] call ai_ins_fnc_findParam;
private _allow = [_pad,"allowCaching",true] call ai_ins_fnc_findParam;

if !(_allow) exitWith {};

// check if minimum time needed to change cache state again is reached
if ((time - _cachedTime) < _cachedTimeBuffer) exitWith {};

// cached means deleted
if (_gCached) then {

	// get cachedpos and distance
	private _distance = _cacheRange param [0];
	private _pos = _cachedPos param [0];

	// check if unit in distance
	if ([_pos,_distance] call ai_ins_fnc_cacheCheck) exitWith {

		[_pad] call ai_ins_fnc_gUnCache;
	};
} else {

	// get the unit object
	private _unit = [_pad,"garrisonUnit",objNull] call ai_ins_fnc_findParam;

	// make sure it exists
	if (isNull _unit) exitWith {};

	// 2nd distance (provides buffer)
	private _distance = _cacheRange param [1];

	// getpostATL
	private _pos = getposATL _unit;
	private _distance = _cacheRange param [1];

	// check if there are NO units in the area around
	if !([_pos,_distance] call ai_ins_fnc_cacheCheck) exitWith {
		[_pad] call ai_ins_fnc_gCache;
	};
};