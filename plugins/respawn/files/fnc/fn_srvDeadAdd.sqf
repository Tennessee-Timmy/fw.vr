/* ----------------------------------------------------------------------------
Function: respawn_fnc_srvDeadAdd

Description:
	Adds unit to list of dead units on the server
Parameters:
0:	_unit		- Unit which is dead, to be added to list
Returns:
	nothing
Examples:
	_unit remoteExec ["respawn_fnc_srvDeadAdd",2];
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

if !(isServer) exitWith {};
params ["_unit"];

// Exit if target unit does not exist or isNull or is not a man
if (isNil "_unit" || {isNull _unit} || {!(_unit isKindOf "CAManBase")}) exitWith {};


// Get the deadlist from seed
private _mission_deadlist = ["mission_respawn_deadList",[]] call seed_fnc_getVars;

// Craft the information packet
private _info = [
	(getPlayerUID _unit),
	(_unit call respawn_fnc_getSetUnitSide),
	(name _unit)
];

// push the packet into the deadlist
_mission_deadlist pushBackUnique _info;

// Save the new deadlist and send it accross the net
missionNamespace setVariable ["mission_respawn_deadList",_mission_deadlist,true];
["mission_respawn_deadList",_mission_deadlist] call seed_fnc_setVars;