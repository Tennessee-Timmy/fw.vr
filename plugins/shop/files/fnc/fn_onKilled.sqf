/* ----------------------------------------------------------------------------
Function: shop_fnc_onKilled

Description:
	Runs on when a unit dies

Parameters:
	none
Returns:
	nothing
Examples:
	call shop_fnc_onKilled;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

//if !(isServer) exitWith {};

params ["_victim","_killer","_instigator"];

// only run if local to the victim
if (!local _victim) exitWith {};

// determine the killer
if (isNull _instigator) then {_instigator = driver _killer};
if (isNull _instigator) then {_instigator = gunner _killer};
if (isNull _instigator) then {_instigator = commander _killer};

// check the ace killer, use the killer determined before if the ace killer is unknown
private _theKiller = _victim getVariable ["ace_medical_lastDamageSource",objNull];
if (isNull _theKiller) then {_theKiller = _instigator;};

// get the sides
private _killerSide = _theKiller getVariable ["unit_shop_side",(side (group _theKiller))];
private _victimSide = _victim getVariable ["unit_shop_side",(side (_victim))];

// if the victim was a player, try to get his new unit
private _isPlayer = _victim getVariable ['unit_shop_isPlayer',false];
if (_isPlayer) then {
	_victim = missionNamespace getVariable [(vehicleVarName _victim),_victim];
};

// exit if it's not a dude
if !(_victim isKindOf "CAManBase") exitWith {};

if (isNil "_theKiller" || {!(isPlayer _theKiller)}) exitWith {};

// get killer uid
private _killerUID = _theKiller getVariable ['unit_shop_uid', getPlayerUID _theKiller];

// get forced friends
// if this is used, only these guys will be friends, everyone else enemy
private _forcedFriends = _theKiller getVariable ['unit_shop_forcedFriends',[]];

// civilian kill
if (_victimSide isEqualTo civilian) exitWith {
	[_killerUID,-1000] remoteExec ['shop_fnc_moneyUpdate',2];
};

// friendly kills
if ((((_killerSide getFriend _victimSide) >= 0.6) && (_forcedFriends isEqualTo [])) || {_victim in _forcedFriends}) exitWith {
	[_killerUID,-300] remoteExec ['shop_fnc_moneyUpdate',2];
};

// normal kill
[_killerUID,500] remoteExec ['shop_fnc_moneyUpdate',2];