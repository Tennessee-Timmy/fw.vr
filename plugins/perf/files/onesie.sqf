perf_fnc_clientInit = {


	private _arrayB = player getVariable ['perf_arrayB',(allMissionObjects "Building")];
	player setVariable ['perf_arrayB',_arrayB];


	private _array = player getVariable ['perf_array',[]];
	player setVariable ['perf_array',_array];


	private _arrayAir = player getVariable ['perf_arrayAir',[]];
	player setVariable ['perf_arrayAir',_arrayAir];



	["Building", "init", {
		private _arrayB = player getVariable 'perf_arrayB';
		if (isNil '_arrayB') then {
			_arrayB = [];
			player setVariable ['perf_arrayB',_arrayB];
		};
		_arrayB pushBack (_this param [0])
	},true,[],true] call CBA_fnc_addClassEventHandler;
	["AllVehicles", "init", {
		private _obj = _this param [0];
		private _arrayN = "perf_array";
		if (_obj isKindOf "Air") then {
			_arrayN = "perf_arrayAir";
		};
		private _array = player getVariable _arrayN;
		if (isNil '_array') then {
			_array = [];
			player setVariable [_arrayN,_array];
		};
		_array pushBack _obj;
	},true,[],true] call CBA_fnc_addClassEventHandler;



	private _dist = player getVariable ['perf_dist',viewDistance];
	['perf_dist',_dist,true] call perf_fnc_srvVar;


	private _stop = player getVariable ['perf_stop',false];
	['perf_stop',_stop,true] call perf_fnc_srvVar;


	private _pause = player getVariable ['perf_pause',false];
	['perf_pause',_pause,true] call perf_fnc_srvVar;


	private _toUnCache = player getVariable ['perf_toUnCache',[]];
	player setVariable ['perf_toUnCache',_toUnCache];




	private _cached = player getVariable ['perf_cachedArr',[]];
	['perf_cachedArr',_cached,true] call perf_fnc_srvVar;


	private _cachedOld = player getVariable ['perf_cachedArrOld',[]];
	player setVariable ['perf_cachedArrOld',_cachedOld];


	private _cachedNew = player getVariable ['perf_cachedArrNew',[]];
	player setVariable ['perf_cachedArrNew',_cachedNew];

	private _toCache = player getVariable ['perf_toCache',[]];
	player setVariable ['perf_toCache',_toCache];


	private _toCheck = player getVariable ['perf_toCheck',[]];
	player setVariable ['perf_toCheck',_toCheck];




	private _pol = missionNamespace getVariable ['perf_pol',[0,0,0]];
	missionNamespace setVariable ['perf_pol',_pol];


	call perf_fnc_updateClusters;
};
perf_fnc_clientLoop = {
	_uncache_all = {
		private _nil = {
			if (_x getVariable ['perf_cached',false]) then {
				_x call _unCache;
			};
			_cachedArrNew deleteAt (_cachedArrNew find _x);
			false
		} count _arrayAll;

	};
	_cache = {
		private _target = _this;
		if (_target getVariable ['perf_cached',false]) exitWith {};
		_target hideObject true;
		_target enableSimulation false;
		_target setVariable ['perf_cached',true];


		_cachedArrNew pushBack _target;
	};
	_unCache = {
		private _target = _this;
		if !(_target getVariable ['perf_cached',false]) exitWith {};
		_target enableSimulation true;
		_target hideObject false;
		_target setVariable ['perf_cached',false];


		_cachedArr deleteAt (_cachedArr find _target);



		_toCheck deleteAt (_toCheck find _target);



	};



	private _cachedArr = player getVariable ['perf_cachedArr',[]];
	private _cachedArrNew = player getVariable 'perf_cachedArrNew';
	if (isNil '_cachedArrNew') then {
		_cachedArrNew = [];
		player setVariable ['perf_cachedArrNew',_cachedArrNew];
	};
	private _cachedArrRem = player getVariable 'perf_cachedArrRem';
	if (isNil '_cachedArrRem') then {
		_cachedArrRem = [];
		player setVariable ['perf_cachedArrRem',_cachedArrRem];
	};

	private _toCheck = player getVariable ['perf_toCheck',[]];



	private _toUnCacheNew = player getVariable 'perf_toUnCacheNew';
	if (isNil '_toUnCacheNew') then {
		_toUnCacheNew = [];
		player setVariable ['perf_toUnCacheNew',_toUnCacheNew];
	};
	private _toUnCache = player getVariable 'perf_toUnCache';
	if (isNil '_toUnCache') then {
		_toUnCache = [];
		player setVariable ['perf_toUnCache',_toUnCache];
	};


	_toUnCache append _toUnCacheNew;



	{
		_x call _unCache;
	} forEach _toUnCache;


	player setVariable ['perf_toUnCacheNew',[]];
	player setVariable ['perf_toUnCache',[]];


	private _arrayB = player getVariable ['perf_arrayB',[]];
	private _array = player getVariable ['perf_array',[]];
	private _arrayAir = player getVariable ['perf_arrayAir',[]];
	private _arrayAll = _array + _arrayB + _arrayAir;



	call {




		if ((!visibleMap) && !(positionCameraToWorld [0,0,0] inarea [player,50,50,0,false]) && {isNull curatorCamera}) exitWith {
			call _uncache_all;


			['perf_pause',true] call perf_fnc_srvVar;


			sleep 1;
		};


		if (player getVariable ['perf_pause',false]) then {
			['perf_pause',false] call perf_fnc_srvVar;
		};



		private _dist = player getVariable ['perf_dist',viewDistance];



		private _dist2 = (_dist + (_dist/4)+250);



		private _target = player;


		if (!isNull curatorCamera) then {
			_target = curatorCamera;

			private _curator = player getVariable ['perf_curator',player];
			if (_curator isEqualTo player) then {

				private _curatorObj = 'Land_HelipadEmpty_F' createVehicle [0,0,0];
				['perf_curator',_curatorObj] call perf_fnc_srvVar;


				_curatorObj spawn {
					_curatorObj = _this;
					waitUntil {
						if (isNull curatorCamera) exitWith {true};
						_curatorObj setposATL (getposATL curatorCamera);
						(isNull curatorCamera)
					};
					deleteVehicle _curatorObj;
					['perf_curator',player] call perf_fnc_srvVar;
				};
			};
		};



		if (_toCheck isEqualTo []) then {


			private _lastCheck = time - (player getVariable ['perf_lastCheck',0]);

			if (_lastCheck < 0.5) exitWith {};


			player setVariable ['perf_lastCheck',(time)];


			if !(_cachedArrNew isEqualTo []) then {
				[_cachedArrNew] call perf_fnc_srvUpC;
				_cachedArrNew = [];
				player setVariable ['perf_cachedArrNew',_cachedArrNew];
			};


			if !(_cachedArrRem isEqualTo []) then {


				[_cachedArrRem,player,true] call perf_fnc_srvUpC;
				_cachedArrRem = [];
				player setVariable ['perf_cachedArrRem',_cachedArrRem];
			};


			if !((player getVariable ['perf_dist',_dist]) isEqualTo viewDistance) then {
				['perf_dist',viewDistance,true] call perf_fnc_srvVar;
			};



			_array = _array select {!isNil "_x" && {!isNull _x}};


			player setVariable ['perf_array',_array];


			private _lastB = player getVariable ['perf_lastB',0];


			if ((time - _lastB) > 300) then {


				player setVariable ['perf_lastB',time];

				_arrayB = allMissionObjects "building";


				player setVariable ['perf_arrayB',_arrayB];
			};


			private _clusters = player getVariable ['perf_clusters',[]];




			_clusters = (_clusters - (nearestLocations [_target, ["CBA_NamespaceDummy"], (_dist2)]));


			private _nil = {

				_clusterUnits = _x getVariable ['perf_clusterUnits',[]];
				private _nil = {
					if (!isNull _x) then {
						_x call _cache;
					};
					false
				} count _clusterUnits;
				false
			} count _clusters;


			_toCheck = [];


			_toCheck append _arrayAir;


			player setVariable ['perf_toCheck',_toCheck];

		};


		if (_toCheck isEqualTo []) exitWith {

		};

		private _fastCheck = player getVariable ['perf_fastCheck',true];


		if (count _toCheck > 100 && (_fastCheck)) exitWith {

			private _toCache = [];
			_toCache append _arrayB;
			_toCache append _array;
			_toCache append _arrayAir;

			private _tooClose = [];
			private _pos = getpos _target;



			_tooClose append _arrayB;
			_tooClose append _array;
			_tooClose = (_tooClose inAreaArray [_pos,_dist2,_dist2,0,false]);



			_dist2 = (_dist2 + 750) max 3000;
			_tooClose append (_arrayAir inAreaArray [_pos,_dist2,_dist2,0,false]);

			_toCache = _toCache - _tooClose;

			private _nil = {
				_x call _cache;
				false
			} count _toCache;

			player setVariable ['perf_toCheck',[]];
		};








		private _obj = _toCheck param [0];


		_toCheck = _toCheck - [_obj];


		player setVariable ['perf_toCheck',_toCheck];


		if ((vehicle _obj) isKindOf "Air") then {
			_dist2 = ((_dist2 + 750) max 3000);
		};


		if (_obj inArea [_target,(_dist2),(_dist2),0,false]) then {
			if (_obj getVariable ['perf_cached',false]) then {
				_obj call _unCache;
			};
		} else {
			if !(_obj getVariable ['perf_cached',false]) then {
				_obj call _cache;
			};
		};
	};
};



