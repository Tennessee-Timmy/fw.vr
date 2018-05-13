params ["_group","_patrol","_cached","_fight","_wave","_cachedActive","_cUnits","_customLimit","_speak","_side","_buildingPatrol","_alert"];
_array = _this;
_val = _patrol;
_val params ["_loc","_dist","_val2","_out",["_locObj",objNull]];
_val2 params ["_buildingp","_stance","_speed"];
private _first = false;


if (!alive leader _group) exitWith { };


_buildingPatrol params [["_loops",0],["_time",0],["_building",nil]];
if (isNil "_building") then {_first = true;};

private _passed = time - _time;
if (_out) then {
	_loops = _loops + 6;
	_passed = _passed + 15;
};

if (!_first && _loops < 5 + (ceil(random 12))) exitWith {
	if (!_first && (_passed < (15 + random (45)))) exitWith { };
	private _inHouse = (leader _group) inArea [_building,10,10,0,false];
	if (!_inHouse && _passed < 40) exitWith { };
	_array set [10,[(_loops + 1), _time, _building]];
	private _buildingPos = _building buildingPos -1;
	_nul = {
		if (alive _x) then {
			if (count _buildingPos isEqualTo 0) then {
				_buildingPos = _building buildingPos -1;
			} else {
				_group enableAttack false;
				_wpPos = selectRandom _buildingPos;
				//_wpPos = [ _wpPos select 0, _wpPos select 1, ( _wpPos select 2 ) ];
				//doStop _x;
				_x doMove _wpPos;
				_x moveTo _wpPos;
				_group setSpeedMode _speed;
				[_buildingPos,_wpPos] call aiMaster_fnc_depend;
			};
		};
		_group setSpeedMode "LIMITED";
		true
	} count units _group;
};

_building = objNull;
_buildingPositions = [_loc, _dist, _building, (count units _group)] call aiMaster_fnc_buildingPos;
if (isNil "_buildingPositions") exitWith {
	_array set [1,[_loc,(_dist*2),[_buildingp,_stance,_speed],_out,_LocObj]];
};
_buildingPositions params ["_posArray","_building"];

// if the group is running for first time teleport them
_first = _group getVariable ['aiMaster_buildingPatrolFirst',true];


while {(count(waypoints _group)) > 0} do {deleteWaypoint ((waypoints _group) select 0);};
//_wp = _group addWaypoint [ _wpPos, 0 ];
[_group, 1] setWaypointSpeed _speed;
_array set [10,[1,time,_building]];
_group enableAttack false;
{
	if (count _posArray == 0) exitWith {};
	_wpPos = selectRandom _posArray;
	_posArray = _posArray - [_wpPos];
	//_wpPos = [ _wpPos select 0, _wpPos select 1, _wpPos select 2 ];
	//doStop _x;
	_x doMove _wpPos;
	_x moveTo _wpPos;
	if (_first) then {_x setPosATL _wpPos;};
} count units _group;
_group setSpeedMode "FULL";
_group setVariable ['aiMaster_buildingPatrolFirst',false];
true