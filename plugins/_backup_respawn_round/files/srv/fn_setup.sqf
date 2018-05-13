/* ----------------------------------------------------------------------------
Function: respawn_round_fnc_setup

Description:
	Sets up the round respawn script aka. "mission_respawn_type"
	Runs the respawn_round_fnc_serverTimer
	Run only on the server
Parameters:
	none
Returns:
	nothing
Examples:
	call respawn_round_fnc_setup;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
if !(isServer) exitWith {};
// Code begins

// Set wave respawn script as the respawn script
missionNamespace setVariable ["mission_respawn_type",{call respawn_round_fnc_onRespawn},true];

// add onRespawnUnit script
[[""],{call respawn_round_fnc_onRespawnUnit},"onRespawnUnit",true] call respawn_fnc_scriptAdd;

// Start the server timer
[] spawn respawn_round_fnc_loopSrv;