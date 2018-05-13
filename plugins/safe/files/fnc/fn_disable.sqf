/* ----------------------------------------------------------------------------
Function: safe_fnc_disable

Description:
	enables safe zone restrictions for the player

Parameters:
	none
Returns:
	nothing
Examples:
	call safe_fnc_disable;
Author:
	nigel
	help from commy2
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

if (!hasInterface) exitWith {};

// remove old action / eachFrame
private _action = player getVariable 'unit_safe_action';
if (!isNil '_action') then {
	player removeAction _action;
};

player setVariable ['unit_safe_stop',true];