/* ----------------------------------------------------------------------------
Function: round_fnc_setup

Description:
	Sets up the round respawn script aka. "mission_type"
	Runs the round_fnc_serverTimer
	Run only on the server
Parameters:
	none
Returns:
	nothing
Examples:
	call round_fnc_setup;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
if !(isServer) exitWith {};
// Code begins

// Set wave respawn script as the respawn script
missionNamespace setVariable ["mission_type",{call round_fnc_onRespawn},true];

// add onRespawnUnit script
[[""],{call round_fnc_onRespawnUnit},"onRespawnUnit",true] call respawn_fnc_scriptAdd;

// Start the server timer
round_main_loop = [] spawn round_fnc_loopGameSrv;