/* ----------------------------------------------------------------------------
Function: ai_ins_fnc_patrol

Description:
	caching logic for array

Parameters:
0:  _pos			- Position
1:  _side			- Side
2:  _amount			- Amount
3:  _extra			- Array with parameters
Returns:
	nothing
Examples:
	call ai_ins_fnc_patrol;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ['_pos',['_side',east],['_amount',1],['_extra',[]]];

// Keep this array to send it onward
private _arr = [_pos,_side,_amount,_extra];

// find the params needed in this script
private _group = [_extra,"group",false] call ai_ins_fnc_findParam;
private _patrolDist = [_extra,'pDist', 100] call ai_ins_fnc_findParam;
private _pWP = [_extra,'pWP', false] call ai_ins_fnc_findParam;
private _house = [_extra,"house",false] call ai_ins_fnc_findParam;
private _houseSize = [_extra,"houseSize",2] call ai_ins_fnc_findParam;
private _houseChecks = [_extra,"houseChecks",2] call ai_ins_fnc_findParam;
private _onlyHouse = [_extra,"onlyHouse",false] call ai_ins_fnc_findParam;
private _trans = [_extra,"trans",false] call ai_ins_fnc_findParam;
private _garrison = [_extra,"garrison",false] call ai_ins_fnc_findParam;
private _road = [_extra,"road",false] call ai_ins_fnc_findParam;

// exit if group empty
if (isNil "_group" || {!(_group isEqualType false) && {(isNull _group) || {units _group isEqualTo []}}}) exitWith {};

// garrisson
if (_garrison) exitWith {

	// stop group from following waypoints
	[_arr,_group,_patrolDist,_houseSize,true,_houseChecks] call ai_ins_fnc_garrison;
};

private _oldWP = waypointPosition [_group, currentWaypoint _group];
if (!(_pWP isEqualType false) && {(!((leader _group) inArea [(_oldWP),15,15,0,false]) && !(_oldWP isEqualTo [0,0,0]))}) exitWith {
	// will do nothing until reached wp
};

// new waypoint

// delete all waypoints
while {(count(waypoints _group)) > 0} do {
	deleteWaypoint((waypoints _group)select 0);
};

private _minDist = _patrolDist / 5;
private _wpPos = [0,0,0];
private _patrolWPs = missionNamespace getVariable ['ai_ins_patrolWPs',[]];
waitUntil {
	_wpPos = [_pos,_extra,false] call ai_ins_fnc_flatPos;
	private _close = _patrolWPs inAreaArray [_wpPos,_minDist,_minDist,0,false];
	if (!(_wpPos isEqualTo [0,0,0]) && (_close isEqualTo [])) then {
		true
	} else {
		_minDist = _minDist / 2;
		_dist = _patrolDist + (_patrolDist / 10);
		[_extra,'pDist',_dist] call ai_ins_fnc_setParam;
		false
	};
};
_patrolWPs pushBack _wpPos;
missionNamespace setVariable ['ai_ins_patrolWPs',_patrolWPs];
_wp = _group addWaypoint [_wpPos, 0];
//_wp setWaypointSpeed _speed;
//_wp setWaypointBehaviour _stance;
[_extra,'pWP', _wpPos] call ai_ins_fnc_setParam;