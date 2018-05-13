/* ----------------------------------------------------------------------------
Function: safe_fnc_setTime

Description:
	Sets time for the safe

Parameters:
0:	_time			- float, amount of time to be added
1:	_zone			- bool, true for restriction zone. False for safe zone

Returns:
	nothing
Examples:
	// add time to restriction zone
	[100,true] call safe_fnc_setTime;

	// add time to safe zone
	[100,false] call safe_fnc_setTime;
Author:
	nigel
	help from commy2
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params [['_time',100],['_zone',false]];

private _varName = (['mission_safe_time','mission_safe_restrict_time'] select _zone);

missionNamespace setVariable [_varName,_time,true];