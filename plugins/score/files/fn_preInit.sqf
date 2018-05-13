/* ----------------------------------------------------------------------------
Function: score_fnc_preInit

Description:
	preInit script for score plugin

Parameters:
	none
Returns:
	nothing
Examples:
	Runs in preinit (from functions.cpp)

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Script begins

["CAManBase", "initPost", {_this call score_fnc_unitInit},true,[],true] call CBA_fnc_addClassEventHandler;


if !(isServer) exitWith {};

//addMissionEventHandler ["EntityKilled",{_this call score_fnc_onKilled}];

private _srvEndCodes = missionNamespace getVariable ["mission_tasks_srvEndCodes",[]];
_srvEndCodes pushBack {call score_fnc_srvEnd};
missionNamespace setVariable ["mission_tasks_srvEndCodes",_srvEndCodes,true];