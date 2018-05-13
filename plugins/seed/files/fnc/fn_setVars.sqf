/* ----------------------------------------------------------------------------
Function: seed_fnc_setVars

Description:
	Sets the variable for the current seed from profileNamespace

Parameters:
0:	_variable		- Variable name to set
1:	_value			- Value of the variable (can be nil to delete)
Returns:
	nothing
Examples:
	["unit_respawn_timer_lives",10] call seed_fnc_setVars;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins
params ["_variable","_value"];

// Get seed key for the current mission
_seedVarName = format ["seed_vars_%1",mission_seed_key];

// Get seed variables from profilenamespace
private _seedVar = profileNamespace getVariable [_seedVarName,[]];

// Remove the variable if it exists
// If the first element is not the same as variable add it back to the array
_seedVar = _seedVar select {!((_x select 0) isEqualTo _variable)};

// Add the new/updated variable to the array if it's not nil
// This means that it will be removed if value is nil
if !(isNil "_value") then {

	// stringify tha value so it does not break profilenamespace
	// todo test
	_value = str _value;
	_seedVar pushBack [_variable,_value];
};

// Set the variable in profilenamespace and save it
profileNamespace setVariable [_seedVarName,_seedVar];
//saveProfileNamespace;