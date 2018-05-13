// _transType :
// 0 - diabled
// 1 - drop and go (delete)
// 2 - drop and stay (cover)
// 3 - fastrope ???
// 4 - paradrop
_transport params ["_transType","_transArray"];





// check if waypoints already given
_transDone = _group getVariable ['aiMaster_transDone',false];
if (_transDone) exitWith {
	_array set [12,[0,[]]];
	aiMaster_groups pushBack _transArray;
	_group setVariable ['aiMaster_transGiven',false];
};
// check if waypoints already given
_transGiven = _group getVariable ['aiMaster_transGiven',false];
if (_transGiven) exitWith {};


_oldWP = waypointPosition [_group, currentWaypoint _group];
private _nearWP = _oldWP inArea [(leader _group),5,5,0,false];
private _near0 = _oldWP inArea [[0,0,0],100,100,0,false];
if ((_nearWP || _near0) && alive leader _group) then {

	while {(count(waypoints _group)) > 0} do {deleteWaypoint ((waypoints _group) select 0);};

	_transGroup = (_transArray select 0);
	_transGroup setVariable ['aiMaster_transGiven',true];
	_group setVariable ['aiMaster_transGiven',true];
	_group setVariable ['aiMaster_disablePatrol',true];
	_group enableAttack false;
	private _nil = {_x disableAI "AUTOCOMBAT";false} count units _group;
	if (_transType isEqualTo 1) exitWith {

		_array set [3,[false,true,nil,nil]];

		private _wpPos = [0,0,0];
		if (_road) then {
			_wpPos = [_loc, _dist] call aiMaster_fnc_roadPos;
			_wpPos = position _wpPos;
		};
		if (!_road) then {
			_wpPos = [_loc, _dist] call aiMaster_fnc_landPos;
		};
		if (isNil "_wpPos") exitWith {};
		//_vehicle flyInHeightASL [400, 400, 400];
		_wp = _group addWaypoint [_wpPos, 0];
		_wp setWaypointSpeed _speed;
		_wp setWaypointBehaviour "CARELESS";
		_wp setWaypointType "TR UNLOAD";
		_wp setWaypointStatements ["true", "(group this) spawn {sleep 10; _this setVariable ['aiMaster_cacheTrans_delete',true];_this setVariable ['aiMaster_transDone',true];};"];

		_infwp = _transGroup addWaypoint [_wpPos, 0];
		_infwp setWaypointType "GETOUT";
		_infwp setWaypointStatements ["true", "(group this) spawn {sleep 10; _this setVariable ['aiMaster_transDone',true];};"];
/*
		_wp2 = _group addWaypoint [_wpPos,0];
		_wp2 setWaypointSpeed _speed;
		_wp2 setWaypointBehaviour "CARELESS";
		_wp2 setWaypointType "HOLD";
*/
		_spawnDir = _wpPos getDir (leader _group);
		_wpPos3 = _wpPos getpos [10000,_spawnDir];
		_wp3 = _group addWaypoint [_wpPos3,500];
		_wp3 setWaypointSpeed "FULL";
		_wp3 setWaypointBehaviour "CARELESS";
		_wp3 setWaypointType "MOVE";
	};

	if (_transType isEqualTo 2) exitWith {

		private _wpPos = [0,0,0];
		if (_road) then {
			_wpPos = [_loc, _dist] call aiMaster_fnc_roadPos;
			_wpPos = position _wpPos;
		};
		if (!_road) then {
			_wpPos = [_loc, _dist] call aiMaster_fnc_landPos;
		};
		if (isNil "_wpPos") exitWith {};
		_wp = _group addWaypoint [_wpPos, 0];
		_wp setWaypointSpeed _speed;
		_wp setWaypointBehaviour _stance;
		_wp setWaypointType "TR UNLOAD";
		_wp setWaypointStatements ["true", "(group this) spawn {sleep 10; deleteWaypoint ((waypoints _this) select 1);_this setVariable ['aiMaster_transDone',true];};"];

		_infwp = _transGroup addWaypoint [_wpPos, 0];
		_infwp setWaypointType "GETOUT";
		_infwp setWaypointStatements ["true", "(group this) spawn {sleep 10; _this setVariable ['aiMaster_transDone',true];};"];

		_wp2 = _group addWaypoint [_wpPos,0];
		_wp2 setWaypointSpeed _speed;
		_wp2 setWaypointBehaviour _stance;
		_wp2 setWaypointType "HOLD";
	};

	if (_transType isEqualTo 3) exitWith {

		_vehicle flyInHeight 150;

		private _wpPos = [0,0,0];
		if (_road) then {
			_wpPos = [_loc, _dist] call aiMaster_fnc_roadPos;
			_wpPos = position _wpPos;
		};
		if (!_road) then {
			_wpPos = [_loc, _dist] call aiMaster_fnc_landPos;
		};
		if (isNil "_wpPos") exitWith {};

		_group setVariable ["aiMaster_transGroup",_transGroup];
		_wp = _group addWaypoint [_wpPos, 0];
		_wp setWaypointSpeed _speed;
		_wp setWaypointBehaviour "CARELESS";
		_wp setWaypointType "MOVE";
		_wp setWaypointStatements ["true", "(group this) spawn {
			_transGroup = (_this) getVariable ['aiMaster_transGroup',nil];
			if (isNil '_transGroup') exitWith {};
			_transGroup spawn aiMaster_fnc_paradrop;
			sleep 10;
			_this setVariable ['aiMaster_transDone',true];
		};"];

		_infwp = _transGroup addWaypoint [_wpPos, 0];
		_infwp setWaypointType "MOVE";
		_infwp setWaypointStatements ["true", "(group this) spawn {
			sleep 20;
			waitUntil {
				private _time = time;
				sleep 5;
				(((getPosATL(vehicle (leader _this)))select 2 < 3) || ((time - _time >= 30)))
			};
			_this setVariable ['aiMaster_cacheTrans_delete',true];
			_this setVariable ['aiMaster_transDone',true];
		};"];


		_group setVariable ["aiMaster_transGroup",_transGroup];


		_spawnDir = (leader _group) getRelDir _wpPos;
		_wpPos3 = _wpPos getpos [5000,_spawnDir];
		_wp3 = _group addWaypoint [_wpPos3,500];
		_wp3 setWaypointSpeed "FULL";
		_wp3 setWaypointBehaviour "CARELESS";
		_wp3 setWaypointType "MOVE";
	};
};
true

/*

\rhsafrf\addons\rhs_c_air\scripts\WP_ParaInf.sqf
\achilles\functions_f_achilles\scripts\fn_wpParadrop.sqf


*/