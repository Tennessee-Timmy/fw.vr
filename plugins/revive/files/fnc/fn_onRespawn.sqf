/* ----------------------------------------------------------------------------
Function: revive_fnc_onRespawn

Description:
	saves the unit that died for reviveing

Parameters:
0:	_unit		- unit that will respawn
1:	_oldUnit	- the unit that died

Returns:
	nothing
Examples:
	_unit call revive_fnc_onRespawn;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_unit",'_oldUnit'];

// run loop
call revive_fnc_deadLoop;

private _nextRevive = _unit getVariable ['unit_revive_nextRevive',(CBA_Missiontime)];

if (CBA_Missiontime < _nextRevive) exitWith {};

removeFromRemainsCollector [_oldUnit];

_unit setVariable ['unit_revive_oldUnit',_oldUnit,true];
_oldUnit setVariable ['unit_revive_canBeRevived',true,true];
_oldUnit setVariable ['unit_cleaner_disabled',true,true];
_oldUnit setVariable ['unit_revive_newUnit',_unit,true];
