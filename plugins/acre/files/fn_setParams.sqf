/* ----------------------------------------------------------------------------
Function: acre_fnc_setParams

Description:
	Set acre params / runs on server
	It runs in postInit automatically

Parameters:
	none
Returns:
	nothing
Examples:
	call acre_fnc_setParams;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Script begins

// exit non servers
if (!isServer) exitWith {};

private _enabled = ["p_acre_enabled", ACRE_PARAM_ENABLED] call BIS_fnc_getParamValue;
private _add = ["p_acre_add", ACRE_PARAM_GIVERADIOS] call BIS_fnc_getParamValue;
private _setup = ["p_acre_setup", ACRE_PARAM_SETUPRADIOS] call BIS_fnc_getParamValue;

private _enabledBool = [false,true] select _enabled;
missionNamespace setVariable ["mission_acre_enabled",_enabledBool,true];


// add
private _addEnabled = true;
if (_add > 0) then {
	_addEnabled = false;
};
if (_add > 1) then {
	missionNamespace setVariable ['mission_acre_addBlock',true,true];
};
missionNamespace setVariable ['mission_acre_addEnabled',_addEnabled,true];


// setup
private _setupEnabled = true;
if (_setup > 0) then {
	_setupEnabled = false;
};
if (_setup > 1) then {
	missionNamespace setVariable ['mission_acre_setupBlock',true,true];
};
missionNamespace setVariable ['mission_acre_setupEnabled',_setupEnabled,true];