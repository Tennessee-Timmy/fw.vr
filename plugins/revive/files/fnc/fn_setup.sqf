/* ----------------------------------------------------------------------------
Function: revive_fnc_setup

Description:
	Sets up the revive respawn script aka. "mission_respawn_type"
	Run only on the server
Parameters:
	none
Returns:
	nothing
Examples:
	call revive_fnc_setup;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
if !(isServer) exitWith {};
// Code begins

// Set wave respawn script as the respawn script
missionNamespace setVariable ["mission_respawn_type",{call revive_fnc_onRespawn},true];

// add onRespawnUnit script
[[""],{call revive_fnc_onRespawnUnit},"onRespawnUnit",true] call respawn_fnc_scriptAdd;
[[""],{call revive_fnc_onRespawn},"onRespawn",true] call respawn_fnc_scriptAdd;
//[[""],{call revive_fnc_onKilled},"onKilled",true] call respawn_fnc_scriptAdd;


missionNamespace setVariable ["mission_respawn_location",{call revive_fnc_location},true];

// server loop for waved respawns
call revive_fnc_srvLoop;