/* ----------------------------------------------------------------------------
Function: perf_fnc_clusterLooper

Description:
	looping functionality for clusters

Parameters:
	none
Returns:
	nothing
Examples:
	call perf_fnc_clusterLooper;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

private _loop = missionNamespace getVariable ['perf_clusterLoop',nil];
if (isNil '_loop') then {
	_loop = [] spawn {
		waitUntil {
			call perf_fnc_clusterLoop;
			(missionNamespace getVariable ['perf_clusterStop',false])
		};
		missionNamespace setVariable ['perf_clusterStop',false];
		missionNamespace setVariable ['perf_clusterLoop',nil];
	};
	missionNamespace setVariable ['perf_clusterLoop',_loop];
};
