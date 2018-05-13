/* ----------------------------------------------------------------------------
Function: mission_fnc_serverDone

Description:
	Sets the server as done initializing

Parameters:
	none
Returns:
	nothing
Examples:
	call mission_fnc_serverDone
Author:
	nigel
---------------------------------------------------------------------------- */
// Code begins

if !(isServer) exitWith {};

missionNamespace setVariable ["mission_server_loaded",true,true];

"server done" call debug_fnc_log;