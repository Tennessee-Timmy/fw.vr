/* ----------------------------------------------------------------------------
Function: zeus_fnc_checkPerf

Description:
	Checks performance of everyone and sets global variables
	Used for remoteExec in headless_fnc_displayPerf

Parameters:
	none
Returns:
	nothing
Examples:
	// run for everyone
	remoteExec ["zeus_fnc_checkPerf",0];

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// server perf
if (isServer) then {
	checkPerf_server_fps = diag_fps;
	publicVariable 'checkPerf_server_fps';
	checkPerf_server_units = {owner _x isEqualTo 2}count allUnits;
	publicVariable "checkPerf_server_units";
	if (isNil "headless_client") then {
		checkPerf_hc_units = 0;
	} else {
		checkPerf_hc_units = {owner _x isEqualTo (owner headless_client)}count allunits;
	};
	publicVariable 'checkPerf_hc_units';
};

// hc perf
if (!isServer && !hasInterface) then {
	checkPerf_hc_fps = diag_fps;
	publicVariable 'checkPerf_hc_fps';
};

// client perf
if (hasInterface) then {
	player setVariable ['checkPerf_client_fps',diag_fps,true];
};