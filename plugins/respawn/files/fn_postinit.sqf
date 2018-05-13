/* ----------------------------------------------------------------------------
Function: respawn_fnc_postInit

Description:
	Adds eventhandelers to players
	Sets up the respawn types and respawn scripts

Parameters:
	none
Returns:
	nothing
Examples:
	call respawn_fnc_postInit;
	Runs in the postInit from functions.cpp

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// Server init
if (isServer) then {

	private _deadHUDEnabled = missionNamespace getVariable ["mission_respawn_deadHudEnabled",RESPAWN_SETTING_DEADHUD];

	// Enable respawn HUD on this mission
	if (_deadHUDEnabled) then {

		// This will add deadhud for everyone
		[true] call respawn_fnc_deadHudScriptAdd;
	};

	// Set the respawn location
	if (respawn_location isEqualTo 0) then {call respawn_fnc_default_setup;};
	if (respawn_location isEqualTo 1) then {call respawn_fnc_base_setup;};
	if (respawn_location isEqualTo 2) then {call respawn_fnc_base_setup;};
	if (respawn_location isEqualTo 3) then {};
	if (respawn_location isEqualTo 4) then {};

	// add group fix code
	[[""],{_group = [player] call respawn_fnc_findGroup},"onRespawnUnit",true] call respawn_fnc_scriptAdd;

	missionNamespace setVariable ["mission_respawn_serverReady",true,true];

	// Load list of dead players from seed
	private _mission_deadlist = ["mission_respawn_deadList",[]] call seed_fnc_getVars;
	missionNamespace setVariable ["mission_respawn_deadList",_mission_deadlist,true];


};

// Player init
if (hasInterface) then {
	[] spawn {

		// get correct group for unit
		private _group = [player] call respawn_fnc_findGroup;

		// Add admin menus
		if ("menus" in mission_plugins && {call menus_fnc_isAdmin}) then {
			[["Respawn Plugin","call respawn_fnc_menu",[{true},{false}],true],[player]] call menus_fnc_registerItem;
		};

		// Add zeus modules
		if ("zeus" in mission_plugins && "menus" in mission_plugins) then {
			call respawn_fnc_addZeusModules;
		};

		// Wait for the server
		waitUntil {!(isNil "mission_respawn_serverReady")};

		// hide the unit, so it does not appear before he is loaded
		[player,true] remoteExec ["hideObjectGlobal",2];
		player allowDamage false;

		// Set player side variable (if not set)
		player call respawn_fnc_getSetUnitSide;

		// Setup respawn and killed scripts
		player addEventHandler ["Respawn", {_this call respawn_fnc_onRespawn;}];
		player addEventHandler ["Killed", {_this call respawn_fnc_onKilled;}];

		//Jip check
		private _jip = missionNamespace getVariable ["mission_respawn_jip",RESPAWN_SETTING_JIP];

		// unhide the unit, so he can exist
		[player,false] remoteExec ["hideObjectGlobal",2];
		player allowDamage true;
		// Set the player as dead if he is already dead or jip is not allowed
		if (player call respawn_fnc_deadCheck || (!_jip && didJip)) then {
			[player,player] call respawn_fnc_onRespawn;
		};

		// run jip code
		if (didJip) then {
			player call (missionNamespace getVariable ['mission_respawn_jipCode',RESPAWN_SETTING_JIPCODE]);
		};
	};
};