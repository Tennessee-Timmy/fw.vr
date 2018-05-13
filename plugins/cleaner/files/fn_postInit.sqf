/* ----------------------------------------------------------------------------
Function: cleaner_fnc_postInit

Description:
	creates a loop on the server, which will clean dead bodies and crap

Parameters:
	none
Returns:
	nothing
Examples:
	call cleaner_fnc_postInit
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

// fix for groups not being removed
["CAManBase", "initPost", {_this call cleaner_fnc_groupInit},true,[],true] call CBA_fnc_addClassEventHandler;

if !(isServer) exitWith { };
0 spawn {
	mission_cleaner_enabled = missionNamespace getVariable ["mission_cleaner_enabled",CLEANER_SETTINGS_ENABLED];
	while {mission_cleaner_enabled} do {
		sleep 3;
		call cleaner_fnc_cleanUp;
		call cleaner_fnc_cleanBads;
	};
};