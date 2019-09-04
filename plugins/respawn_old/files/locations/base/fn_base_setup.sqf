/* ----------------------------------------------------------------------------
Function: respawn_fnc_base_setup

Description:
	Sets up the base respawn location
	Run this on server only

Parameters:
	none
Returns:
	nothing
Examples:
	call respawn_fnc_base_setup;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

if !(isServer) exitWith {};
// Code begins

private _west = missionNamespace getVariable ["mission_respawn_base_location_west",RESPAWN_SETTING_BASE_WEST];
private _east = missionNamespace getVariable ["mission_respawn_base_location_east",RESPAWN_SETTING_BASE_EAST];
private _guer = missionNamespace getVariable ["mission_respawn_base_location_resistance",RESPAWN_SETTING_BASE_IND];
private _civ = missionNamespace getVariable ["mission_respawn_base_location_civilian",RESPAWN_SETTING_BASE_CIV];

missionNamespace setVariable ["mission_respawn_base_location_west",_west,true];
missionNamespace setVariable ["mission_respawn_base_location_east",_east,true];
missionNamespace setVariable ["mission_respawn_base_location_resistance",_guer,true];
missionNamespace setVariable ["mission_respawn_base_location_civilian",_civ,true];

// Set respawn location script
missionNamespace setVariable ["mission_respawn_location",{call respawn_fnc_base_respawn},true];