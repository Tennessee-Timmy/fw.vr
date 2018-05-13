/* ----------------------------------------------------------------------------
Function: round_fnc_endRoundSrv

Description:
	Ends the round

Parameters:
	none

Returns:
	nothing
Examples:
	call round_fnc_endRoundSrv;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

// Code begins
if !(isServer) exitWith {};

// srv code
private _srvCodeFile = format ["plugins\round\code\srv.sqf",''];

private _onRoundEndCodeSrv = {};
if (_srvCodeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _srvCodeFile;
	call _onRoundEndCodeSrv;
};

// run start for clients
remoteExec ['round_fnc_endRound'];