/* ----------------------------------------------------------------------------
Function: menus_fnc_isAdmin

Description:
	Checks if script is running for an admin

Parameters:
	none
Returns:
	nothing
Examples:
	call menus_fnc_isAdmin;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

(
	(serverCommandAvailable "#logout") ||
	(isServer) ||
	((getPlayerUID player) in MISSION_SETTINGS_ADMINLIST)
)