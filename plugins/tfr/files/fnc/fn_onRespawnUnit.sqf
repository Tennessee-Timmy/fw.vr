/* ----------------------------------------------------------------------------
Function: tfr_fnc_onRespawnUnit

Description:
	onRespawnUnit script for respawn system
	disable specator functionality.

Parameters:
	none
Returns:
	nothing
Examples:
	call tfr_fnc_onRespawnUnit;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// disable tfr spectator functionality
[player, false] spawn TFAR_fnc_forceSpectator;