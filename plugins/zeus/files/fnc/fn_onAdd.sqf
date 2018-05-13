/* ----------------------------------------------------------------------------
Function: zeus_fnc_onAdd

Description:
	runs code for client that was added to zeus
	This adds moving zeus objects to server/hc

	Sets up zeus_setOwner_EH "CuratorObjectPlaced" EH

Parameters:
	none
Returns:
	nothing
Examples:
	// run for player that just was assigned as zeus
	remoteExec ["zeus_fnc_onAdd",_zeusPlayer];
	// run on local client
	call zeus_fnc_onAdd;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// check if headless plugin is loaded
if !("headless" in mission_plugins) exitWith {};

[] spawn {
	systemChat 'Loading zeus...';
	sleep 3;
	systemChat '...Please wait...';
	sleep 3;
	systemChat '...loading complete!';
};

waitUntil {!((getAssignedCuratorLogic player) isEqualTo objNull)};

// If eventhandler already exists, remove it!
if !(isNil "zeus_setOwner_EH") then {
	(getAssignedCuratorLogic player) removeEventHandler ["CuratorObjectPlaced",zeus_setOwner_EH];
};

// add eventhandler to player curator
zeus_setOwner_EH = (getAssignedCuratorLogic player) addEventHandler ["CuratorObjectPlaced",{

	// spawn to allow suspension
	_this spawn {

		// sleep, this keeps AI clothes one on ownership transfer
		sleep 5 + (random 5);

		private _target = param [1];

		// Changeowner
		_target remoteExec ["headless_fnc_changeOwner",2];
	};
}];

// ad on respawnUnit code
[[player],{[] spawn {sleep 15;player remoteExec ['zeus_fnc_srvAdd',2];};},"onRespawn",false] call respawn_fnc_scriptAdd;