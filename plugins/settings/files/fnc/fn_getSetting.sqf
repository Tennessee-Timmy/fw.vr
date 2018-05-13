/* ----------------------------------------------------------------------------
Function: settings_fnc_getSetting

Description:
	Grabs variable from mission (if exists) or uses settings value as default

Parameters:
	none
Returns:
	nothing
Examples:
	["variable",SETTING] call settings_fnc_getSetting;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_varName","_default"];

// Get variable
missionNamespace getVariable [_varName,_default];