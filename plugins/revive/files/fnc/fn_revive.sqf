/* ----------------------------------------------------------------------------
Function: revive_fnc_revive

Description:
	Attempt to revive a player

Parameters:
0:	_unit		- unit to revive
1:	_overRide	- allow reviving with enemies nearby

Returns:
	nothing
Examples:
	[_unit] call revive_fnc_revive;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params [["_unit",objNull],['_overRide',false,[false]]];

if (isNull _unit) exitWith {};

// make sure unit is still in-game
private _newUnit = _unit getVariable ['unit_revive_newUnit',objNull];
if (isNull _newUnit) exitWith {
	systemChat 'Cannot revive, target unavailable(respawned or disconnected)';
	_unit setVariable ['unit_revive_canBeRevived',false,true];
};

// check the last time the player was shot at
private _lastShotAt = missionNamespace getVariable ['mission_supp_lastShotAt',(time-30)];
private _sinceLastShotAt = time - _lastShotAt;
if (_sinceLastShotAt < 15) exitWith {
	systemChat 'You are under fire. You cannot revive under fire.';
};

private _nearUnits = _unit nearEntities ['CaManBase',100];

private _isEnemyNear = _nearUnits findIf {
	(!isNull _x) && {	// is not null
		(alive _x) && 	// is alive
		(((side (group _x)) getFriend (side (group player))) < 0.6) &&		//is not friendly to the player group
		!((weapons _x) isEqualTo [])	// has weapons
	};
};
if (_isEnemyNear != -1) exitWith {
	systemChat 'Cannot revive, enemy nearby';
};

// set variable so the player knows to respawn on their dead body and respawn him on the next frame (spawn)
_newUnit setVariable ['unit_revive_isRevived',true,true];
[_newUnit] spawn {
	_this call respawn_fnc_respawn;
};

'You have been revived, stay alive for 5 minutes to be revived again.' remoteExec ['systemChat',_newUnit];

// save the time that has to be passed for revive to be enabled again
_newUnit setVariable ['unit_revive_nextRevive',(CBA_Missiontime + 120),true];
