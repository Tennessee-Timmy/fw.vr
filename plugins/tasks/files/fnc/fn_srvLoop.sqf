/* ----------------------------------------------------------------------------
Function: tasks_fnc_srvLoop

Description:
	Server loops all the tasks if tasks_serverLoop_running is true
	This script won't run during briefing, so tasks won't update after 3 seconds...
Parameters:
	none
Returns:
	nothing
Examples:
	call tasks_fnc_srvLoop;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

if !(isserver) exitWith {};

// Variable to allow quitting loop
tasks_serverLoop_running = true;
[] spawn {
	uisleep 3;
	// Loop if variable is true
	while {tasks_serverLoop_running} do {

		// Call the loop function
		call tasks_fnc_loop;

		// Wait 1 second before re-run
		sleep 1;
	};
};