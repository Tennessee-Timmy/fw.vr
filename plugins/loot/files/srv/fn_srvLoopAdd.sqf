/* ----------------------------------------------------------------------------
Function: loot_fnc_srvLoopAdd

Description:
	Adds per frame eventhandler to cba and loops through all cluster

Parameters:
	none

Returns:
	nothing
Examples:
	call loot_fnc_srvLoopAdd;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

// exit if pfh handle exists
if (!isNil 'loot_loop_pfh') exitWith {};

loot_loop_pfh = [
	{
		for '_i' from 0 to 10 do {
			call loot_fnc_srvLoop;
		};
	},
	0
] call CBA_fnc_addPerFrameHandler;