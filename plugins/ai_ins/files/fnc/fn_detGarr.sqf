/* ----------------------------------------------------------------------------
Function: ai_ins_fnc_detGarr

Description:
	Determine if the group is garrison or normal

Parameters:
0:  _extra			- Parameter array
1:  _garr			- Garrison parameter
Returns:
	true if garrison, false if normal group
Examples:
	[_extra,_garrison] call ai_ins_fnc_detGarr;

Author:
	nigel
---------------------------------------------------------------------------- */
//#include "script_component.cpp"
// Code begins

params [['_pad',objNull],['_garr',nil]];

// quit if pad is not existant
if (isNull _pad) exitWith {};


if (isNil '_garr') then {
	_garr = [_pad,"garrisonUnit",false] call ai_ins_fnc_findParam;
};

if (_garr isEqualType false && {!_garr}) exitWith {false};
true