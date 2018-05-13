/* ----------------------------------------------------------------------------
Function: headless_fnc_moveAll

Description:
	Changes the owner of the target to server or headless client
	Useful when moving units from zeus to server/hc

Parameters:
0:	_target			- Target player of which units will be moved to the server
Returns:
	nothing
Examples:
	// run for player that just was assigned as zeus
	player remoteExec ["headless_fnc_moveAll",2];

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// Server only
if !(isServer) exitWith {
	_this remoteExec ["headless_fnc_moveAll",2];
};

// Spawn, so it's in scheduled environment
_this spawn {

	params ["_player"];

	private _playerOwner = owner _player;

	private _nil = {

		// sleep a little so everyone does not get transferred automatically
		sleep (0.5 + random 0.5);
		private _target = _x;

		// Check if unit is owned by target
		if ((owner _target) isEqualTo _playerOwner) then {

			// Change unit group owner
			_target remoteExec ["headless_fnc_changeOwner",2];
		};
		false
	} count (allUnits + vehicles);
};