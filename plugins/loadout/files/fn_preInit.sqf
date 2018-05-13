/* ----------------------------------------------------------------------------
Function: loadout_fnc_preInit

Description:
	Loadout init

Parameters:
	none
Returns:
	nothing
Examples:
	call loadout_fnc_preInit;
	Runs in the postInit from functions.cpp

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins


if (isServer) then {
	["All", "initPost", {_this call loadout_fnc_auto}] call CBA_fnc_addClassEventHandler;
};
