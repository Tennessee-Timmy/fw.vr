// [group,building] call aiMaster_fnc_aiSearchHouse;
//
//
params ["_group","_building"];
private _leader = leader _group;


_quit = {
	_group lockWP false;
	_group setVariable ["aiMaster_searchHousePositions",nil];
	_group setVariable ["aiMaster_searchHouseTime",nil];
	_group setVariable ["aiMaster_searchHouse",nil];
	_searching = _searching - _units;
	_building setVariable ["aimaster_searching",_searching];
};


// acquire required variables for the script
_searching = _building getVariable ["aimaster_searching",[]];
_searchTime = _group getVariable "aiMaster_searchHouseTime";
_groupSearchingHouse = _group getVariable ["aiMaster_searchHouse",_building];
_units = units _group;


// if we are not searching this house and there's currently atleast 75% of the building searched quit
if (!(_leader in _searching) && (({alive _x}count _searching) >= ((count (_building buildingPos -1))))) exitWith {
	false
};


// If running first time create waypoint
if (isNil "_searchTime") then {
	_group lockWP true;

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


if (_positions isEqualTo []) exitWith {call _quit;};


_searchTime = _group getVariable ["aiMaster_searchHouseTime",time];


// Abort search if the group has no units left
if (count _units isEqualTo 0) exitWith {};

// Abort search if 180 seconds have passwed
if ((time - _searchTime) > 180) exitWith {call _quit;};

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
_searching append _units;
_building setVariable ["aimaster_searching",_searching];
true