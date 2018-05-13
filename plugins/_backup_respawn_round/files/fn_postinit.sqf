/* ----------------------------------------------------------------------------
Function: respawn_round_fnc_postInit

Description:
	Adds eventhandelers to players
	Sets up the respawn type round

Parameters:
	none
Returns:
	nothing
Examples:
	call respawn_round_fnc_postInit;
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
		call respawn_round_fnc_setup;
	};
	if !(hasInterface) exitWith {};
	call respawn_round_fnc_loop;
};