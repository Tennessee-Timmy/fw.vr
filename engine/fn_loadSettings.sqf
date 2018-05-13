/* ----------------------------------------------------------------------------
Function: mission_fnc_loadSettings

Description:
	loads the settings (variable) from array

Parameters:
0:	_array	- Array of settings to load
Returns:
	nothing
Examples:
	[[["mission_respawn_base_west",blu_1]]] call mission_fnc_loadSettings;
	// Sets mission_respawn_base_west as blu_1

Author:
	nigel
---------------------------------------------------------------------------- */
// Code begins
params ["_array"];
// Quit if no array
if (isNil "_array") exitWith {};
// Quit if array is empty
if (count _array isEqualTo 0) exitWith {};
// loop through the array
_nul = {
	_x params ["_varName","_value"];
	// if variable is not defined, define it
	_var = missionNamespace getVariable [_varName,nil];
	if (isNil "_var") then {
		missionNamespace setVariable [_varName,_value];
	};
} count _array;