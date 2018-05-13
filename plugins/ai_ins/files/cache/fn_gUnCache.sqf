/* ----------------------------------------------------------------------------
Function: ai_ins_fnc_gUnCache

Description:
	uncaching for garrisond units

Parameters:
0:  _pad			- pad to uncache
Returns:
	nothing
Examples:
	call ai_ins_fnc_gUnCache;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params [['_pad',objNull]];

if (isNull _pad) exitWith {};

private _pos = getpos _pad;

private _cached = [_pad,"cached",false] call ai_ins_fnc_findParam;
private _cachedPos = [_pad,"cachedPos",[_pos]] call ai_ins_fnc_findParam;
_cachedPos = _cachedPos param [0];
if !(_cached) exitWith {};


// update cached time
[_pad,"cached",false] call ai_ins_fnc_setParam;
[_pad,"cachedTime",time] call ai_ins_fnc_setParam;
[_pad,"savedPos",_cachedPos] call ai_ins_fnc_setParam;

// spawn in the group and get it's group
private _group = [_pad,_cachedPos,nil,nil,[],true] call ai_ins_fnc_spawn;