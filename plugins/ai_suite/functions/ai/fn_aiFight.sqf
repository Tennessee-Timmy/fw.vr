params ["_group","_patrol","_cached","_fight","_wave","_cachedActive","_cUnits","_customLimit","_speak","_side","_buildingPatrol","_alert"];
_array = _this;
_leader = leader _group;
_fight params [["_offensive",false],["_autoCombat",false],["_time",nil],["_oldLoc",nil]];
if (!_offensive) exitWith { };
_dist = _patrol select 1;
private _enableExit = false;

if (!isNil "_time") then {

	// if unit is searching a building and let him continue
	_searchingHouse = _group getVariable "aiMaster_searchHouse";
	if (!isNil "_searchingHouse") exitWith {
		[_group,_searchingHouse] call aiMaster_fnc_aiSearchHouse;
		_enableExit = true;
	};

	// if enemy near run the rushing script
	_enemySpotted = _leader findNearestEnemy _leader;
	if !(isNull _enemySpotted) then {
		_rushTime = _group getVariable ["aiMaster_fightRush",(time + 100)];

		// if enemy is in a house send the group after him
		_building = nearestBuilding _enemySpotted;
		_inHouse = [_enemySpotted,_building] call aiMaster_fnc_inHouse;

		_inArea = (_leader inArea [_enemySpotted,30,30,0,false]);
		if (_inHouse && _inArea) then {
			_searching = [_group,_building] call aiMaster_fnc_aiSearchHouse;
			if (_searching) exitWith {
				_group setVariable ["aiMaster_fightRush",time];
				_enableExit = true;
			};
		};

		//if forced to exit, exit
		if (_enableExit) exitWith {};

		// if enemy is near, but in the open send guys after him if it's been less than 30 since the last rush
		_inArea = _inArea;	// grabbed from the house check above
		if (_inArea && ((time - _rushTime) > 30)) then {
			_group setSpeedMode "NORMAL";
			_group enableAttack false;
			_group setVariable ["aiMaster_fightRush",time];
			{
				if (random 1 >= 0.5) then {
					_wpPos = _x getHideFrom _enemySpotted;
					_x doMove _wpPos;
					_x moveTo _wpPos;
				};
			} count units _group;


			// if enemy really close then don't run
			_inArea = (_leader inArea [_enemySpotted,30,30,0,false]);
			if (_inArea) then {
				_group setSpeedMode "LIMITED";
			} else {
				_group setSpeedMode "NORMAL";
			};
		};
	};


	//if forced to exit, exit
	if (_enableExit) exitWith {};


	// check how long the group has been fighting for
	private _passed = time - _time;


	// if less then 30 seconds have passed or leader is 300 meters from target and less than 60 has passed then do nothing
	_inArea = (_leader inArea [_oldLoc,300,300,0,false]);
	if (_passed < 30 || (!_inArea && _passed < 60)) exitWith {_enableExit = true;};


	// if we have a enemy
	if !(isNull _enemySpotted) then {

		// if old target is more than 100m from new enemy and it's been more than 30 seconds then set a new target
		_inArea = ((_leader getHideFrom _enemySpotted) inArea [_oldLoc,100,100,0,false]);
		if (!_inArea && _passed > 15) exitWith {_enableExit = false;};

		// if we our last known information about nearest enemy is older than 60 and it's been more than 30 seconds then accelerate the process
		if ((time - (_leader targetKnowledge (driver (_enemySpotted)) select 2))> 60 && _passed > 30) then {
			_passed = _passed + 60;
		};
	} else {

		// if we don't have enemies then accelerate the proccess
		if (_passed > 10 ) then {
			_passed = _passed + 40;
		};
	};


	// if it's been 2 minutes then reset and stop searching
	if (_passed > 120) exitWith {
		_enableExit = true;
		(units _group) doFollow _leader;
		//_group enableAttack true;
		{
			_x setAnimSpeedCoef 1.00;
		}count units _group;
		if (_array in aiMaster_fightingGroups) then {
			[aiMaster_fightingGroups,_array] call aiMaster_fnc_depend;
			aiMaster_activeGroups pushBack _array;
		};
		_array set [3,[_offensive, _autoCombat, nil, nil]];
	};
};


//if forced to exit, exit
if (_enableExit) exitWith {};

// return units to formation, because they leave it for rushing
(units _group) doFollow _leader;

_findPos = {[(_this select 0),(param [2, 0]), _this select 1, 2, 0, 20, 0] call BIS_fnc_findSafePos};
_enemySpotted = _leader findNearestEnemy _leader;

if (isNull _enemySpotted || !alive _leader) exitWith {};
if (((visiblePosition _enemySpotted) select 2) > 20) exitWith { };
_knowlage = _group knowsAbout driver _enemySpotted;
if (_knowlage < 1) exitWith {};
_loc = _leader getHideFrom _enemySpotted;
private _exit = false;
if (isNil "_oldLoc") then {
	_oldLoc = _loc;
} else {
	_inArea = (_oldLoc inArea [_loc,75,75,0,false]);
	if (_inArea) exitWith {_exit = true;};
};
if (_exit) exitWith {};

_inArea = ([0,0,0] inArea [_loc,100,100,0,false]);
_inArea2 = (_leader inArea [_loc,(1000 max _dist),(1000 max _dist),0,false]);
if (_inArea || !_inArea2) exitWith {};
_posdist = (100 / _knowlage);
_wpPos = [_loc, _posdist] call _findPos;

_inArea = ([0,0,0] inArea [_wpPos,100,100,0,false]);
_inArea2 = (_leader inArea [_wpPos,(1100 max _dist),(1100 max _dist),0,false]);
if (_inArea || !_inArea2) exitWith {};
while {(count(waypoints _group)) > 0} do {deleteWaypoint ((waypoints _group) select 0);};
_wp = _group addWaypoint [_wpPos, 0];
_group setCurrentWaypoint [_group, 0];
_wp setWaypointType "SAD";
_wp setWaypointSpeed "NORMAL";
_wp setWaypointFormation "LINE";
_inArea = (_leader inArea [_wpPos,150,150,0,false]);
if (_inArea) then {
	_group setCombatMode "RED";
	if (!_autoCombat) then {
		_group setBehaviour "COMBAT";
		_group enableAttack true;
	};
} else {
	_group setCombatMode "YELLOW";
	_group setBehaviour "AWARE";
	_wp setWaypointSpeed "NORMAL";
	_group enableAttack false;
	if (!_autoCombat) then {
		_group setBehaviour "COMBAT";
	};
};
{
	_x setAnimSpeedCoef 1.00;
}count units _group;
_array set [3,[_offensive,_autoCombat,time,_loc]];
if (_array in aiMaster_activeGroups) then {
	[aiMaster_activeGroups,_array] call aiMaster_fnc_depend;
	aiMaster_fightingGroups pushBack _array;
};
true