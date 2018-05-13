/* ----------------------------------------------------------------------------
Function: acre_fnc_onRespawnUnit

Description:
	onRespawnUnit script for respawn system
	disable specator functionality.

Parameters:
	none
Returns:
	nothing
Examples:
	call acre_fnc_onRespawnUnit;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// disable acre spectator functionality
[] call acre_sys_core_fnc_spectatorOff;

// add radios
if (missionNamespace getVariable ['mission_acre_addEnabled',false]) then {
	call acre_fnc_addRadios;
};