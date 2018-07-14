/* ----------------------------------------------------------------------------
Function: ace_spec_fnc_onRespawnUnit

Description:
	onRespawnUnit script for respawn system
	closes spectator

Parameters:
	none
Returns:
	nothing
Examples:
	call ace_spec_fnc_onRespawnUnit;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// disable spectator
["Terminate"] call BIS_fnc_EGSpectator;