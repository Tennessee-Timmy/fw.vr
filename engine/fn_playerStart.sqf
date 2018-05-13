/* ----------------------------------------------------------------------------
Function: mission_fnc_playerStart

Description:
	Makes the player wait for server initialization

Parameters:
	none
Returns:
	nothing
Examples:
	call mission_fnc_playerStart
Author:
	nigel
---------------------------------------------------------------------------- */
// Code begins

if (isServer) exitWith {};

waitUntil {
	private _serverLoaded = missionNamespace getVariable ["mission_server_loaded",false];
	_serverLoaded
};