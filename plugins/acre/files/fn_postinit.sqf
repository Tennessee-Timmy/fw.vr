/* ----------------------------------------------------------------------------
Function: acre_fnc_postInit

Description:
	ACRE init

Parameters:
	none
Returns:
	nothing
Examples:
	call acre_fnc_postInit;
	Runs in the postInit from functions.cpp

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins


if (isServer) then {
	[[""],{call acre_fnc_onRespawn},"onRespawn",true] call respawn_fnc_scriptAdd;
	[[""],{[] spawn {sleep 1; call acre_fnc_onRespawnUnit};},"onRespawnUnit",true] call respawn_fnc_scriptAdd;


	// server ready
	missionNamespace setVariable ['mission_acre_srvReady',true,true];

};

//


// set up radios for loadout plugins
missionNamespace setVariable ["mission_acre_radio_personal_west",ACRE_SETTING_RADIO_PERSONAL_WEST];
missionNamespace setVariable ["mission_acre_radio_personal_east",ACRE_SETTING_RADIO_PERSONAL_EAST];
missionNamespace setVariable ["mission_acre_radio_personal_guer",ACRE_SETTING_RADIO_PERSONAL_GUER];

missionNamespace setVariable ["mission_acre_radio_sl_west",ACRE_SETTING_RADIO_SL_WEST];
missionNamespace setVariable ["mission_acre_radio_sl_east",ACRE_SETTING_RADIO_SL_EAST];
missionNamespace setVariable ["mission_acre_radio_sl_guer",ACRE_SETTING_RADIO_SL_GUER];

missionNamespace setVariable ["mission_acre_radio_lr_west",ACRE_SETTING_RADIO_LR_WEST];
missionNamespace setVariable ["mission_acre_radio_lr_east",ACRE_SETTING_RADIO_LR_EAST];
missionNamespace setVariable ["mission_acre_radio_lr_guer",ACRE_SETTING_RADIO_LR_GUER];

[] spawn {
	// wait for server
	waitUntil {(missionNamespace getVariable ['mission_acre_srvReady',false]) || isServer};

	// check if acre enabled
	if !(missionNamespace getVariable ['mission_acre_enabled',false]) exitWith {
		[true, true] spawn acre_api_fnc_setupMission;
	};

	if !(isMultiplayer) exitWith {};

	if (missionNamespace getVariable ['mission_acre_setupEnabled',false]) then {
		call acre_fnc_setupRadios;
	};

	["acre_sys_core_ts3ChannelSwitch", ACRE_SETTING_MOVE, true, "server", false] call CBA_settings_fnc_set;
	if (ACRE_SETTING_MOVE) then {
		["acre_sys_core_ts3ChannelName", ACRE_SETTING_CHANNEL, true, "server", false] call CBA_settings_fnc_set;
		["acre_sys_core_ts3ChannelPassword", ACRE_SETTING_TSPW, true, "server", false] call CBA_settings_fnc_set;
	};
	["acre_sys_core_interference", ACRE_SETTING_INTERFERENCE, true, "server", false] call CBA_settings_fnc_set;
	["acre_sys_core_fullDuplex", ACRE_SETTING_DUPLEX, true, "server", false] call CBA_settings_fnc_set;
	["acre_sys_core_ignoreAntennaDirection", ACRE_SETTING_IGNOREANTENNA, true, "server", false] call CBA_settings_fnc_set;
	["acre_sys_core_terrainLoss", ACRE_SETTING_TERRAINLOSS, true, "server", false] call CBA_settings_fnc_set;
	["acre_sys_core_revealToAI", ACRE_SETTING_AI, true, "server", false] call CBA_settings_fnc_set;


	if !(hasInterface) exitWith {};
	waitUntil {!isNull acre_player};
	waitUntil {([] call acre_api_fnc_isInitialized)};

	if (missionNamespace getVariable ['mission_acre_setupEnabled',false]) then {
		//call acre_fnc_setupRadios;
	};

	if (missionNamespace getVariable ['mission_acre_addEnabled',false]) then {
		sleep 3;
		call acre_fnc_addRadios;
	};
	// Add admin menus
	if ("menus" in mission_plugins) then {
		[["ACRE Plugin","call acre_fnc_menu",[{true},{false}],true],[player]] call menus_fnc_registerItem;
	};
	if ("zeus" in mission_plugins && "menus" in mission_plugins) then {
		call acre_fnc_addZeusModules;
	};
};
