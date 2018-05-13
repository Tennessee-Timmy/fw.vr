/* ----------------------------------------------------------------------------
Function: cookoff_fnc_preInit

Description:
	cookoff

Parameters:
	none
Returns:
	nothing
Examples:
	call cookoff_fnc_preInit;
	Runs in the postInit from functions.cpp

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

if (!isServer) exitWith {};

addMissionEventHandler ['EntityKilled',{(_this select 0) call cookOff_fnc_cookoffVehicle}];