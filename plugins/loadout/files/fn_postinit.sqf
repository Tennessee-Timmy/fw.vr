/* ----------------------------------------------------------------------------
Function: loadout_fnc_postInit

Description:
	Loadout init

Parameters:
	none
Returns:
	nothing
Examples:
	call loadout_fnc_postInit;
	Runs in the postInit from functions.cpp

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins


if (isServer) then {
	[[""],{[(_this select 0),"empty"] call loadout_fnc_unit},"onRespawn",true] call respawn_fnc_scriptAdd;
	[[""],{call loadout_fnc_onRespawnUnit},"onRespawnUnit",true] call respawn_fnc_scriptAdd;
};

if (hasInterface) then {
	// Add admin menus
	if ("menus" in mission_plugins) then {
		[["Loadout Plugin","call loadout_fnc_menu",[{true},{false}],true],[player]] call menus_fnc_registerItem;
	};
	if ("zeus" in mission_plugins && "menus" in mission_plugins) then {
		call loadout_fnc_addZeusModules;
	};

	if (player getVariable ["unit_loadout_disabled",false]) exitWith {};

	// todo disable for persistance
	if (player call respawn_fnc_deadCheck) exitWith {};
	if (LOADOUT_SETTING_AUTO_PLAYER) then {
		[player] call loadout_fnc_unit;
	};
};