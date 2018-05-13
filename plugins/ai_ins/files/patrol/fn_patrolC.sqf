/* ----------------------------------------------------------------------------
Function: ai_ins_fnc_patrolC

Description:
	cached patrol / movement

Parameters:
0:  _pad			- pad to use
Returns:
	nothing
Examples:
	call ai_ins_fnc_patrolC;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params [['_pad',objNull]];

if (isNull _pad) exitWith {};

private _pos = getpos _pad;

// find the params needed in this script
private _patrolDist = [_pad,'pDist', 100] call ai_ins_fnc_findParam;
private _pWP = [_pad,'pWP', false] call ai_ins_fnc_findParam;
private _onlyHouse = [_pad,"onlyHouse",false] call ai_ins_fnc_findParam;
private _garrison = [_pad,"garrison",false] call ai_ins_fnc_findParam;
private _road = [_pad,"road",false] call ai_ins_fnc_findParam;
private _cached = [_pad,"cached",false] call ai_ins_fnc_findParam;
private _cachedPos = [_pad,"cachedPos",[_pos]] call ai_ins_fnc_findParam;
private _pos = [_pad,"pPos",_pos] call ai_ins_fnc_findParam;


// exit if garrissoned or only house or not cached
if (_garrison || _onlyHouse || !_cached) exitWith {};

// If patrol waypoint does not exists and old wp does not exist or has not been reached yet
// todo timed check/override/max time?
if (!(_pWP isEqualType false) && {(!((_cachedPos param [0]) inArea [(_pWP),30,30,0,false]) && !(_pWP isEqualTo [0,0,0]))}) exitWith {

	// check last time this group moved when cached
	private _lastPatrolC = [_pad,'lastPatrolC', 0] call ai_ins_fnc_findParam;

	// make sure it's been at least a second since last time it moved
	if (time - _lastPatrolC < 2) exitWith {};

	// save time
	[_pad,'lastPatrolC', time] call ai_ins_fnc_setParam;

	// save last position for targeting
	private _lastPos = _pWP;

	// set wp finding distance to low
	[_pad,'pDist', 10] call ai_ins_fnc_setParam;

	// new cached pos array
	private _newCachedPos = [];

	private _newPos = _cachedPos deleteAt 0;

	// calculate new position
	private _dir = _newPos getDir _lastPos;
	_newPos = _newPos getPos [15,_dir];


	// use flatpos to get a 'good' position
	_newPos = [_newPos,_pad,false] call ai_ins_fnc_flatPos;

	_newCachedPos pushBack _newPos;

	{
		_newCachedPos pushBack _newPos;
	} forEach _cachedPos;

	// return to old wp find distance
	[_pad,'pDist', _patrolDist] call ai_ins_fnc_setParam;

	// update the unit positions with new ones
	[_pad,'cachedPos', _newCachedPos] call ai_ins_fnc_setParam;
};

//--- new waypoint

// minimum distance from other waypoints
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

// save waypoint in param
[_pad,'pWP', _wpPos] call ai_ins_fnc_setParam;