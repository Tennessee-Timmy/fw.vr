params ["_group","_patrol","_cached","_fight","_wave","_cachedActive","_cUnits","_customLimit","_speak","_side","_vehicle","_alert","_transport"];
_array = _this;
_val = _patrol;
_val params ["_loc","_dist","_val2","_out",["_locObj",objNull]];
_val2 params ["_road","_stance","_speed","_trans"];
if !(canMove _vehicle) then {_trans = true;};


_vehicleLoaded = _group getVariable ["aiMaster_vehLoaded",[true,0,nil]];
_vehicleLoaded params ["_load","_time","_gotOut"];

if (!_load && !isNil "_vehicle") then {
	if (!isNull _vehicle) then {
		_loc = position _vehicle;
		_dist = _dist / 4;
		_road = false;
	};
};

_passed = time - _time;
if (isNil "_group") exitWith {};
if (isNull _group) exitWith {};


if (!isNil "_locObj" && {!isNull _locObj}) then {
	_loc = position _locObj;
};
//
// Transport waypoints
_transport params ["_transType","_transArray"];
if (_transType > 0) exitWith {
	call aiMaster_fnc_patrolsTrans;
};



_oldWP = waypointPosition [ _group, currentWaypoint _group ];
private _nearWP = _oldWP inArea [(leader _group),5,5,0,false];
private _near0 = _oldWP inArea [[0,0,0],100,100,0,false];
if ((_nearWP || _near0) && alive leader _group) then {
	if (!isNil "_gotOut") exitWith {
		_array set [1,[_loc,_dist,[false,_stance,_speed],_out,_locObj]];
		_array set [10,[0, 0, nil]];
		if (_array in aiMaster_activeGroupsVeh) then {
			aiMaster_activeGroupsVeh = aiMaster_activeGroupsVeh - [_array];
			aiMaster_activeGroups = aiMaster_activeGroups + [_array];
		};
		if (_array in aiMaster_fightingGroupsVeh) then {
			aiMaster_fightingGroupsVeh = aiMaster_fightingGroupsVeh - [_array];
			aiMaster_fightingGroups = aiMaster_fightingGroups + [_array];
		};
		aiMaster_Groups = aiMaster_Groups + [_array];
		aiMaster_GroupsVeh = aiMaster_GroupsVeh - [_array];
	};
	private _disablePatrol = _group getVariable ['aiMaster_disablePatrol',false];
	if (_disablePatrol) exitWith {};
	//_group setBehaviour _stance;
	while {(count(waypoints _group)) > 0} do {deleteWaypoint ((waypoints _group) select 0);};
	//deleteWaypoint [ _group, all ];
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

	if (_trans) exitWith {
		_wp setWaypointType "GETOUT";
		_group setVariable ["aiMaster_vehLoaded",[false,time,true]];
	};
	if (_passed > 60) exitWith {
		if (_load) exitWith {
			_wp setWaypointType "UNLOAD";
			_group setVariable ["aiMaster_vehLoaded",[false,time]];
		};
		if (!_load) exitWith {
			_wp setWaypointType "LOAD";
			_group setVariable ["aiMaster_vehLoaded",[true,time]];
		};
	};
};
true