/* ----------------------------------------------------------------------------
Function: spec_fnc_postInit

Description:
	spectator init

Parameters:
	none
Returns:
	nothing
Examples:
	call spec_fnc_postInit;
	Runs in the postInit from functions.cpp

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

if (isServer) then {
	[[""],{call spec_fnc_onRespawn},"onRespawn",true] call respawn_fnc_scriptAdd;
	[[""],{call spec_fnc_onRespawnUnit},"onRespawnUnit",true] call respawn_fnc_scriptAdd;
};

if (hasInterface) then {
	// Add admin menus
	if ("menus" in mission_plugins) then {
		[["Spec. Plugin","call spec_fnc_menu",[{true},{false}],true],[player]] call menus_fnc_registerItem;
	};
};