/* ----------------------------------------------------------------------------
Function: cleaner_fnc_onKilled

Description:
	This runs on killed EH from groupInit
	Sets group to be delted and deletes if it's empty

Parameters:
	none
Returns:
	nothing
Examples:
	call cleaner_fnc_onKilled
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

private _victim = param [0,objNull];

if (isNull _victim) exitWith {};
if (!local _unit) exitWith {};

private _group = (group _victim);

// check if this is a player group (player groups are not deleted)
private _isPlayerGroup = _group getVariable ['ten_isPlayerGroup',false];
if (_isPlayerGroup) exitWith {};

// exit with group deletion if it's empty
if ((units _group) isEqualTo [] && local _group) exitWith {
	deleteGroup _group;
};

// set group as deletable if it's not already deletable
if (isGroupDeletedWhenEmpty _group) exitWith {};
_group deleteGroupWhenEmpty true;