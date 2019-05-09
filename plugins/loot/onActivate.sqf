// code to run when a zone is activated
// To use params: params ['_cluster']
// avaialable variables: _cluster / _clusterLvl / _clusterParent / _clusterClusters / _clusterPosArr
params [['_cluster',objNull]];

if (isNull _cluster) exitWith {};

if (false) then {

	private _markerPos = (position _cluster);
	_markerPos set [1, _markerPos #1 + (10 + ((CBA_MissionTime mod 10)*2))];

	private _id = missionNamespace getVariable ['mission_loot_debug_marker_lastID',0];
	_id = _id + 1;
	missionNamespace setVariable ['mission_loot_debug_marker_lastID',_id];
	private _marker = createMarker [('marker_loot_debug_' + str _id),_markerPos];
	_marker setMarkerShape "ICON";
	_marker setMarkerColor 'ColorPink';
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
//

if (_clusterLvl isEqualTo 1) then {

	[_cluster,_clusterClusters] spawn {
		params ['_cluster','_clusterClusters'];

		// get existing zombies
		private _clusterZombies = _cluster getVariable ['lootCluster_zombies',[]];

		// if array is not empty, quit
		// this means if the cluster already had zombies spawned, quit
		if !(_clusterZombies isEqualTo []) exitWith {
			private _unCachedArr = [];

			// loop through saved zombies and spawn them
			private _nil = {
				if (_x isEqualType []) then {
					private _zombie = ['zombie_walker',true] call fpz_zombies_fnc_spawnZombie;
					[_zombie,(_x),(random 1 > 0.75)] call fpz_zombies_fnc_zombieInit;
					_unCachedArr pushBack _zombie;
				};
				false
			} count _clusterZombies;

			if !(_unCachedArr isEqualTo []) then {
				_cluster setVariable ['lootCluster_zombies',_unCachedArr];
			};
		};


		// less zombies in the start
		private _time = floor(CBA_MissionTime / 60);
		if ((random 10) >= _time) exitWith {systemChat 'no spawn'};

		_clusterZombies pushBack 'empty';

		// loop through child clusters
		{
			call {

				// todo check if near player spawn
				//if (base_blu_1 inArea _x) exitWith {};

				//private _pos = [_x] call CBA_fnc_randPosArea;
				//if (_pos isEqualTo []) exitWith {systemChat 'failpos';};
				private _spawned = 0;

				private _posArr = _x getVariable ['lootCluster_posArr',[]];

				// todo change
				private _lootSpots = + _posArr;
				for '_i' from 0 to (count _lootSpots) do {
					(_lootSpots # _i) resize 3;
				};

				// todo use the category to spawn in faster or more zombies in military areas etc.

				{
					call {
						if (random 1 < 0.95) exitWith {};
						private _zombie = ['zombie_walker',true] call fpz_zombies_fnc_spawnZombie;
						[_zombie,(_x),(random 1 > 0.85)] call fpz_zombies_fnc_zombieInit;
						_spawned = _spawned + 1;
						_clusterZombies pushBack _zombie;
					};
					false
				} count _lootSpots;

			};

			false
		} count _clusterClusters;

		_cluster setVariable ['lootCluster_zombies',_clusterZombies];
	};

};



// lvl 4 is ~800 meters
if (_clusterLvl isEqualTo 4) then {

	// spawn random cars

	[_cluster,_clusterClusters] spawn {
		params ['_cluster','_clusterClusters'];

		// get existing cars
		private _clusterCars = _cluster getVariable ['lootCluster_zombies',[]];

	};
};