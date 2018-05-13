/* ----------------------------------------------------------------------------
Function: jip_fnc_postInit

Description:
	jip postinit

Parameters:
	none
Returns:
	nothing
Examples:
	call jip_fnc_postInit;
	Runs in the postInit from functions.cpp

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

if !(hasInterface) exitWith {};


// Add jip menus
if ("menus" in mission_plugins) then {
	[] spawn {
		waitUntil {time > 1};
		if (player call respawn_fnc_deadCheck) exitWith {};
		if (didJIP) then {
			player setVariable ["unit_jip_remove",(JIP_SETTINGS_TELEPORT_TIME)];
			["CuratorAddAddons",["JIP teleport added. Press CTRL+J to open the menu"]] call BIS_fnc_showNotification;
			systemChat "JIP teleport added. Press CTRL+J to open the menu";
			[["JIP Teleport","call jip_fnc_menu",[{!isNil {player getVariable "unit_jip_remove"}},{(!isNil {player getVariable "unit_jip_used"})}],false],[player]] call menus_fnc_registerItem;
			[] spawn {
				sleep (player getVariable ["unit_jip_remove",10]);
				player setVariable ["unit_jip_used",true];
			};
			player setVariable ["unit_jip_remove",(JIP_SETTINGS_TELEPORT_TIME)];

		};
	};
};