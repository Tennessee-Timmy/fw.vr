params ["_group","_patrol","_cached","_fight","_wave","_cachedActive","_cUnits","_customLimit","_speak","_side","_vehicle","_alert","_rushDist"];
_array = _this;
_leader = leader _group;
_fight params [["_offensive",false],["_autoCombat",false],["_time",nil],["_oldLoc",nil]];
//_speed = (_patrol select 2) select 2;
_rushDist = 15;

// trans exit
_transGiven = _group getVariable ['aiMaster_transGiven',false];
if (_transGiven) exitWith {};

private _disablePatrol = _group getVariable ['aiMaster_disablePatrol',false];
if (_disablePatrol) exitWith {};

if (!_offensive) exitWith { };
private _enableExit = false;

if (!isNil "_time") then {
	_enemySpotted = _leader findNearestEnemy _leader;
	if !(isNull _enemySpotted) then {
		_rushTime = _group getVariable ["aiMaster_fightRush",(time)];
		if (time - _rushTime > 15) then {
			if (!(canMove _vehicle) || (isNull gunner _vehicle)) then {
				_rushDist = 100;
			};
			if (_enemySpotted distance _leader < _rushDist) then {
				_group setVariable ["aiMaster_fightRush",time];
				{
					if ((isNull gunner _vehicle)||((!(_x isequalto gunner _vehicle) && !(_x isequalto driver _vehicle)))) then {
						doStop _x;
						(group _x) enableAttack false;
						_x leaveVehicle _vehicle;
						_enemySpotted = _x findNearestEnemy _x;
						if !(isNull _enemySpottedx) then {
							_wpPos = _x getHideFrom _enemySpotted;
							_x doMove _wpPos;
							_x moveTo _wpPos;
						};
					};
				} count units _group;
			};
			_rushDist = 50;
			if (_enemySpotted distance _leader < _rushDist) then {
				if !(isNull gunner _vehicle) then {
					_enemySpotted = driver _vehicle findNearestEnemy driver _vehicle;
					_wpPos = driver _vehicle getHideFrom _enemySpotted;
					driver _vehicle doMove _wpPos;
					driver _vehicle moveTo _wpPos;
				};
			};
		};
	};
	private _passed = time - _time;
	if (_passed < 30 || (_enemySpotted distance _leader > 600 && _passed < 60)) exitWith {_enableExit = true;};
	if !(isNull _enemySpotted) then {
		if (_enemySpotted distance _leader > 50 && _passed > 30) exitWith {_enableExit = false;};
		if ((time - (_leader targetKnowledge (driver (_enemySpotted)) select 2))> 60)then {_passed = _passed + 60;}
	};
	if (_passed > 120) then {
		_enableExit = true;
		(units _group) doFollow _leader;
		_group enableAttack true;
		if (_array in aiMaster_fightingGroupsVeh) then {
			[aiMaster_fightingGroupsVeh,_array] call aiMaster_fnc_depend;
			aiMaster_activeGroupsVeh pushBack _array;
			_group addVehicle _vehicle;
			units _group orderGetIn true;
		};
		_array set [3,[_offensive,_autoCombat,nil,nil]];
	};
};
if (_enableExit) exitWith {};

// return units to formation, because they leave it for rushing
(units _group) doFollow _leader;


_findPos = {[(_this select 0),(param [2, 0]), _this select 1, 2, 0, 20, 0] call BIS_fnc_findSafePos};
_enemySpotted = _leader findNearestEnemy _leader;

if (isNull _enemySpotted || !alive _leader) exitWith { };
if ((visiblePosition _enemySpotted select 2) > 100) exitWith { };
_knowlage = _group knowsAbout driver _enemySpotted;
if (_knowlage < 1) exitWith { };
_loc = _leader getHideFrom _enemySpotted;
if (isNil "_oldLoc") then {
	_oldLoc = _loc;
} else {
	if (_oldLoc distance _loc < 100) exitWith { };
};
if (_loc distance [0,0,0] < 100 || _loc distance _leader > 1600) exitWith { };
_dist = (100 / _knowlage);
_wpPos = [_loc,_dist] call _findPos;
if (_wpPos distance [0,0,0] < 10 || _wpPos distance _leader > 1600) exitWith { };
if (_wpPos distance _leader > 800) exitWith { };
while {(count (waypoints _group)) > 0} do {deleteWaypoint ((waypoints _group) select 0);};
_wp = _group addWaypoint [ _wpPos, 0 ];
_wp setWaypointType "SAD";
_wp setWaypointSpeed "FULL";
if (!_autoCombat) then {
	_group setCombatMode "RED";
	_group setBehaviour "COMBAT";
} else {
	_group setCombatMode "YELLOW";
	_group setCombatMode "AWARE";
};
_array set [3,[_offensive, _autoCombat, time, _loc]];
if ( _array in aiMaster_activeGroupsVeh ) then {
	[aiMaster_activeGroupsVeh,_array] call aiMaster_fnc_depend;
	aiMaster_fightingGroupsVeh pushBack _array;
};

// if transport group, getout and set as infantry
_val = _patrol;
_val params ["_loc","_dist","_val2","_out",["_locObj",objNull]];
_val2 params ["_road","_stance","_speed","_trans"];
if !(canMove _vehicle) then {_trans = true;};
if (_trans) exitWith {
	_group leaveVehicle _vehicle;
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

	_array set [1,[_loc,(_dist),[false,_stance,_speed],_out,_locObj]];
};


true