/* ----------------------------------------------------------------------------
Function: headless_fnc_changeOwner

Description:
	Changes the owner of the target to server or headless client
	Useful when moving units from zeus to server/hc

Parameters:
0:	_target			- Target unit/object which ownership to change
Returns:
	nothing
Examples:
	// run for player that just was assigned as zeus
	_target remoteExec ["headless_fnc_changeOwner",2];

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_target"];

// Server only
if !(isServer) exitWith {};

// Change unit group owner
if (_target isKindOf "CAManBase") exitWith {
	if ((owner _target) isEqualTo (owner mission_headless_obj)) exitWith {};
	(group _target) setGroupOwner (owner mission_headless_obj);
};

if !(_target isKindOf "Module_F") then {

	if ((owner _target) isEqualTo (owner mission_headless_obj)) exitWith {};

	// Change object owner
	_target setOwner (owner mission_headless_obj);
};
