/* ----------------------------------------------------------------------------
Function: respawn_round_fnc_setParams

Description:
	Sets the parameters on the server as publicVariables
Parameters:
	none
Returns:
	nothing
Examples:
	call respawn_round_fnc_setParams;
	Runs in the postInit from functions.cpp
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

// quit if not the server
if !(isServer) exitWith {};

// get param value
private _time = ["p_respawn_round_time", 10] call BIS_fnc_getParamValue;
private _prepTime = ["p_respawn_round_prepTime", 1] call BIS_fnc_getParamValue;
private _count = ["p_respawn_round_count", 1] call BIS_fnc_getParamValue;
private _win = ["p_respawn_round_count_win", 1] call BIS_fnc_getParamValue;

if (_time isEqualTo 999) then {
	_time = 0.1;
};
if (_time isEqualTo 1000) then {
	_time = 0.5;
};
if (_time isEqualTo 1001) then {
	_time = 1.5;
};
if (_time isEqualTo 1002) then {
	_time = 2.5;
};

// use settings as default instead, define the values below for override
missionNamespace setVariable ["mission_respawn_round_time",_time,true];
missionNamespace setVariable ["mission_respawn_round_prepTime",_prepTime,true];
missionNamespace setVariable ["mission_respawn_round_count",_count,true];
missionNamespace setVariable ["mission_respawn_round_best",_win,true];