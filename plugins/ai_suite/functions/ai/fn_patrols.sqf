params ["_group","_patrol","_cached","_fight","_wave","_cachedActive","_cUnits","_customLimit","_speak","_side","_buildingPatrol","_alert"];
_array = _this;

// quit if trans given but not done
_transGiven = _group getVariable ['aiMaster_transGiven',false];
_transDone = _group getVariable ['aiMaster_transDone',false];
if(_transGiven && !_transDone) exitWith {};

_val = _patrol;
_val params ["_loc","_dist","_val2","_out",["_locObj",objNull]];


if (!isNil "_locObj" && {!isNull _locObj}) then {
	_loc = position _locObj;
};
_array set [1,[_loc,_dist,_val2,_out,_locObj]];

if ((side _group) isEqualTo civilian) then {

	{
		private _stopped = _x getVariable ['ten_stopped',0];
		if ((time - _stopped) >= (10 + (random 40))) then {
			_x setVariable ['ten_stopped',0];
			_x enableAI 'PATH';
		} else {
			if (random 1 > 0.3) then {
				_x disableAI 'PATH';
				_x setVariable ['ten_stopped',time];
			};
		};
	} count (units _group);
};


_val2 params ["_building","_stance","_speed"];
if (_building) exitWith {_this call aiMaster_fnc_buildingPatrols;};
_oldWP = waypointPosition [_group, currentWaypoint _group];
private _nearWP = _oldWP inArea [(leader _group),5,5,0,false];
private _near0 = _oldWP inArea [[0,0,0],100,100,0,false];
if ((_nearWP || _near0) && alive leader _group) then {
	private _exitTime = 0;
	if ((side _group) isEqualTo civilian) then {
		_exitTime = _group getVariable ['ten_wp_exit',0];
		if (_exitTime isEqualTo 0) then {
			_exitTime = (time + (15 + (random 45)));
			_group setVariable ['ten_wp_exit',_exitTime];
		};
	};
	if (time < _exitTime) exitWith {};




	_group setBehaviour _stance;
	_group setSpeedMode _speed;
	while {(count(waypoints _group)) > 0} do {deleteWaypoint((waypoints _group)select 0);};
	//deleteWaypoint [ _group, all ];
	private _minDist = _dist / 5;
	private _wpPos = [0,0,0];
	waitUntil {
		_wpPos = [_loc, _dist] call aiMaster_fnc_landPos;
		_close = aiMaster_patrolWP inAreaArray [_wpPos,_minDist,_minDist,0,false];
		if (!(_wpPos isEqualTo [0,0,0]) && _close isEqualTo []) then {true} else {
			_minDist = _minDist / 2;
			_dist = _dist + (_dist / 10);
			false
		};
	};
	aiMaster_patrolWP pushBack _wpPos;
	_wp = _group addWaypoint [ _wpPos, 0 ];
	_wp setWaypointSpeed _speed;
	_wp setWaypointBehaviour _stance;
};
true