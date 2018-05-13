/* ----------------------------------------------------------------------------
Function: seed_fnc_getVarsReturn

Description:
	Returns the variables for the current seed from profileNamespace as
	variable which is requested

Parameters:
0:	_targetInfo			- Info used for networking
	0:	_requestVar		- Variable which will be used to send data over network
1:	_varInfo			- Info used for retriving variable
	0:	_requestVar		- Variable used to send back
	1:	_expected		- Expected value
Returns:
	Array of all the variables for the current seed
	or the requested variable value or expected value if it's not defined
Examples:
	Variable requested from remote machine
	[[_requestVar],[_requested,_expected]] remoteExec ["seed_fnc_getVarsReturn",_target];

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins
params [["_targetInfo",[nil]],["_varInfo",[nil,nil]]];
_targetInfo params [["_requestVar",nil]];
_varInfo params [["_requested",nil],["_expected",nil]];

private _return = nil;

// Check if a specific variable was requested
if (isNil {_requested}) then {
	// if nothing specific requested, return all variables
	_return = call seed_fnc_getVars;
} else {
	// if specific variable is requested, return it
	_return = [_requested,_expected] call seed_fnc_getVars;
};

// Send the variable over network
missionNamespace setVariable [_requestVar,_return,true];