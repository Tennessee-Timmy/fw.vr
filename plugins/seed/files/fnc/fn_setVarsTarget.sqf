/* ----------------------------------------------------------------------------
Function: seed_fnc_setVarsTarget

Description:
	Sets the variable for the current seed from profileNamespace
	for remote clients

Parameters:
0:	_target			- Target on which to set the variable on
1:	_variable		- Variable name to set
2:	_value			- Value of the variable (can be nil to delete)
Returns:
	nothing
Examples:
	[_target,"unit_respawn_timer_lives",10] call seed_fnc_setVarsTarget;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins
params ["_target","_variable","_value"];

// If target is not a number
if (_target isEqualType objNull) then {

	// If target is local, just exit and send it normally
	if (local _target) exitWith {
		[_variable,_value] call seed_fnc_setVars;
	};
};

// Remotexec setVars function on target client
[_variable,_value] remoteExec ["seed_fnc_setVars",_target];