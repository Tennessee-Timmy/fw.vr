/* ----------------------------------------------------------------------------
Function: ai_ins_fnc_cache

Description:
	Caching check. Checks if players are in distance

Parameters:
0:  _pad	 		- pad to uncache
Returns:
	nothing
Examples:
	_pad call ai_ins_fnc_cache;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params [['_pad',objNull]];

if (isNull _pad) exitWith {};

// check if group is cached, quit if it is
private _cached = [_pad,"cached",false] call ai_ins_fnc_findParam;
if (_cached) exitWith {};

// get the group and pos
private _group = [_pad,"group",false] call ai_ins_fnc_findParam;
private _cachedPos = [_pad,"cachedPos",[]] call ai_ins_fnc_findParam;

// delete all units and count them
_amount = {

	// save the position of units for uncache pos
	private _xPos = getposATL _x;
	_cachedPos pushBack _xPos;

	deleteVehicle _x;
	true
} count units _group;

// save cached unit positions and the time we cached and set as cached
[_pad,"cachedPos",_cachedPos] call ai_ins_fnc_setParam;
[_pad,"cached",true] call ai_ins_fnc_setParam;
[_pad,"cachedTime",time] call ai_ins_fnc_setParam;

// save the amount (used to spawn/uncache)
[_pad,"savedAmount",_amount] call ai_ins_fnc_setParam;

// delete the group
deleteGroup _group;