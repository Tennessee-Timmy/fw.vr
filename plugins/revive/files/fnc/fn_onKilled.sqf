/* ----------------------------------------------------------------------------
Function: revive_fnc_onKilled

Description:
	Throws players out of vehicles (so revive can operate properly)

Parameters:
0:	_oldUnit		- the unit that died
1:	_killer			- Suspected killer

Returns:
	nothing
Examples:
	_unit call revive_fnc_onKilled;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_oldUnit",'_killer'];

// exit if player on foot
if (isNull objectParent _oldUnit) exitWith {};

// move body out of vehicle
_oldUnit setPosASL (getPosASL _oldUnit);