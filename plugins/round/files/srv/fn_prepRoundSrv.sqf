/* ----------------------------------------------------------------------------
Function: round_fnc_prepRoundSrv

Description:
	Prepares the round

Parameters:
	none

Returns:
	nothing
Examples:
	call round_fnc_prepRoundSrv;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

// Code begins
if !(isServer) exitWith {};

// delete dead bodies
private _nil = {deleteVehicle _x;false}count allDead;

// respawn everyone * now on client
// todo moved this to prestart
//[] call respawn_fnc_respawn;
sleep 1;

// run prep for clients
// todo only on clients based on variable
//remoteExec ['round_fnc_prepRound'];


// srv code
private _srvCodeFile = "plugins\round\code\srv.sqf";

private _onPrepCodeSrv = {};
if (_srvCodeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _srvCodeFile;
	call _onPrepCodeSrv;
};