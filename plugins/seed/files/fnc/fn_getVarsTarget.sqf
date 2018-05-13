/* ----------------------------------------------------------------------------
Function: seed_fnc_getVarsTarget

Description:
	Returns the variables for the current seed from profileNamespace of the target
	Can be asked a certain variable and also have an expected value
	WARNING!
	This function must be in scheduled environment!
	WARNING!
Parameters:
0:	_target			- Target, profileNamespace of the owner of this unit will be checked
1:	_requested		- Variable to request
2:	_expected		- Expected value
Returns:
	Array of all the variables for the current seed
	or the requested variable value or expected value if it's not defined
Examples:
	Certain variable with a default value:
		_var = [blu001,"unit_respawn_timer_lives",3] call seed_fnc_getVarsTarget;
	All variables in current seed from target
		_vars = [_target] call seed_fnc_getVarsTarget;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins
params ["_target",["_requested",nil],["_expected",nil]];

// If target is not a number, check if it's local
if (_target isEqualType objNull) then {

	// If target is local, just exit and grab it
	if (local _target) exitWith {
		[_requested,_expected] call seed_fnc_getVars
	};
};

// Set ownername for request variable
private _ownerName = "server";

// If we are not a server, get player name instead
if (!isServer) then {
    _ownerName = name player;
};

// Create variable which will be used to send the information to us :)
private _requestVar = format ["seedVarsRequest_%1_%2",_ownerName,ceil random 10000];

// Delete the variable from everyone to make sure it's not used
missionNamespace setVariable [_requestVar,nil,true];

// remoteExec the getVarsSend on target
[[_requestVar],[_requested,_expected]] remoteExec ["seed_fnc_getVarsReturn",_target];

// Init variables for loop
private _result = nil;
private _startTime = time;

// Wait for response
waitUntil {
    _result = missionNamespace getVariable _requestVar;
    !isNil "_result" || ((time - _startTime) > SEED_SETTING_GETVARSTARGET_WAITTIME)
};

// Get the result
private _result = missionNamespace getVariable [_requestVar,_expected];

// Delete the variable from network
missionNamespace setVariable [_requestVar,nil,true];

// finish with the result
_result