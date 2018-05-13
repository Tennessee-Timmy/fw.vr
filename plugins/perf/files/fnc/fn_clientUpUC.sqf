/* ----------------------------------------------------------------------------
Function: perf_fnc_clientUpUC

Description:
	Updates the to uncache list on the client

Parameters:
0:	_newToUnCache		- array, of the new un-cache units for client
1:	_target				- player to run it for
2:	_remove				- remove from to uncache

Returns:
	nothing
Examples:
	[_toUnCache,_player] call perf_fnc_clientUpUC;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

params [['_newToUnCache',[]],['_target',objNull],['_remove',false]];

// exit if target invalid
if (isNull _target) exitWith {};

// if not local, remote exec where local
if (!local _target) exitWith {
	[_newToUnCache,_target,_remove] remoteExec ['perf_fnc_clientUpUC',_target];
};

// get current cached array new
private _toUnCache = _target getVariable 'perf_toUnCacheNew';
if (isNil '_toUnCache') then {
	_toUnCache = [];
	_target setVariable ['perf_toUnCacheNew',_toUnCache];
};

// get current cached array remove
private _cachedRem = _target getVariable 'perf_toUnCacheRem';
if (isNil '_cachedRem') then {
	_cachedRem = [];
	_target setVariable ['perf_toUnCacheRem',_cachedRem];
};

if (_remove) exitWith {
	_cachedRem append _newToUnCache;
};

_toUnCache append _newToUnCache;

_toUnCache = _toUnCache arrayIntersect _toUnCache;

player setVariable ['perf_toUnCacheNew',_toUnCache];