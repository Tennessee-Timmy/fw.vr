/* ----------------------------------------------------------------------------
Function: headless_fnc_moveAllMission

Description:
	Changes the owner of all units to the headless owner


Parameters:
0:	_moveObjects			- bool, true to include all objects

Returns:
	nothing
Examples:
	true remoteExec ["headless_fnc_moveAllMission",2];

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// Server only
if !(isServer) exitWith {
	_this remoteExec ["headless_fnc_moveAllMission",2];
};

// Spawn, so it's in scheduled environment
_this spawn {

	params [["_moveObjects",true,[true]]];

	private _objects = [];

	if (_moveObjects) then {
		_objects = entities 'All';
	};

	private _nil = {

		// sleep a little so everyone does not get transferred automatically
		sleep (0.05 + random 0.1);

		// Change unit group owner
		_x remoteExec ["headless_fnc_changeOwner",2];
		false
	} count (allUnits + vehicles + _objects);
};