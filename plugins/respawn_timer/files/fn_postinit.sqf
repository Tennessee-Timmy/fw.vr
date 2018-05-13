/* ----------------------------------------------------------------------------
Function: respawn_timer_fnc_postInit

Description:
	Adds eventhandelers to players
	Sets up the respawn types and respawn scripts

Parameters:
	none
Returns:
	nothing
Examples:
	call respawn_timer_fnc_postInit;
	Runs in the postInit from functions.cpp

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

[] spawn {

	// wait for respawn plugin!
	waitUntil {!(isNil "mission_respawn_serverReady")};
	// Server init
	if (isServer) then {
		call respawn_timer_fnc_setup;
	};
};