/* ----------------------------------------------------------------------------
Function: perf_fnc_postInit

Description:
	perf postinit

Parameters:
	none
Returns:
	nothing
Examples:
	call perf_fnc_postInit;
	Runs in the postInit from functions.cpp

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

call perf_fnc_clusterLooper;

if (isServer) then {
	// server
	call perf_fnc_srvInit;
	call perf_fnc_srvLooper;
};

if (!hasInterface) exitWith {};

call perf_fnc_clientInit;
call perf_fnc_clientLooper;