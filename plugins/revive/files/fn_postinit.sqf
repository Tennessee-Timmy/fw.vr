/* ----------------------------------------------------------------------------
Function: revive_fnc_postInit

Description:
	Adds eventhandelers to players
	Sets up the respawn types and respawn scripts

Parameters:
	none
Returns:
	nothing
Examples:
	call revive_fnc_postInit;
	Runs in the postInit from functions.cpp

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// add ace bodybag eventhandler
["ace_placedInBodyBag", {_this call revive_fnc_onBodyBag;}] call CBA_fnc_addEventHandler;


[] spawn {

	// wait for respawn plugin! ; this ensures that the server has set up the location script and it can be overwritten
	waitUntil {!(isNil "mission_respawn_serverReady")};


	// Server init
	if (isServer) then {
		call revive_fnc_setup;
	};
};

if (isServer) then {
	[[""],{_this call revive_fnc_onRespawn},"onRespawn",true] call respawn_fnc_scriptAdd;
	[[""],{_this call revive_fnc_onRespawnUnit},"onRespawnUnit",true] call respawn_fnc_scriptAdd;

	addMissionEventHandler ['EntityKilled',{
		params [['_killed',objNull]];
		if (isNull _killed) exitWith {};
		if (_killed isKindOf 'Man') exitWith {};
		{
			[_x,(getPosASL _x)] remoteExec ['setPosASL',_x];
			false
		} count (crew _killed);
	}];
};

if (hasInterface) then {

	call revive_fnc_markerLoop;

	// add actions for ace
	call revive_fnc_addAceActions;


	// add menu for respawning when player is dead and allowed to respawn
	if ("menus" in mission_plugins) then {
		[["Revive Plugin","call revive_fnc_menu",[{(player getVariable ['unit_revive_canRespawn',false])},{false}],false],[player]] call menus_fnc_registerItem;
	};
};




//
//
// settings:
// - distance
// - condition
// - respawn location
// -
//
//
// make it side only
//--- make body bag marker work
//--- make people eject if they die in a vehicle(and it explodes
//--- enemy detection bug / types