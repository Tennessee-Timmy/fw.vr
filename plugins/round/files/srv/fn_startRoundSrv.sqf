/* ----------------------------------------------------------------------------
Function: round_fnc_startRoundSrv

Description:
	starts the round

Parameters:
	none

Returns:
	nothing
Examples:
	call round_fnc_startRoundSrv;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

// Code begins
if !(isServer) exitWith {};

// srv code
private _srvCodeFile = format ["plugins\round\code\srv.sqf",''];

private _onRoundStartCodeSrv = {};
if (_srvCodeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _srvCodeFile;
	call _onRoundStartCodeSrv;
};
missionNamespace setVariable ['mission_round_msg','START!',true];

// run start for clients
// do this on clients now todo
//remoteExec ['round_fnc_startRound'];