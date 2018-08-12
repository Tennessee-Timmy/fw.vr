/* ----------------------------------------------------------------------------
Function: supp_fnc_postInit

Description:
	runs everything for the suppression

Parameters:
	none
Returns:
	nothing
Examples:
	call supp_fnc_postInit;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

mission_supp_mainArray = [];
mission_supp_suppressed = false;
mission_supp_threshold = 0;  // Changing value
mission_supp_lastShotAt = 0; // The time the player got shot at last time (Just creates the variable)
mission_supp_variableHandler = call CBA_fnc_createNamespace;
mission_supp_enabled = true;
