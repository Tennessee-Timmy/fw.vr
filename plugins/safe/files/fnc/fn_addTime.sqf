/* ----------------------------------------------------------------------------
Function: safe_fnc_addTime

Description:
	Adds time for the safe

Parameters:
0:	_time			- float, amount of time to be added
1:	_zone			- bool, true for restriction zone. False for safe zone

Returns:
	nothing
Examples:
	// add time to restriction zone
	[100,true] call safe_fnc_addTime;

	// add time to safe zone
	[100,false] call safe_fnc_addTime;
Author:
	nigel
	help from commy2
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params [['_time',100],['_zone',false]];

private _varName = (['mission_safe_time','mission_safe_restrict_time'] select _zone);

private _oldTime = missionNamespace getVariable [_varName,0];
missionNamespace setVariable [_varName,(_oldTime + _time),true];