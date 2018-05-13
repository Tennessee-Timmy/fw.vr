/* ----------------------------------------------------------------------------
Function: acre_fnc_onRespawn

Description:
	onRespawn script for respawn system
	Enable spectator functionality

Parameters:
	none
Returns:
	nothing
Examples:
	call acre_fnc_onRespawn;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// force acre spectator functionality
[] call acre_sys_core_fnc_spectatorOn;
