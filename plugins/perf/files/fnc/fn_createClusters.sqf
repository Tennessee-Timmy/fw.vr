/* ----------------------------------------------------------------------------
Function: perf_fnc_createClusters

Description:
	Creates clusters of units, that can be checked instead of individual positions

Parameters:
	none
Returns:
	nothing
Examples:
	call perf_fnc_createClusters;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

// objects / units to cluster
private _arrayB = player getVariable ['perf_arrayB',[]];
private _array = player getVariable ['perf_array',[]];
private _arrayAir = player getVariable ['perf_arrayAir',[]];
private _arrayAll = _array + _arrayB + _arrayAir;
private _clusters = missionNamespace getVariable ['perf_clusters',[]];
private _markers = missionNamespace getVariable ['perf_clusterMarkers',[]];

private _nil = {
	deleteMarkerLocal _x;
	false
} count _markers;
_markers = [];


private _nil = {
	deleteLocation _x;
	false
} count _clusters;
_clusters = [];


// loop until there are no objects
while {count _arrayAll > 0} do {

	// get first cluster
	private _target = _arrayAll deleteAt 0;
	private _clusterUnits = [_target];

	// get pos for cluster
	private _clusterPos = getPosATL _target;

	// check distances from 50 to 250
	private _distance = 50;
	private _increment = 50;

	// todo
	// does it make sense to cluster as small as possible?
	// if a unit is all alone nothing in 50 range, then anything else won't be checked
	// if unit has something in 50 and 100 range, up to 150 will be cheked.

	// todo2
	// maybe loop with inArea and deleteAt instead





	for '_i' from 1 to 6 do {

		// increment distance
		_distance = _distance + _increment;
		private _near = _arrayAll inAreaArray [_clusterPos,_distance,_distance,0,false];
		if (_near isEqualTo []) exitWith {};
		_clusterUnits append _near;
		_arrayAll = _arrayAll - _near;
	};

	private _location = createLocation ['CBA_NamespaceDummy',_clusterPos,_distance,_distance];
	_location setVariable ['perf_clusterUnits',_clusterUnits];
	_clusters pushBack _location;
	_target setVariable ['perf_objCluster',_location];


	private _clusterMarkers = [];
	private _marker = createMarkerLocal [(format ['clusterMarker_%1',(count _markers)]),_clusterPos];
	_marker setMarkerShapeLocal 'ELLIPSE';
	_marker setMarkerBrushLocal 'DiagGrid';
	_marker setMarkerColorLocal 'ColorYellow';
	_marker setMarkerAlphaLocal 0.7;
	_marker setMarkerSizeLocal [_distance,_distance];
	_markers pushBack _marker;
	_clusterMarkers pushBack _marker;

	_marker = createMarkerLocal [(format ['clusterMarker_%1',(count _markers)]),_clusterPos];
	_marker setMarkerShapeLocal 'ICON';
	_marker setMarkerTypeLocal 'mil_dot';
	_marker setMarkerColorLocal 'ColorBlack';
	_marker setMarkerTextLocal (str count _clusterUnits);
	_marker setMarkerAlphaLocal 0.7;
	_markers pushBack _marker;
	_clusterMarkers pushBack _marker;

	_location setVariable ['perf_clusterMarkers',_clusterMarkers];

};

missionNamespace setVariable ['perf_clusters',_clusters];
missionNamespace setVariable ['perf_clusterMarkers',_markers];

/*
//--- checks
//faster
// 0.07ms
private _pos = getpos player;
private _nearUnits = [];
{
	private _clusterUnits = _x getVariable ['perf_clusterUnits',[]];
	_nearUnits append (_clusterUnits inAreaArray [_pos, 1000,1000,0,false]);
	false
} count (nearestLocations [_pos, ["CBA_NamespaceDummy"], 1500]);
count _nearUnits;


// slower
// 0.16ms
private _pos = getpos player;
private _nearUnits = [];
private _nil = {
	private _clusterPos = _x param [0];
	if (_clusterPos inArea [_pos,1500,1500,0,false]) then {
		_nearUnits append (_x param [1,[]] inAreaArray [_pos,1000,1000,0,false]);
	};
	false
} count perf_clusters;
count _nearUnits;


// slower
private _deleted = 0;
for '_i' from 0 to ((count _arrayAll) - 1) do {
	private _element = _i - _deleted;
	private _obj = (_arrayAll select _element);
	if (_obj inArea [_clusterPos,_distance,_distance,0,false]) then {
		_clusterUnits pushBack (_arrayAll deleteAt _element);
		_deleted = _deleted + 1;
	};
};



// all squares
_worldcenter = getArray (configfile >> "CfgWorlds" >> worldName >> "centerPosition");
_worldsize = getnumber (configfile >> "CfgWorlds" >> worldName >> "mapSize");

private _markers = missionNamespace getVariable ['perf_worldMarkers',[]];
private _nil = {
	deleteMarkerLocal _x;
	false
} count _markers;
_markers = [];

private _locations = missionNamespace getVariable ['perf_worldLocations',[]];
private _nil = {
	deleteLocation _x;
	false
} count _locations;
_locations = [];

for "_i" from 0 to (_worldsize) step 250 do {
	for "_j" from 0 to (_worldsize) step 250 do {
		private _pos = [_i,_j,0];
		private _marker = createMarkerLocal [(format ['perf_worldMarker_%1',(count _markers)]),_pos];
		_marker setMarkerShapeLocal 'RECTANGLE';
		_marker setMarkerBrushLocal 'Solid';
		_marker setMarkerColorLocal 'ColorBlue';
		_marker setMarkerAlphaLocal 0.5;
		_marker setMarkerSizeLocal [125,125];
		_markers pushBack _marker;
		private _location = createLocation ['CBA_NamespaceDummy',_pos,125,125];
		_location setVariable ['perf_locationMarker',_marker];
		_locations pushBack _location;
	};
};
missionNamespace setVariable ['perf_worldMarkers',_markers];
missionNamespace setVariable ['perf_worldLocations',_locations];

private _pos = getpos player;
private _nil = {
	_marker = _x getVariable ['perf_locationMarker',nil];
	if (!isNil '_marker') then {
		//_marker setMarkerColorLocal 'ColorRed';
	};
	false
}count (nearestLocations [_pos, ["CBA_NamespaceDummy"], 1500]);
*/

