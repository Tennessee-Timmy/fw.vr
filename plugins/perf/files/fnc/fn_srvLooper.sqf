/* ----------------------------------------------------------------------------
Function: perf_fnc_srvLooper

Description:
	looping functionality for server

Parameters:
	none
Returns:
	nothing
Examples:
	call perf_fnc_srvLooper;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

if (!isServer) exitWith {};
private _loop = missionNamespace getVariable ['perf_srvLoop',nil];
if (isNil '_loop') then {
	_loop = [] spawn {
		waitUntil {
			call perf_fnc_srvLoop;
			(missionNamespace getVariable ['perf_srvStop',false])
		};
		missionNamespace setVariable ['perf_srvStop',false];
		missionNamespace setVariable ['perf_srvLoop',nil,true];

		{
			_x setVariable ['perf_cachedArrSrv',[]];
			_x setVariable ['perf_cachedArrSrvNew',[]];
		} forEach allPlayers;
	};
	missionNamespace setVariable ['perf_srvLoop',_loop,true];
};
