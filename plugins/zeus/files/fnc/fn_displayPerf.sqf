/* ----------------------------------------------------------------------------
Function: zeus_fnc_displayPerf

Description:
	Displays the performance of clients/server/hc

Parameters:
	none
Returns:
	nothing
Examples:
	call zeus_fnc_displayPerf;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// Spawn, so it's in scheduled environment
[] spawn {
	remoteExec ["zeus_fnc_checkPerf",0];
	systemChat 'collecting data...';

	// sleep a second + 0.1 extra for every player
	sleep 1 + (count PLAYERLIST)/10;

	// check the client fps
	private _client_fps = 0;
	private _client_fps_count = {
		_client_fps = _client_fps + (_x getVariable ["checkPerf_client_fps",0]);
		true
	} count PLAYERLIST;

	// calculate avg
	private _client_fps_avg = _client_fps / _client_fps_count;
	private _server_fps = missionNamespace getVariable ["checkPerf_server_fps",0];
	private _hc_fps = missionNamespace getVariable ["checkPerf_hc_fps",0];

	private _text = format ["CLIENT AVG FPS: %1 | SERVER FPS: %2 | HC FPS: %3",(round _client_fps_avg),(round _server_fps),(round _hc_fps)];
	systemChat _text;
	hint _text;

	systemChat format ["TOTAL UNITS: %1 | SERVER UNITS: %2 | HC UNITS: %3",count allunits,checkPerf_server_units,checkPerf_hc_units];
};