perf_fnc_clientLooper = {

	private _loop = player getVariable ['perf_loop',nil];
	if (isNil '_loop') then {
		_loop = [] spawn {


			['perf_pause',false,true] call perf_fnc_srvVar;
			waitUntil {

				call perf_fnc_clientLoop;
				(player getVariable ['perf_stop',false])
			};


			['perf_pause',true,true] call perf_fnc_srvVar;
			player setVariable ['perf_stop',false];


			private _arrayB = player getVariable ['perf_arrayB',[]];
			private _array = player getVariable ['perf_array',[]];
			private _arrayAll = _array + _arrayB;


			private _cachedArrRem = player getVariable ['perf_cachedArrRem',[]];
			{
				if (_x getVariable ['perf_cached',false]) then {
					private _target = _x;
					_target enableSimulation true;
					_target hideObject false;
					_target setVariable ['perf_cached',false];


					private _cached = player getVariable ['perf_cachedArr',[]];
					private _cachedNew = player getVariable ['perf_cachedArrNew',[]];
					private _toCheck = player getVariable ['perf_toCheck',[]];
					_cached deleteAt (_cached find _target);
					_cachedNew deleteAt (_cachedNew find _target);
					_toCheck deleteAt (_toCheck find _target);

					_cachedArrRem pushBack _target;
				};
			} forEach _arrayAll;
			[_cachedArrRem,player,true] call perf_fnc_srvUpC;

			player setVariable ['perf_toCheck',[]];
			player setVariable ['perf_loop',nil];
		};
		player setVariable ['perf_loop',_loop];
	};


	if (true) exitWith {};




};
perf_fnc_clientUpUC = {

	params [['_newToUnCache',[]],['_target',objNull],['_remove',false]];


	if (isNull _target) exitWith {};


	if (!local _target) exitWith {
		[_newToUnCache,_target,_remove] remoteExec ['perf_fnc_clientUpUC',_target];
	};


	private _toUnCache = _target getVariable 'perf_toUnCacheNew';
	if (isNil '_toUnCache') then {
		_toUnCache = [];
		_target setVariable ['perf_toUnCacheNew',_toUnCache];
	};


	private _cachedRem = _target getVariable 'perf_toUnCacheRem';
	if (isNil '_cachedRem') then {
		_cachedRem = [];
		_target setVariable ['perf_toUnCacheRem',_cachedRem];
	};

	if (_remove) exitWith {
		_cachedRem append _newToUnCache;
	};

	_toUnCache append _newToUnCache;

	_toUnCache = _toUnCache arrayIntersect _toUnCache;

	player setVariable ['perf_toUnCacheNew',_toUnCache];
};
perf_fnc_clusterLoop = {
	call perf_fnc_updateClusters;
};
perf_fnc_clusterLooper = {

	private _loop = missionNamespace getVariable ['perf_clusterLoop',nil];
	if (isNil '_loop') then {
		_loop = [] spawn {
			waitUntil {
				call perf_fnc_clusterLoop;
				(missionNamespace getVariable ['perf_clusterStop',false])
			};
			missionNamespace setVariable ['perf_clusterStop',false];
			missionNamespace setVariable ['perf_clusterLoop',nil];
		};
		missionNamespace setVariable ['perf_clusterLoop',_loop];
	};

};
perf_fnc_srvInit = {


	private _arrayB = missionNamespace getVariable ['perf_arrayB',(allMissionObjects "Building")];
	missionNamespace setVariable ['perf_lastB',time];
	missionNamespace setVariable ['perf_arrayB',_arrayB];


	private _array = missionNamespace getVariable ['perf_array',[]];
	missionNamespace setVariable ['perf_array',_array];
	private _arrayAir = missionNamespace getVariable ['perf_arrayAir',[]];
	missionNamespace setVariable ['perf_arrayAir',_arrayAir];



	["Building", "init", {
		private _arrayB = missionNamespace getVariable 'perf_arrayB';
		if (isNil '_arrayB') then {
			_arrayB = [];
			missionNamespace setVariable ['perf_arrayB',_arrayB];
		};
		_arrayB pushBack (_this param [0])
	},true,[],true] call CBA_fnc_addClassEventHandler;
	["AllVehicles", "init", {
		private _obj = _this param [0];
		private _arrayN = "perf_array";
		if (_obj isKindOf "Air") then {
			_arrayN = "perf_arrayAir";
		};
		private _array = missionNamespace getVariable _arrayN;
		if (isNil '_array') then {
			_array = [];
			missionNamespace setVariable [_arrayN,_array];
		};
		_array pushBack _obj;
	},true,[],true] call CBA_fnc_addClassEventHandler;
};
perf_fnc_srvLoop = {


	private _players = missionNamespace getVariable ['perf_srv_playerList',[]];


	if (_players isEqualTo []) then {
		_players = allPlayers select {
			!(_x getVariable ['perf_pause',false])
		};
		missionNamespace setVariable ['perf_srv_playerList',_players];


		private _array = missionNamespace getVariable ['perf_array',[]];
		_array = _array - [objNull];
		_array = _array arrayIntersect _array;
		missionNamespace setVariable ['perf_array',_array];

		private _arrayB = missionNamespace getVariable ['perf_arrayB',[]];
		_arrayB = _arrayB - [objNull];
		_arrayB = _arrayB arrayIntersect _arrayB;
		missionNamespace setVariable ['perf_arrayB',_arrayB];

		private _arrayAir = missionNamespace getVariable ['perf_arrayAir',[]];
		_arrayAir = _arrayAir - [objNull];
		_arrayAir = _arrayAir arrayIntersect _arrayAir;
		missionNamespace setVariable ['perf_arrayAir',_arrayAir];
	};

	if (_players isEqualTo []) exitWith {};


	private _player = _players deleteAt 0;

	if (isNil '_player' || {isNull _player}) exitWith {};


	if (_player getVariable ['perf_pause',false]) exitWith {};


	private _cached = _player getVariable 'perf_cachedArrSrv';


	if (isNil '_cached') then {
		_cached = [];
		_player setVariable ['perf_cachedArrSrv',_cached];
	};

	private _cachedNew = _player getVariable ['perf_cachedArrSrvNew',[]];
	_cached append _cachedNew;
	_player setVariable ['perf_cachedArrSrvNew',[]];


	private _cachedRem = _player getVariable ['perf_cachedArrSrvRem',[]];
	_cached = _cached - _cachedRem;
	_player setVariable ['perf_cachedArrSrvRem',[]];



	_cached = _cached - [objNull];
	_player setVariable ['perf_cachedArrSrv',_cached];


	if (_cached isEqualTo []) exitWith {};


	private _distance = _player getVariable ['perf_dist',1000];



	private _arrayB = missionNamespace getVariable ['perf_arrayB',[]];
	missionNamespace setVariable ['perf_arrayB',_arrayB];


	private _oldTime = missionNamespace getVariable ['perf_lastB',0];
	if (time - _oldTime > 300) then {
		systemChat '1';
		_arrayB = allMissionObjects 'building';
		missionNamespace setVariable ['perf_arrayB',_arrayB];
		missionNamespace setVariable ['perf_lastB',time];
	};


	private _arrayAir =  missionNamespace getVariable ['perf_arrayAir',[]];


	private _checkArr = [];
	private _unCacheArr = [];
	private _curator = _player getVariable ['perf_curator',_player];

	if (isNull _curator) then {
		_curator = _player;
	};

	private _pos = getpos _curator;


	private _clusters = missionNamespace getVariable ['perf_clusters',[]];



	_distance = (_distance + (_distance/8) + 250);


	_clusters = (nearestLocations [_pos, ["CBA_NamespaceDummy"], (_distance)]);


	private _nil = {

		_clusterUnits = _x getVariable ['perf_clusterUnits',[]];
		_unCacheArr append _clusterUnits;
		false
	} count _clusters;



















	_distance = (_distance + 1000) max 3000;


	_checkArr = _cached arrayIntersect _arrayAir;


	_unCacheArr append (_checkArr inAreaArray [_pos,_distance,_distance,0,false]);


	_unCacheArr = _unCacheArr arrayIntersect _cached;

	_cached = _cached - _unCacheArr;
	_cached = _cached arrayIntersect _cached;
	_player setVariable ['perf_cachedArrSrv',_cached];


	_unCacheArr = _unCacheArr arrayIntersect _unCacheArr;


	[_unCacheArr,_player] call perf_fnc_clientUpUC;




};
perf_fnc_srvLooper = {
	if (!isServer) exitWith {};
	private _loop = missionNamespace getVariable ['perf_srvLoop',nil];
	if (isNil '_loop') then {
		_loop = [] spawn {
			waitUntil {
				call perf_fnc_srvLoop;
				(missionNamespace getVariable ['perf_srvStop',false])
			};
			missionNamespace setVariable ['perf_srvStop',false];
			missionNamespace setVariable ['perf_srvLoop',nil,true];

			{
				_x setVariable ['perf_cachedArrSrv',[]];
				_x setVariable ['perf_cachedArrSrvNew',[]];
			} forEach allPlayers;
		};
		missionNamespace setVariable ['perf_srvLoop',_loop,true];
	};

};
perf_fnc_srvUpC = {

	params [['_newCached',[]],['_target',player],['_remove',false]];



	if (!isServer) exitWith {
		[_newCached,_target,_remove] remoteExec ['perf_fnc_srvUpC',2];
	};


	private _cached = _target getVariable 'perf_cachedArrSrvNew';
	if (isNil '_cached') then {
		_cached = [];
		_target setVariable ['perf_cachedArrSrvNew',_cached];
	};


	private _cachedRem = _target getVariable 'perf_cachedArrSrvRem';
	if (isNil '_cachedRem') then {
		_cachedRem = [];
		_target setVariable ['perf_cachedArrSrvRem',_cachedRem];
	};

	if (_remove) exitWith {
		_cachedRem append _newCached;
	};

	_cached append _newCached;
};
perf_fnc_srvVar = {

	params ['_variable','_value',['_client',true]];


	if (isNil '_variable' || {!(_variable isEqualType "")}) exitWith {};

	private _target = player;
	if (isNil '_value') exitWith {
		[_target,[_variable,nil]] remoteExec ['setVariable',2];
		if (_client) then {
			player setVariable [_variable,nil];
		};
	};
	[_target,[_variable,_value]] remoteExec ['setVariable',2];
	if (_client) then {
		player setVariable [_variable,_value];
	};
};
perf_fnc_updateClusters = {

	private _namespace = [player,missionNamespace] select (isServer);





	private _arrayAll = _namespace getVariable 'perf_clusterToCheck';
	if (isNil '_arrayAll') then {
		_arrayAll = [];
		_namespace setVariable ['perf_clusterToCheck',_arrayAll];
	};


	private _usedClusters =	_namespace getVariable 'perf_clustersUsed';
	if (isNil '_usedClusters') then {
		_usedClusters = [];
		_namespace setVariable ['perf_clustersUsed',_usedClusters];
	};


	private _clusters = _namespace getVariable 'perf_clusters';
	if (isNil '_clusters') then {
		_clusters = [];
		_namespace setVariable ['perf_clusters',_clusters];
	};



	if (_arrayAll isEqualTo []) then {

		private _arrayB = _namespace getVariable ['perf_arrayB',[]];
		private _array = _namespace getVariable ['perf_array',[]];
		_arrayAll append _array;
		_arrayAll append _arrayB;


		private _emptyClusters = _clusters - _usedClusters;
		_clusters = _clusters - _emptyClusters;

		private _nil = {
			deleteLocation _x;
			false
		} count _emptyClusters;

		_usedClusters = [];
		_namespace setVariable ['perf_clustersUsed',_usedClusters];
		_namespace setVariable ['perf_clusters',_clusters];

	};








	call {
		if (_arrayAll isEqualTo []) exitWith {true};


		private _target = _arrayAll deleteAt 0;
		private _clusterPos = getpos _target;

		private _location = (nearestLocations [_clusterPos, ["CBA_NamespaceDummy"],250,_clusterPos]) param [0,nil];

		call {

			if (isNil '_location') exitWith {

				private _clusterUnits = [];

				private _distance = 250;


				_location = createLocation ['CBA_NamespaceDummy',_clusterPos,_distance,_distance];
				_location setVariable ['perf_clusterUnits',_clusterUnits];


				private _near = _arrayAll inAreaArray [_clusterPos,_distance,_distance,0,false];


				_near pushBack _target;


				if !(_near isEqualTo []) then {


					private _nil = {
						_clusterUnits pushBack _x;
						private _oldCluster = _x getVariable 'perf_objCluster';
						if (!isNil '_oldCluster') then {
							private _oldClusterUnits = _oldCluster getVariable 'perf_clusterUnits';
							if !(isNil '_oldClusterUnits') then {
								private _deleted = _oldClusterUnits deleteAt (_oldClusterUnits find _x);
							};
						};
						_x setVariable ['perf_objCluster',_location];
						_arrayAll deleteAt (_arrayAll find _x);
						false
					} count _near;
				};

				_clusters pushBack _location;


			};


			call {

				private _oldCluster = _target getVariable ['perf_objCluster',objNull];


				if (_oldCluster isEqualTo _location) exitWith {};



				private _oldClusterUnits = _oldCluster getVariable 'perf_clusterUnits';


				if !(isNil '_oldClusterUnits') then {

					private _deleted = _oldClusterUnits deleteAt (_oldClusterUnits find _target);
				};


				private _clusterUnits = _location getVariable 'perf_clusterUnits';

				if (isNil '_clusterUnits') then {
					_clusterUnits = [];
					_location setVariable ['perf_clusterUnits',_clusterUnits];
				};


				_clusterUnits pushBack _target;
				_target setVariable ['perf_objCluster',_location];

			};
		};
		_usedClusters pushBackUnique _location;
	};


	_namespace setVariable ['perf_clustersUsed',_usedClusters];
	_clusters
};




call perf_fnc_clusterLooper;

if (isServer) then {

	call perf_fnc_srvInit;
	call perf_fnc_srvLooper;
};

if (!hasInterface) exitWith {};

call perf_fnc_clientInit;
call perf_fnc_clientLooper;