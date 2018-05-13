// [group,building] call aiMaster_fnc_searchHouse;
//
//
params ["_group","_building"];
private _leader = leader _group;

_quit = {
	_group lockWP false;
	_group setVariable ["aiMaster_searchHousePositions",nil];
	_group setVariable ["aiMaster_searchHouseTime",nil];
	_group setVariable ["aiMaster_searchHouse",nil];
	_group setVariable ['aiMaster_searchHouseLast',time];

	while {(count(waypoints _group)) > 0} do {deleteWaypoint ((waypoints _group) select 0);};
};
_time = _group getVariable "aiMaster_searchHouseTime";

private _lastTime = _group getVariable ['aiMaster_searchHouseLast',0];
if (time - _lastTime < (20 + random 30) && isNil '_time') exitWith {false};

// If running first time create waypoint
if (isNil "_time") then {

	_group lockWP true;
	_group setVariable ['aiMaster_searchHouseLast',time];

	// Prepare group to search
	// todo check if old waypoint stays and creates a new one before the old one
	_wp = _group addWaypoint [getPos _leader, 0, 0];
	_cond = "({unitReady _x || !(alive _x)} count thisList) == count thisList";
	_comp = format ["this setFormation '%1'; this setBehaviour '%2'; deleteWaypoint [group this, currentWaypoint (group this)];",formation _group,behaviour _leader];
	_wp setWaypointStatements [_cond,_comp];
	_group setCurrentWaypoint [_group, 0];

	//_group setBehaviour "Combat";
	_group setFormDir ([_leader, _building] call BIS_fnc_dirTo);
};

// prepare positions and time
// todo custom building positions
private _positions = _group getVariable ["aiMaster_searchHousePositions",(_building buildingPos -1)];
private _nextPosUpdate = _group getVariable ['aiMaster_searchHousePositionsTime',(0)];

// get new positions if it's time is bigger than next update
if (_positions isEqualTo [] && _nextPosUpdate < time) then {
	_positions = (_building buildingPos -1);
	_group setVariable ['aiMaster_searchHousePositionsTime',(time + (5 + random 25))];
};


// Update units in case of death
_units = units _group;

// Abort search if the group has no units left
if (count _units isEqualTo 0) exitWith {};

// Abort search if 120 seconds have passwed
if ((time - _time) > 120 && _positions isEqualTo []) exitWith {call _quit;};

if (_positions isEqualTo []) exitWith {

};

// Send all available units to the next available position
_nul = {
    if (_positions isEqualTo []) exitWith {};
    if (unitReady _x) then {
        _pos = _positions deleteAt 0;
        _x commandMove _pos;
		_x doMove _pos;
		_x moveTo _pos;
    };
    false
} count _units;

// setVariables for group for the loop
_group setVariable ["aiMaster_searchHouseTime",time];
_group setVariable ["aiMaster_searchHousePositions",_positions];
_group setVariable ["aiMaster_searchHouse",_building];

_searching = _building getVariable ["aimaster_searching",0];
_building setVariable ["aimaster_searching",(_searching + (count _units))];

true