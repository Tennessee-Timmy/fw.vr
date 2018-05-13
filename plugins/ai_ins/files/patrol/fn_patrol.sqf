/* ----------------------------------------------------------------------------
Function: ai_ins_fnc_patrol

Description:
	caching logic for array

Parameters:
0:	_pad		- pad to patrol
Returns:
	nothing
Examples:
	call ai_ins_fnc_patrol;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params [['_pad',objNull]];

if (isNull _pad) exitWith {};

private _pos = getpos _pad;

// find the params needed in this script
private _group = [_pad,"group",false] call ai_ins_fnc_findParam;
private _patrolDist = [_pad,'pDist', 100] call ai_ins_fnc_findParam;
private _pWP = [_pad,'pWP', false] call ai_ins_fnc_findParam;
private _house = [_pad,"house",false] call ai_ins_fnc_findParam;
private _houseSize = [_pad,"houseSize",2] call ai_ins_fnc_findParam;
private _houseChecks = [_pad,"houseChecks",2] call ai_ins_fnc_findParam;
private _onlyHouse = [_pad,"onlyHouse",false] call ai_ins_fnc_findParam;
private _trans = [_pad,"trans",false] call ai_ins_fnc_findParam;
private _garrison = [_pad,"garrison",false] call ai_ins_fnc_findParam;
private _road = [_pad,"road",false] call ai_ins_fnc_findParam;
private _pos = [_pad,"pPos",_pos] call ai_ins_fnc_findParam;

// exit if group empty
if (isNil "_group" || {!(_group isEqualType false) && {(isNull _group) || {units _group isEqualTo []}} || _group isEqualType false}) exitWith {};

// if garrison, exit with garrion script
if (_garrison) exitWith {

	// stop group from following waypoints
	[_pad,_group,_patrolDist,_houseSize,true,_houseChecks] call ai_ins_fnc_garrison;
};

// get old waypoint
private _oldWP = waypointPosition [_group, currentWaypoint _group];

// If patrol waypoint does not exists and old wp does not exist or has not been reached yet
// todo timed check/override/max time?
if (
    // _pWP is not a boolean AND
	!(_pWP isEqualType false) &&
	{
		// leader is not near the old wp AND
		(!((leader _group) inArea [(_oldWP),15,15,0,false]) &&
		// old wp is not 0,0,0
		!(_oldWP isEqualTo [0,0,0]))
	}
) exitWith {
	// will do nothing until reached wp
};

//--- New waypoint
// delete all waypoints
while {(count(waypoints _group)) > 0} do {
	deleteWaypoint((waypoints _group)select 0);
};

// minimum distance from the current location (patrol dist / 5)
private _minDist = _patrolDist / 5;

// make current wp pos 0 so we can check it until there's a correct one
private _wpPos = [0,0,0];

// get the current waypoints
private _patrolWPs = missionNamespace getVariable ['ai_ins_patrolWPs',[]];

// wait for a valid waypoint
waitUntil {

	// get a new waypoint position
	_wpPos = [_pos,_pad,false] call ai_ins_fnc_flatPos;

	// check if the new waypoint is too close to any existing ones (so everyone is not at the same spot)
	private _close = _patrolWPs inAreaArray [_wpPos,_minDist,_minDist,0,false];

	// if waypoint exists and existing ones are not close, we are good
	if (!(_wpPos isEqualTo [0,0,0]) && (_close isEqualTo [])) then {
		true
	} else {

		// failed, so decrease the close wp check distance
		_minDist = _minDist / 2;

		// .. and increase waypoint distatnce
		_dist = _patrolDist + (_patrolDist / 10);
		[_pad,'pDist',_dist] call ai_ins_fnc_setParam;
		false
	};
};

// add this waypoint to waypoint list
_patrolWPs pushBack _wpPos;
missionNamespace setVariable ['ai_ins_patrolWPs',_patrolWPs];

// add the waypoint
_wp = _group addWaypoint [_wpPos, 0];

// todo behaviour / formation / speed
//_wp setWaypointSpeed _speed;
//_wp setWaypointBehaviour _stance;

// save waypoint in param
[_pad,'pWP', _wpPos] call ai_ins_fnc_setParam;