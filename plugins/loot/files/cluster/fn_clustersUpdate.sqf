/* ----------------------------------------------------------------------------
Function: loot_fnc_clustersUpdate

Description:
	Creates and updates the clusters for loot

Parameters:
	none

Returns:
	Array of clusters
Examples:
	call loot_fnc_clustersUpdate;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// code begins
private _levels = 6;
private _isDebug = false;

// delete markers
private _markers = missionNamespace getVariable ['mission_loot_clusterMarkers',[]];
{deleteMarker _x}count _markers;

// delete locations function
private _delLoc = {
	params [['_loc',objNull]];
	if (isNull _loc) exitWith {};
	if ((_loc getVariable ['lootCluster_level',-1])isEqualTo 0) exitWith {};
	deleteLocation _loc;
};
private _nil = {
	_x call _delLoc;
	false
} count (nearestLocations [([worldSize/2,worldSize/2]),['Invisible'],worldSize]);


// marking function
private _markCluster = {};
if (isServer && hasInterface && _isDebug) then {
	_markCluster = {
		params [['_cluster',objNull]];
		if (isNull _cluster) exitWith {};

		// get cluster data
		private _clusterPos = locationPosition _cluster;
		private _clusterLevel = _cluster getVariable ['lootCluster_level',0];
		private _buildingAmount = count (_cluster getVariable ['lootCluster_posArr',[]]);
		private _clusterAmount = count (_cluster getVariable ['lootCluster_clusters',[]]);

		// marker data
		private _markerSize = size _cluster;
		private _markerText = ('Lvl: ' + str _clusterLevel);
		if (_clusterLevel isEqualTo 0) then {
			_markerText = (_markerText + ' | C: ' + str _buildingAmount);
		} else {
			_markerText = (_markerText + ' | C: ' + str _clusterAmount);
		};

		private _markers = missionNamespace getVariable ['mission_loot_clusterMarkers',[]];

		// text marker
		private _marker = createMarker [('marker_lootCluster_' + str(count _markers)),_clusterPos];
		_marker setMarkerText _markerText;
		_marker setMarkerShape 'ICON';
		_marker setMarkerType 'mil_triangle';
		_marker setMarkerColor 'ColorBlack';
		_marker setMarkerAlpha ([0,1] select (_clusterLevel isEqualTo 11));
		_markers pushBack _marker;

		// area marker
		private _markerA = createMarker [('marker_lootCluster_' + str(count _markers)),_clusterPos];
		_markerA setMarkerShape 'ELLIPSE';
		_markerA setMarkerBrush 'SolidBorder';
		_markerA setMarkerSize _markerSize;
		private _alpha = 0.1;
		_markerA setMarkerColor call {
			if (_clusterLevel isEqualTo 0) exitWith {
				_alpha = 0.3;
				'ColorRed'
			};
			if (_clusterLevel isEqualTo 1) exitWith {
				_alpha = 0.25;
				'ColorOrange'
			};
			if (_clusterLevel isEqualTo 2) exitWith {
				_alpha = 0.20;
				'ColorYellow'
			};
			if (_clusterLevel isEqualTo 3) exitWith {
				_alpha = 0.15;
				'ColorGreen'
			};
			if (_clusterLevel isEqualTo 4) exitWith {
				_alpha = 0.10;
				'ColorBlue'
			};
			if (_clusterLevel isEqualTo 5) exitWith {
				_alpha = 0.05;
				'ColorBlack'
			};
			'ColorGrey'
		};
		_markerA setMarkerAlpha _alpha;
		_markers pushBack _markerA;
		missionNamespace setVariable ['mission_loot_clusterMarkers',_markers];
	};
};


private _buildings = missionNamespace getVariable ['mission_loot_buildings',[]];
private _posArr = missionNamespace getVariable ['mission_loot_posArr',[]];

private _buildingTypeArr = [];

// if no buildings array, make one from all terrain objects and all mission buildings
if (_buildings isEqualTo []) then {
	_buildings = nearestTerrainObjects [[worldSize / 2,worldSize / 2],['BUILDING','HOUSE','CHURCH','CHAPEL','BUNKER','FORTRESS','VIEW-TOWER','LIGHTHOUSE','FUELSTATION','HOSPITAL','BUSSTOP','RUIN','TOURISM','WATERTOWER'],worldSize];
	_buildings append (allMissionObjects 'Building');

	_buildings = _buildings inAreaArray 'LOOT_AREA';

	// filter to only buildings with buildingpositions
	_buildings = _buildings select {
		private _buildingPos = _x buildingPos -1;

		// todo determine house type and add it with the building positions
		//configfile >> "CfgVehicles" >> "Land_u_Shop_02_V1_F" >> "editorSubcategory"
		//configfile >> "CfgVehicles" >> "Land_u_Shop_02_V1_F" >> "vehicleClass"
		// categorize
		private _category = (typeOf _x) call {
			private _type = _this param [0,''];
			private _class = toLower (getText (configfile >> "CfgVehicles" >> _type >> "vehicleClass"));

			_buildingTypeArr pushBackUnique _class;

			if (_class find 'town' > -1) exitWith {'residential'};
			if (_class find 'village' > -1) exitWith {'residential'};
			if (_class find 'commercial' > -1) exitWith {'residential'};
			if (_class find 'cultural' > -1) exitWith {'residential'};

			if (_class find 'infrastructure' > -1) exitWith {'industrial'};
			if (_class find 'industrial' > -1) exitWith {'industrial'};
			if (_class find 'sports' > -1) exitWith {'industrial'};

			if (_class find 'military' > -1) exitWith {'military'};
			'default'
		};


		// apply the type as 2nd element to every position
		//private _appendArray = _buildingPos apply {[_x, _category]};
		for '_i' from 0 to (count _buildingPos) do {
			(_buildingPos # _i) pushBack _category;
		};
		_posArr append _buildingPos;

		!((_buildingPos) isEqualTo [])
	};

	missionNamespace setVariable ['mission_loot_buildings',_buildings];
	missionNamespace setVariable ['mission_loot_posArr',_posArr];
};

missionNamespace setVariable ['mission_loot_buildingTypeArray',_buildingTypeArr];


//private _clusters = missionNamespace getVariable ['mission_loot_clusters',[]];
private _clusters = [];
//private _allClusters = missionNamespace getVariable ['mission_loot_allClusters',[]];
private _allClusters = [];



// create clusters which will have all the buildings in them
call {
	_clusters = missionNamespace getVariable ['mission_loot_posArrClusters',[]];
	if !(_clusters isEqualTo []) exitWith {};

	// loop forver
	for '_i' from 0 to 1 step 0 do {

		// exit if all buildings are in clusters
		if (_posArr isEqualTo []) exitWith {};

		// get building to work with
		private _lootPos = _posArr deleteAt 0;

		// todo get the building type too

		call {
			if (isNil '_lootPos' || {!(_lootPos isEqualType []) || {_lootPos isEqualTo []}}) exitWith {};

			//private _buildingPos = getPosASL _building;

			private _lootPosition = + _lootPos;
			_lootPosition resize 3;



			// check if there is a cluster close
			private _nearClusters = nearestLocations [_lootPosition,['Invisible'],(25)];

			// find the first cluster which has level 0
			private _nearClusterIndex = (_nearClusters findIf {
				(_x getVariable ['lootCluster_level',99]) == 0
			});

			// exit if cluster found
			if (_nearClusterIndex != -1) exitWith {

				private _cluster = _nearClusters # _nearClusterIndex;
				private _clusterPosArr = _cluster getVariable ['lootCluster_posArr',[]];
				_clusterPosArr pushback _lootPos;
			};


			private _clusterPosArr = [_lootPos];

			private _cluster = createLocation ['Invisible',_lootPosition,50,50];

			//private _nearPosArr = _posArr inAreaArray [_lootPos,25,25,0,false];
			//diag_log str (count _posArr);

			//_clusterPosArr append _nearPosArr;
			//_posArr = _posArr - _nearPosArr;

			_cluster setVariable ['lootCluster_posArr',_clusterPosArr];
			_cluster setVariable ['lootCluster_level',0];
			_clusters pushBack _cluster;
			//_cluster call _markCluster;

		};
	};

	missionNamespace setVariable ['mission_loot_posArrClusters',_clusters];
};

// update allClusters
_allClusters append _clusters;

// cluster the clusters
call {

	// used clusters so they don't get added into 2 of them
	private _usedClusters = [];

	// 5 leves of clusters
	for '_clusterLevel' from 1 to _levels do {

		// size of the cluster ( 500 to 5000 )
		private _dist = call {
			if (_clusterLevel isEqualTo 1) exitWith {100};
			if (_clusterLevel isEqualTo 2) exitWith {200};
			if (_clusterLevel isEqualTo 3) exitWith {400};
			if (_clusterLevel isEqualTo 4) exitWith {800};
			if (_clusterLevel isEqualTo 5) exitWith {1600};
			if (_clusterLevel isEqualTo 6) exitWith {3200};
			if (_clusterLevel isEqualTo 7) exitWith {6400};
			if (_clusterLevel isEqualTo 8) exitWith {12800};
			if (_clusterLevel isEqualTo 9) exitWith {25600};
			if (_clusterLevel isEqualTo 10) exitWith {51200};
			500 * _clusterLevel
		};

		_dist = _dist/2;

		// copy clusters (deep copy)
		private _clusterCopy = + _clusters;
		_clusters = [];

		// loop forver
		for '_i' from 0 to 1 step 0 do {

			// exit if no more clusters left in the copy
			if (_clusterCopy isEqualTo []) exitWith {};

			// get cluster to work with
			private _oldCluster = _clusterCopy deleteAt 0;

			call {
				if (isNil '_oldCluster' || {isNull _oldCluster}) exitWith {};

				private _oldClusterPos = locationPosition _oldCluster;

				private _cluster = createLocation ['Invisible',_oldClusterPos,(_dist*1.5),(_dist*1.5)];
				//_cluster setSize [(_dist *1.5),(_dist * 1.5)];
				_cluster setVariable ['lootCluster_level',_clusterLevel];

				// get all clusters 1 level below this cluster
				private _nearClusters = nearestLocations [_oldClusterPos,['Invisible'],(_dist)];
				_nearClusters = _nearClusters select {(_x getVariable ['lootCluster_level',99]) isEqualTo (_clusterLevel - 1) && !(_x in _usedClusters)};

				// make array of clusters for this cluster
				//_clusterClusters append _nearClusters;

				// save parent
				private _nil = {
					_x setVariable ['lootCluster_parent',_cluster];
					false
				} count _nearClusters;
				_clusterCopy = _clusterCopy - _nearClusters;

				_cluster setVariable ['lootCluster_clusters',_nearClusters];
				_usedClusters append _nearClusters;

				_clusters pushBack _cluster;
				//_cluster call _markCluster;

				// update allClusters
				_allClusters pushback _cluster;
			};
		};

		missionNamespace setVariable [('mission_loot_clusters_'+ str _clusterLevel),_clusters];
	};
};

missionNamespace setVariable ['mission_loot_clusters',_clusters];
missionNamespace setVariable ['mission_loot_allClusters',_allClusters];


reverse _allClusters;

private _nil = {
	_x call _markCluster;
	false
}count _allClusters;




private _allClusters = [];

private _addClusters = {
	params [['_clusters',[]]];
	{
		if !((_x getVariable ['lootCluster_level',99]) isEqualTo 99) then {
			_allClusters pushBack _x;
		};
		private _xClusters = (_x getVariable ['lootCluster_clusters',[]]);
		call {
			if (_xClusters isEqualTo []) exitWith {};
			[_xClusters] call _addClusters;
		};
		false
	} count _clusters;
};

[mission_loot_clusters] call _addClusters;

count _allClusters
