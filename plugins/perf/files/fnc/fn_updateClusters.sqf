/* ----------------------------------------------------------------------------
Function: perf_fnc_updateClusters

Description:
	Updates clusters

Parameters:
0:	_players			- makes clusters of players instead
Returns:
0:	_clusters			- array, containing clusters

Examples:
	call perf_fnc_updateClusters;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

params [['_players',false,[false]]];

// player / server have differnet ones
private _namespace = [player,missionNamespace] select (isServer);

// non player variable names
private _nToCheck = 'perf_clusterToCheck';
private _nClustersUsed = 'perf_clustersUsed';
private _nClusters = 'perf_clusters';
private _nObjCluster = 'perf_objCluster';
private _nClusterUnits = 'perf_clusterUnits';
private _nClusterType = 'Invisible';

// player variable names
if (_players) then {
	_namespace = missionNamespace;
	_nToCheck = 'perf_pClusterToCheck';
	_nClustersUsed = 'perf_pClustersUsed';
	_nClusters = 'perf_pClusters';
	_nObjCluster = 'perf_pObjCluster';
	_nClusterUnits = 'perf_pClusterUnits';
	_nClusterType = 'Name';
};

private _arrayAll = _namespace getVariable _nToCheck;
if (isNil '_arrayAll') then {
	_arrayAll = [];
	_namespace setVariable [_nToCheck,_arrayAll];
};

// used clusters ( used to find the empty ones)
private _usedClusters =	_namespace getVariable _nClustersUsed;
if (isNil '_usedClusters') then {
	_usedClusters = [];
	_namespace setVariable [_nClustersUsed,_usedClusters];
};

// get all clusters
private _clusters = _namespace getVariable _nClusters;
if (isNil '_clusters') then {
	_clusters = [];
	_namespace setVariable [_nClusters,_clusters];
};


// Unit array is empty. Get new.
if (_arrayAll isEqualTo []) then {

	call {

		// get player list
		if (_players) exitWith {
			_arrayAll append (allPlayers - (entities "HeadlessClient_F"));
		};

		// objects / units to cluster
		private _arrayB = _namespace getVariable ['perf_arrayB',[]];
		private _array = _namespace getVariable ['perf_array',[]];
		_arrayAll append _array;
		_arrayAll append _arrayB;

	};

	// remove empty clusters
	private _emptyClusters = _clusters - _usedClusters;
	_clusters = _clusters - _emptyClusters;

	private _nil = {
		deleteLocation _x;
		false
	} count _emptyClusters;

	_usedClusters = [];
	_namespace setVariable [_nClustersUsed,_usedClusters];
	_namespace setVariable [_nClusters,_clusters];

};


call {
	if (_arrayAll isEqualTo []) exitWith {true};

	// get first cluster
	private _target = _arrayAll deleteAt 0;
	private _clusterPos = getpos _target;

	// size of clusters
	private _distance = 250;
	if (_players) then {
		_distance = 50;
	};


	private _location = (nearestLocations [_clusterPos, [_nClusterType],_distance,_clusterPos]) param [0,nil];

	call {
		// if no location, create a new one
		if (isNil '_location') exitWith {

			private _clusterUnits = [];


			// create location
			_location = createLocation [_nClusterType,_clusterPos,_distance,_distance];
			_location setVariable ['perf_cluster',true];

			_location setVariable [_nClusterUnits,_clusterUnits];

			// check for other units near this 1
			private _near = _arrayAll inAreaArray [_clusterPos,_distance,_distance,0,false];

			// add current target to near units so it will also be removed from old cluster and added to the new one
			_near pushBack _target;

			// if there are other things near, update their cluster to this 1
			if !(_near isEqualTo []) then {

				// add near units to cluster and update their current cluster variable
				private _nil = {
					_clusterUnits pushBack _x;
					private _oldCluster = _x getVariable _nObjCluster;
					if (!isNil '_oldCluster') then {
						private _oldClusterUnits = _oldCluster getVariable _nClusterUnits;
						if !(isNil '_oldClusterUnits') then {
							private _deleted = _oldClusterUnits deleteAt (_oldClusterUnits find _x);
						};
					};
					_x setVariable [_nObjCluster,_location];
					_arrayAll deleteAt (_arrayAll find _x);
					false
				} count _near;
			};

			_clusters pushBack _location;
			//_target setVariable ['perf_objCluster',_location];

		};


		// we had a location, so we update the current one
		call {
			// Get units current cluster
			private _oldCluster = _target getVariable [_nObjCluster,objNull];

			// if the old one is the same as the new, exit
			if (_oldCluster isEqualTo _location) exitWith {
			};


			// cluster is not the same, so remove unit from old cluster
			private _oldClusterUnits = _oldCluster getVariable _nClusterUnits;

			// if oldclusterunits exists..
			if !(isNil '_oldClusterUnits') then {

				private _deleted = _oldClusterUnits deleteAt (_oldClusterUnits find _target);
			};

			// get the new cluster units
			private _clusterUnits = _location getVariable _nClusterUnits;

			if (isNil '_clusterUnits') then {
				_clusterUnits = [];
				_location setVariable [_nClusterUnits,_clusterUnits];
			};

			// add to this cluster units
			_clusterUnits pushBack _target;
			_target setVariable [_nObjCluster,_location];

		};
	};
	_usedClusters pushBackUnique _location;
};


_namespace setVariable [_nClustersUsed,_usedClusters];
_clusters
