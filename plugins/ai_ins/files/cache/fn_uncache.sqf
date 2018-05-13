/* ----------------------------------------------------------------------------
Function: ai_ins_fnc_unCache

Description:
	Caching check. Checks if players are in distance

Parameters:
0:  _pad	 		- pad to cache
Returns:
	bool			- are players inside the distance (< _distance)
Examples:
	_array call ai_ins_fnc_unCache

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params [['_pad',objNull]];

if (isNull _pad) exitWith {};

private _pos = getpos _pad;

// check if groups is not cached, quit if it's not cached
private _cached = [_pad,"cached",false] call ai_ins_fnc_findParam;
if !(_cached) exitWith {};

// get cached position(s)
private _cachedPos = [_pad,"cachedPos",[_pos]] call ai_ins_fnc_findParam;

// set the first element as cached position (spawning position)
_cachedPos = (_cachedPos param [0]);

// update cached time
[_pad,"cachedTime",time] call ai_ins_fnc_setParam;
[_pad,"savedPos",_cachedPos] call ai_ins_fnc_setParam;

// spawn in the group and get it's group
_group = [_pad,_cachedPos,nil,nil,[],true] call ai_ins_fnc_spawn;

// set the group variable as group
[_pad,"group",_group] call ai_ins_fnc_setParam;