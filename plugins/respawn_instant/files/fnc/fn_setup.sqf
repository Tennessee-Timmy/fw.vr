/* ----------------------------------------------------------------------------
Function: respawn_instant_fnc_setup

Description:
	Sets up the instant respawn script aka. "mission_respawn_type"
	Run on the server
Parameters:
	none
Returns:
	nothing
Examples:
	call respawn_instant_fnc_setup;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
if !(isServer) exitWith {};
// Code begins

// Set instant respawn script as the respawn script
missionNamespace setVariable ["mission_respawn_type",{call respawn_instant_fnc_onRespawn},true];