/* ----------------------------------------------------------------------------
Function: respawn_fnc_deadCheck

Description:
	Checks wether the target is on the server dead list or not

Parameters:
0:	_target		- target unit to check
Returns:
	_dead		- True if player is in the deadlist
Examples:
	_dead = player call respawn_fnc_deadCheck;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_target"];

// Get mission dead list from seed
private _deadArray =  missionNamespace getVariable ["mission_respawn_deadList",[]];

private _dead = false;
private _nil = {
	_x params ["_uid","_side","_name"];
	if ((getPlayerUID _target) isEqualTo _uid) exitWith {
		_dead = true;
	};
	false
} count _deadArray;
_dead