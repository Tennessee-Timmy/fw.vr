/* ----------------------------------------------------------------------------
Function: tfr_fnc_onRespawn

Description:
	onRespawn script for respawn system
	Enable spectator functionality

Parameters:
	none
Returns:
	nothing
Examples:
	call tfr_fnc_onRespawn;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// force tfr spectator functionality
[player, true] spawn TFAR_fnc_forceSpectator;
