/* ----------------------------------------------------------------------------
Function: cleaner_fnc_groupInit

Description:
	Marks new ai groups for auto deletion

Parameters:
	none
Returns:
	nothing
Examples:
	call cleaner_fnc_groupInit
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

private _unit = param [0,objNull];
private _group = group _unit;

if (isPlayer _unit) exitWith {
	if (local _unit) then {
		_group setVariable ['ten_isPlayerGroup',true,true];
	};
};

// don't run for non local units on players (hc/server will still run, to allow for locality transfer to HC)
if (local _unit || !hasInterface) then {

	// add killed event handler, which will remove empty groups and set as deleted groups (again, just in case the group has changed)
	_unit addEventHandler ['killed',{_this call score_fnc_onKilled;}];
};

if (isGroupDeletedWhenEmpty _group) exitWith {};
_group deleteGroupWhenEmpty true;