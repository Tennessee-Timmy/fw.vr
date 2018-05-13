/* ----------------------------------------------------------------------------
Function: seed_fnc_getVars

Description:
	Returns the variables for the current seed from profileNamespace
	Can be asked a certain variable and also have an expected value

Parameters:
0:	_requested		- Variable to request
1:	_expected		- Expected value
Returns:
	Array of all the variables for the current seed
	or the requested variable value or expected value if it's not defined
Examples:
	Certain variable with a default value:
		_var = ["unit_respawn_timer_lives",3] call seed_fnc_getVars;
	All variables in current seed
		_vars = call seed_fnc_getVars;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins
params [["_requested",nil],["_expected",nil]];

// Get seed key for the current mission
_seedVarName = format ["seed_vars_%1",mission_seed_key];

// Get seed variables from profilenamespace
_seedVar = profileNamespace getVariable [_seedVarName,[]];

// Set result as private
private _result = nil;

if (isNil "_requested") then {

	// If a certain variable was not requested
	// Make an empty array and add the seed variables to it
	_result = [];
	_result = _result + _seedVar;
} else {

	// If a certain variable was requested
	// Check for the requested variable
	private _found = _seedVar select {(_x select 0) isEqualTo _requested};

	// Get requested variable
	_found = (_found param [0,[]]);

	// unstring
	// todo test
	_result = call compile (_found param [1,str _expected]);
	/*
	// unstring
	_result = format ["%1",(_found param [1,str _expected])];
	// unstring
	_result = format ["%1",(_found param [1,""])]
	_result = [_result] param [0,_expected];
	*/

};

// Return the result
_result