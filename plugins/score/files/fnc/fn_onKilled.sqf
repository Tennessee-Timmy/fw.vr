/* ----------------------------------------------------------------------------
Function: score_fnc_onKilled

Description:
	Runs on end, only on server

Parameters:
	none
Returns:
	nothing
Examples:
	call score_fnc_onKilled;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

//if !(isServer) exitWith {};

params ["_victim","_killer","_instigator"];

if (!local _victim) exitWith {};

if (isNull _instigator) then {_instigator = driver _killer};
if (isNull _instigator) then {_instigator = gunner _killer};
if (isNull _instigator) then {_instigator = commander _killer};


private _theKiller = _victim getVariable ["ace_medical_lastDamageSource",objNull];
if (isNull _theKiller) then {_theKiller = _instigator;};

private _killerSide = _theKiller getVariable ["unit_score_side",(side (group _theKiller))];
private _victimSide = _victim getVariable ["unit_score_side",(side (_victim))];

private _isPlayer = _victim getVariable ['unit_score_player',false];
if (_isPlayer) then {
	_victim = missionNamespace getVariable [(vehicleVarName _victim),_victim];
};

// exit if it's not a dude
if !(_victim isKindOf "CAManBase") exitWith {};
// if victim was a player, add death
if (_isPlayer) then {
	[_victim,[0,0,0,1]] remoteExec ['score_fnc_update',2];
};
if (isNil "_theKiller" || {!(isPlayer _theKiller)}) exitWith {};

// get forced friends
// if this is used, only these guys will be friends, everyone else enemy
private _forcedFriends = _theKiller getVariable ['unit_score_forcedFriends',[]];

// civilian kill
if (_victimSide isEqualTo civilian) exitWith {
	[_theKiller,[0,0,1,0]] remoteExec ['score_fnc_update',2];
};

// friendly kills
if ((((_killerSide getFriend _victimSide) >= 0.6) && (_forcedFriends isEqualTo [])) || {_victim in _forcedFriends}) exitWith {
	[_theKiller,[0,1,0,0]] remoteExec ['score_fnc_update',2];
};

// normal kill
[_theKiller,[1, 0, 0, 0, 0]]remoteExec ['addPlayerScores',2];
[_theKiller,[1,0,0,0]] remoteExec ['score_fnc_update',2];