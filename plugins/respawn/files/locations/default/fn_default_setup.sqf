/* ----------------------------------------------------------------------------
Function: respawn_fnc_default_setup

Description:
	Sets up the base respawn location

Parameters:
	none
Returns:
	nothing
Examples:
	call respawn_fnc_default_setup;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
if !(isServer) exitWith {};
// Code begins

// Set respawn location script
missionNamespace setVariable ["mission_respawn_location",{call respawn_fnc_default_respawn},true];