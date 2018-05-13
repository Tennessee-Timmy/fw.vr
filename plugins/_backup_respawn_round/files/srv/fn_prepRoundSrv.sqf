/* ----------------------------------------------------------------------------
Function: respawn_round_fnc_prepRoundSrv

Description:
	Prepares the round

Parameters:
	none

Returns:
	nothing
Examples:
	call respawn_round_fnc_prepRoundSrv;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

// Code begins
if !(isServer) exitWith {};

// respawn everyone * now on client
[] call respawn_fnc_respawn;
sleep 1;

// run prep for clients
remoteExec ['respawn_round_fnc_prepRound'];


// srv code
private _srvCodeFile = "plugins\respawn_round\code\srv.sqf";

private _onPrepCodeSrv = {};
if (_srvCodeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _srvCodeFile;
	call _onPrepCodeSrv;
};