/* ----------------------------------------------------------------------------
Function: safe_fnc_onRespawnUnit

Description:
	onRespawnUnit script for respawn system

Parameters:
	none
Returns:
	nothing
Examples:
	call safe_fnc_onRespawnUnit;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

if (player getVariable ['unit_safe_stop',false]) exitWith {};
call safe_fnc_enable;