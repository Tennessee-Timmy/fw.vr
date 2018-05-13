/* ----------------------------------------------------------------------------
Function: tpb_fnc_postInit

Description:
	Runs third person block for players

Parameters:
	none
Returns:
	nothing
Examples:
	call tpb_fnc_postInit;
	Runs in the postInit from functions.cpp

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// Player init
if (hasInterface) then {
	call tpb_fnc_blocker;
};