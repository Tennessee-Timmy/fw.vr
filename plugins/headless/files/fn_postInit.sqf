/* ----------------------------------------------------------------------------
Function: headless_fnc_postInit

Description:
	postInit script for headless plugin
	sets mission_headless_setup (true - headless setup)/(false - server setup)

Parameters:
	none
Returns:
	nothing
Examples:
	Runs in postinit (from functions.cpp)

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Script begins

// add menus
if ("menus" in mission_plugins && hasInterface) then {
	[["Headless Plugin","call headless_fnc_menu",[{true},{false}],true],[player]] call menus_fnc_registerItem;
};

// disable acex stuff
private _arr = missionNamespace getVariable ['acex_headless_blackListtype',[]];
if (_arr isEqualTo []) then {
	missionNamespace setVariable ['acex_headless_blackListtype',_arr];
};
_arr pushBack 'All';
missionNamespace setVariable ['acex_headless_headlessClients',[]];
missionNamespace setVariable ['acex_headless_inRebalance',true];

// Get param value, use settings file as default
private _headlessEnabled = missionNamespace getVariable ["mission_headless_enabled",HEADLESS_PARAM_ENABLED];

mission_headless_controller = false;

// Add zeus modules
if ("zeus" in mission_plugins && "menus" in mission_plugins) then {
	call headless_fnc_addZeusModules;
};
// players exit, if they are not servers (editor/singleplayer/localhost)
if (hasInterface && {!isServer}) exitWith {};

// Run the setup on server
if (isServer) then {
	// if headless is disabled mission_headless_controller is true
	if (_headlessEnabled isEqualTo 0 || !isMultiplayer) exitWith {
		mission_headless_controller = true;
		(group mission_headless_obj) setGroupOwner 2;
		missionNamespace setVariable ["mission_headless_setup",false,true];
	};

	// if headless is enabled mission_headless_controller is false
	if (_headlessEnabled isEqualTo 1) exitWith {
		(group mission_headless_obj) setGroupOwner (owner headless_client);
		missionNamespace setVariable ["mission_headless_setup",true,true];
	};

	// set mission_headless_controller based on existance of headless_client
	if (isNil "headless_client") then {
		mission_headless_controller = true;
		(group mission_headless_obj) setGroupOwner 2;
		missionNamespace setVariable ["mission_headless_setup",false,true];
	} else {
		(group mission_headless_obj) setGroupOwner (owner headless_client);
		missionNamespace setVariable ["mission_headless_setup",true,true];
	};
};


//--- Check if headless failed to setup by server and set it up on the headless instead

// server will now stop
if (isServer) exitWith {};

private _setup = missionNamespace getVariable "mission_headless_setup";

// Headless client will now wait until headless is setup
waitUntil {
	_setup = missionNamespace getVariable "mission_headless_setup";
	!(isNil "_setup")
};

// Quit if headless was set to disabled
if (_headlessEnabled isEqualTo 0) exitWith {};

mission_headless_controller = true;
// If setup says taht headless is setup, quit
if (_setup) exitWith {};

// at this point headless client is not setup
missionNamespace setVariable ["mission_headless_setup",true,true];
[mission_headless_obj, {(group _this) setGroupOwner (owner headless_client)}] remoteExec ["call", 2];