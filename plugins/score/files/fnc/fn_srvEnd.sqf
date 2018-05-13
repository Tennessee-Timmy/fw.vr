/* ----------------------------------------------------------------------------
Function: score_fnc_srvEnd

Description:
	Runs on end, only on server

Parameters:
	none
Returns:
	nothing
Examples:
	call score_fnc_srvEnd;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

if !(isServer) exitWith {};

private _scoreList = ["mission_score_list",[]] call seed_fnc_getVars;
missionNamespace setVariable ["mission_score_list",_scoreList,true];

remoteExec ["score_fnc_end",allPlayers];