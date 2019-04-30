/* ----------------------------------------------------------------------------
Function: zeus_fnc_postInit

Description:
	postInit script for zeus plugin

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
if ("menus" in mission_plugins) then {
		[["Zeus Plugin","call zeus_fnc_menu",[{true},{false}],true],[player]] call menus_fnc_registerItem;
};
// add zeus modules
call zeus_fnc_addZeusModules;
if (hasInterface && (ZEUS_SETTINGS_ADMINZEUS isEqualTo 2) && (call menus_fnc_isAdmin)) then {
	[] spawn {
		sleep 5;
		player remoteExec ['zeus_fnc_srvAdd',2];
	};
};
if !(isServer) exitWith {};

// create 10 zeus slots
[] spawn {
	uiSleep 1;
	private _zeusList = missionNamespace getVariable "mission_zeus_list";
	if (isNil '_zeusList') then {
		_zeusList = [];
		missionNamespace setVariable ["mission_zeus_list",_zeusList];
	};

	if (isNil "mission_zeus_group" || {isNull mission_zeus_group}) then {
		mission_zeus_group = createGroup sideLogic;
	};

	uiSleep 1;

	for '_i' from 0 to 3 do {
		uisleep 1;

		"ModuleCurator_F" createUnit [[0,0,0], (mission_zeus_group), "this setvariable ['BIS_fnc_initModules_disableAutoActivation', false, true];"];
		waitUntil {((count units mission_zeus_group) > _i)};
		//if !((count units mission_zeus_group) > _i) then {uisleep 1;};
		//_zeus = mission_zeus_group createUnit ["ModuleCurator_F", [0,0,0], [], 0, "NONE"];
		private _zeus = (units mission_zeus_group) # _i;

		_zeus setVehicleVarName ('zeus_' + (str _i));
		missionNamespace setVariable [('zeus_' + str _i),_zeus,true];
		//_zeus setVariable ["owner",_uid];
		//_zeus setVariable ["zeus_uid",_uid];
		_zeus setVariable ['forced',1,true];
		_zeus setVariable ["playerZeus", true,true];
		_zeus setVariable ["birdType", "",true];
		_zeus setVariable ["showNotification", false,true];
		_zeus setCuratorWaypointCost 0;
		_zeus allowCuratorLogicIgnoreAreas true;
		{_zeus setCuratorCoef [_x, 0];} forEach ["place", "edit", "delete", "destroy", "group", "synchronize"];
		_zeusList pushBack _zeus;

	};
};