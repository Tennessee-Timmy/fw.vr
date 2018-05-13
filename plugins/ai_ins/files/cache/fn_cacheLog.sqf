/* ----------------------------------------------------------------------------
Function: ai_ins_fnc_cacheLog

Description:
	caching logic for array

Parameters:
0:	_pad			- pad to run cache logic on
Returns:
	nothing
Examples:
	call ai_ins_fnc_cacheLog;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params [['_pad',objNull]];

if (isNull _pad) exitWith {};

private _pos = getpos _pad;

// check if caching allowed
private _allow = [_pad,"allowCaching",true] call ai_ins_fnc_findParam;

if !(_allow) exitWith {};

// find the params needed in this script
private _group = [_pad,"group",false] call ai_ins_fnc_findParam;
private _cached = [_pad,"cached",false] call ai_ins_fnc_findParam;
private _cached2 = [_pad,"cached2",false] call ai_ins_fnc_findParam;
private _allowCaching = [_pad,"allowCaching",true] call ai_ins_fnc_findParam;
private _allowCaching2 = [_pad,"allowCaching2",false] call ai_ins_fnc_findParam;
private _cachedTime = [_pad,"cachedTime",0] call ai_ins_fnc_findParam;
private _cachedTimeBuffer = [_pad,"cachedTimeBuffer",5] call ai_ins_fnc_findParam;
private _cachedPos = [_pad,"cachedPos",[_pos]] call ai_ins_fnc_findParam;
private _cacheRange = [_pad,"cachingRange",[700,800]] call ai_ins_fnc_findParam;
private _cacheRange2 = [_pad,"cachingRange2",[500,550]] call ai_ins_fnc_findParam;



//--- First stage caching (deleting)
if (_allowCaching) then {
	call {
		// check if minimum time needed to change cache state again is reached
		if ((time - _cachedTime) < _cachedTimeBuffer) exitWith {};

		// cached means deleted
		if (_cached) then {

			// position to be used for uncache check (first member of group)
			private _pos = _cachedPos param [0];

			// distance to be used for uncache check
			private _distance = _cacheRange param [0];

			// if check succeeds (players in distance) uncache the group
			if ([_pos,_distance] call ai_ins_fnc_cacheCheck) exitWith {
				_pad call ai_ins_fnc_uncache;
			};
		} else {

			// check to make sure group exists and has at least 1 member
			if (_group isEqualType false || {(units _group isEqualTo [])}) exitWith {};

			// position to be used for cache check
			private _pos = getPos leader _group;

			// distance to be used for cache checck
			private _distance = _cacheRange param [1];

			// if no players in range, cache the group
			if !([_pos,_distance] call ai_ins_fnc_cacheCheck) exitWith {
				_pad call ai_ins_fnc_cache;
			};
		};
	};
};

//--- Second stage caching (hideObject)
// todo probably remove
if (_allowCaching2) then {
	private _pos = getPos leader _group;

	// cached2 means group is hidden
	if (_cached2) then {
		private _distance = _cacheRange2 param [0];
		if ([_pos,_distance] call ai_ins_fnc_cacheCheck) exitWith {
			_pad call ai_ins_fnc_unCache2;
		};
	} else {
		private _distance = _cacheRange2 param [1];
		if !([_pos,_distance] call ai_ins_fnc_cacheCheck) exitWith {
			_pad call ai_ins_fnc_cache2;
		};
	};
};