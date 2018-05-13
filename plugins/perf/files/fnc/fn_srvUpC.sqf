/* ----------------------------------------------------------------------------
Function: perf_fnc_srvUpC

Description:
	Updates the cached list on the server
	Used in clientInit to make sure server gets the latest info asap

Parameters:
0:	_newCached				- array, of the new cached units to add on server
1:	_target				- object, defaults to player

Returns:
	nothing
Examples:
	[_cached] call perf_fnc_srvUpC;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

params [['_newCached',[]],['_target',player],['_remove',false]];

// make sure we are not sending the same data twice
_newCached = _newCached arrayIntersect _newCached;

// if not server, remote exec to server
if (!isServer) exitWith {
	[_newCached,_target,_remove] remoteExec ['perf_fnc_srvUpC',2];
};

// get current cached array new
private _cached = _target getVariable 'perf_cachedArrSrvNew';
if (isNil '_cached') then {
	_cached = [];
	_target setVariable ['perf_cachedArrSrvNew',_cached];
};

// get current cached array remove
private _cachedRem = _target getVariable 'perf_cachedArrSrvRem';
if (isNil '_cachedRem') then {
	_cachedRem = [];
	_target setVariable ['perf_cachedArrSrvRem',_cachedRem];
};

if (_remove) exitWith {
	_cachedRem append _newCached;
};

_cached append _newCached;