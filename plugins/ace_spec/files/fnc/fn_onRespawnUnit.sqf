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
[false] call ace_spectator_fnc_setSpectator;

if (!isNil "ace_spec_updateLoop") then {
	terminate ace_spec_updateLoop;
};