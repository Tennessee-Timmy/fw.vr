/* ----------------------------------------------------------------------------
Function: settings_fnc_loadSettings

Description:
	Loads an array of settings into missionNamespace

Parameters:
0:	_settings			- Array of settings to load
	0:	_varName		- Variable name which to set (string)
	1:	_value			- Variable value
	2:	_global			- True to set this one as global (DEFAULTS TO FALSE)
	3:	_old			- True to allow old value (if exists)
Returns:
	nothing
Examples:
	// Default value: true / ovewrite by itsCool if itsCool is defined
	_settings call settings_fnc_loadSettings;
	// Force value from settings.cpp
	[["mission_respawn_base_location_west",VAR,true],["mission_respawn_base_location_east",VAR2,true]] call settings_fnc_loadSettings;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

[_this] params [["_settings",[]]];

// Exit if no settings
if (_settings isEqualTo []) exitWith {};

// Loop through all settings
private _nul = {
	_x params ["_varName","_value",["_global",false],["_old",false]];

	// Check for old value if allowed
	if (_old) then {
		_value = missionNamespace getVariable [_varName,_value];
	};

	// Set the variable base on data
	missionNamespace setVariable [_varName,_value,_global];
	false
} count _settings