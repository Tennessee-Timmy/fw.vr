/* ----------------------------------------------------------------------------
Function: spec_fnc_onRespawn

Description:
	onRespawn script for respawn system
	starts spectator

Parameters:
	none
Returns:
	nothing
Examples:
	call spec_fnc_onRespawn;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// Update spec modes
["Initialize", [player, [], false]] call BIS_fnc_EGSpectator;