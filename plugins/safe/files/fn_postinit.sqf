/* ----------------------------------------------------------------------------
Function: safe_fnc_postInit

Description:
	Runs the safe zone logics

Parameters:
	none
Returns:
	nothing
Examples:
	call safe_fnc_postInit;
	Runs in the postInit from functions.cpp

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// Player init
if (hasInterface) then {
	[] spawn {
		waitUntil {missionNamespace getVariable ['mission_safe_srvDone',false]};
		call safe_fnc_enable;

		// add menus
		if ("menus" in mission_plugins) then {
			[["Safe Plugin","call safe_fnc_menu",[{true},{false}],true],[player]] call menus_fnc_registerItem;
		};
	};
};

if (isServer) then {
	[[""],{call safe_fnc_onRespawn},"onRespawn",true] call respawn_fnc_scriptAdd;
	[[""],{call safe_fnc_onRespawnUnit},"onRespawnUnit",true] call respawn_fnc_scriptAdd;
	missionNamespace setVariable ['mission_safe_zones',SAFE_SETTING_ZONES,true];
	call safe_fnc_srvLoop;

	missionNamespace setVariable ['mission_safe_srvDone',true,true];
};