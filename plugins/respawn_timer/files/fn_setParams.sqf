/* ----------------------------------------------------------------------------
Function: respawn_timer_fnc_setParams

Description:
	Sets the parameters on the server as publicVariables
Parameters:
	none
Returns:
	nothing
Examples:
	call respawn_timer_fnc_setParams;
	Runs in the postInit from functions.cpp
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

// quit if not the server
if !(isServer) exitWith {};

// get param value
_timerTime = ["p_respawn_timer_time", 10] call BIS_fnc_getParamValue;
_timerLives = ["p_respawn_timer_lives", 10] call BIS_fnc_getParamValue;

// use settings as default instead, define the values below for override
missionNamespace setVariable ["respawn_timer_time",_timerTime,true];
missionNamespace setVariable ["respawn_timer_lives",_timerLives,true];