/* ----------------------------------------------------------------------------
Function: perf_fnc_clusterLoop

Description:
	cluster loop script
	code to run every frame/time loop runs

Parameters:
	none
Returns:
	nothing
Examples:
	call perf_fnc_clusterLoop;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

if (isServer) then {
	[true] call perf_fnc_updateClusters;
};
[false] call perf_fnc_updateClusters;