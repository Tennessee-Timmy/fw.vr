/* ----------------------------------------------------------------------------
Function: ai_ins_fnc_postInit

Description:
	postInit script for ai ins plugin

Parameters:
	none
Returns:
	nothing
Examples:
	Runs in postinit (from functions.cpp)

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Script begins

// spawn a new thread so we can wait for headless to set up
[] spawn {
	waitUntil {!isNil "mission_headless_setup"};
	if !(mission_headless_controller) exitWith { };
	call ai_ins_fnc_loop;
};

// if client, add zeus modules
if (hasInterface) then {
	call ai_ins_fnc_addZeusModules;
};