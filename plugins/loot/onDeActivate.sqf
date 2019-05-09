// code to run when a zone is deActivated
// To use params: params ['_cluster']
// avaialable variables: _cluster / _clusterLvl / _clusterParent / _clusterClusters / _clusterPosArr
params [['_cluster',objNull]];

if (isNull _cluster) exitWith {};

if (false) then {

	private _markerPos = (position _cluster);
	_markerPos set [1, _markerPos #1 - (10 + ((CBA_MissionTime mod 10)*2))];

	private _id = missionNamespace getVariable ['mission_loot_debug_marker_lastID',0];
	_id = _id + 1;
	missionNamespace setVariable ['mission_loot_debug_marker_lastID',_id];
	private _marker = createMarker [('marker_loot_debug_' + str _id),_markerPos];
	_marker setMarkerShape "ICON";
	_marker setMarkerColor 'ColorKhaki';
	_marker setMarkerType "hd_dot";
	_marker setMarkerText (str (CBA_MissionTime));

	_marker spawn {
		private _marker = _this;
		sleep 1;
		for '_i' from 1 to 0 step -0.05 do {
			sleep 0.05;
			_marker setMarkerAlpha _i;
		};
		deleteMarker _marker;
	};


};
/*
if (_clusterLvl isEqualTo 1) then {
	[_cluster,_clusterClusters] spawn {
		params ['_cluster','_clusterClusters'];

		// get existing zombies
		private _clusterZombies = _cluster getVariable ['lootCluster_zombies',[]];
		private _cachedArr = ['cached'];

		private _nil = {
			if (!isNull _x && {alive _x}) then {
				_cachedArr pushBack (getPosATL _x);
				deleteVehicle _x;
			};
			false
		} count _clusterZombies;

		_cluster setVariable ['lootCluster_zombies',_cachedArr];
	};
};*/
if (_clusterLvl isEqualTo 2) then {

	[_cluster,_clusterClusters] spawn {
		params ['_cluster','_clusterClusters'];

		{
			private _childCluster = _x;

			// get existing zombies
			private _clusterZombies = _childCluster getVariable ['lootCluster_zombies',[]];

			// exit if no array
			if (_clusterZombies isEqualTo []) exitWith {};

			private _cachedArr = ['cached'];

			private _nil = {
				if ((_x isEqualType objNull) && {!isNull _x && {alive _x}}) then {
					_cachedArr pushBack (getPosATL _x);
					deleteVehicle _x;
				};
				false
			} count _clusterZombies;

			_childCluster setVariable ['lootCluster_zombies',_cachedArr];

			false
		} count _clusterClusters;
	};

};