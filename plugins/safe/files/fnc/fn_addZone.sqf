/* ----------------------------------------------------------------------------
Function: safe_fnc_addZone

Description:
	Adds a new zone to the safe

Parameters:
0:	_area			- array/obj/marker/bool, true for whole map sized zone, or object to add as zone
1:	_remove			- bool, true to remove the zone instead

Returns:
	nothing
Examples:
	// add whole map to restriction zone
	[true] call safe_fnc_addZone;

	// add area to safe zone
	[_area] call safe_fnc_addZone;
Author:
	nigel
	help from commy2
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params [['_area',true],['_remove',false]];


private _oldAreas = missionNamespace getVariable ['mission_safe_zones',[]];
if (_remove) then {
	_oldAreas = _oldAreas - [_area];
} else {
	_oldAreas pushBackUnique _area;
};
missionNamespace setVariable ['mission_safe_zones',_oldAreas,true];