// markers

private _clusters = missionNamespace getVariable ['perf_clusters',[]];
private _markers = missionNamespace getVariable ['perf_clusterMarkers',[]];

private _nil = {
	deleteMarkerLocal _x;
	false
} count _markers;
_markers = [];

// loop until there are no objects
private _nil = {

	// get first cluster
	private _location = _x;

	private _clusterUnits = _location getVariable ['perf_clusterUnits',[]];
	private _clusterPos = position _location;
	private _distance = 250;


	private _clusterMarkers = [];
	private _marker = createMarkerLocal [(format ['clusterMarker_%1',(count _markers)]),_clusterPos];
	_marker setMarkerShapeLocal 'ELLIPSE';
	_marker setMarkerBrushLocal 'DiagGrid';
	_marker setMarkerColorLocal 'ColorYellow';
	_marker setMarkerAlphaLocal 0.7;
	_marker setMarkerSizeLocal [_distance,_distance];
	_markers pushBack _marker;
	_clusterMarkers pushBack _marker;

	_marker = createMarkerLocal [(format ['clusterMarker_%1',(count _markers)]),_clusterPos];
	_marker setMarkerShapeLocal 'ICON';
	_marker setMarkerTypeLocal 'mil_dot';
	_marker setMarkerColorLocal 'ColorBlack';
	_marker setMarkerTextLocal (str count _clusterUnits);
	_marker setMarkerAlphaLocal 0.7;
	_markers pushBack _marker;
	_clusterMarkers pushBack _marker;

	false
} count _clusters;

missionNamespace setVariable ['perf_clusterMarkers',_markers];