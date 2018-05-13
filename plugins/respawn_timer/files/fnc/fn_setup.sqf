/* ----------------------------------------------------------------------------
Function: respawn_timer_fnc_setup

Description:
	Sets up the timer respawn script aka. "mission_respawn_type"
	Run on the server
Parameters:
	none
Returns:
	nothing
Examples:
	call respawn_timer_fnc_setup;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
if !(isServer) exitWith {};
// Code begins

// Set timer respawn script as the respawn script
missionNamespace setVariable ["mission_respawn_type",{call respawn_timer_fnc_onRespawn},true];

[[""],{call respawn_timer_fnc_onRespawnUnit},"onRespawnUnit",true] call respawn_fnc_scriptAdd;