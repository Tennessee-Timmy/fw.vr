/* ----------------------------------------------------------------------------
Function: perf_fnc_clientLoop

Description:
	client loop script
	code to run every frame/time loop runs

Parameters:
	none
Returns:
	nothing
Examples:
	call perf_fnc_clientLoop;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

// local functions
// todo
_uncache_all = {
	private _nil = {
		if (_x getVariable ['perf_cached',false]) then {
			_x call _unCache;
		};
		_cachedArrNew deleteAt (_cachedArrNew find _x);
		false
	} count _arrayAll;
	//sleep 1;
};
_cache = {
	private _target = _this;
	if (_target getVariable ['perf_cached',false]) exitWith {};
	_target hideObject true;
	_target enableSimulation false;
	_target setVariable ['perf_cached',true];

	// add to cachedNew array
	_cachedArrNew pushBack _target;
};
_unCache = {
	private _target = _this;
	if !(_target getVariable ['perf_cached',false]) exitWith {};
	_target enableSimulation true;
	_target hideObject false;
	_target setVariable ['perf_cached',false];

	// remove from cached arrays
	_cachedArr deleteAt (_cachedArr find _target);

	// todo, i think it shouldn't be deleted from there. BUt not sure
	//_cachedArrNew deleteAt (_cachedArrNew find _target);
	_toCheck deleteAt (_toCheck find _target);

	// remove from cached
	//_cachedArrRem pushBack _target;
};

// local variables
// on client
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


// from server, array of units to uncache
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

// add uncache new to uncache
_toUnCache append _toUnCacheNew;


// uncache all that need to
{
	_x call _unCache;
} forEach _toUnCache;

// delete uncache new and uncache
player setVariable ['perf_toUnCacheNew',[]];
player setVariable ['perf_toUnCache',[]];

//
private _arrayB = player getVariable ['perf_arrayB',[]];
private _array = player getVariable ['perf_array',[]];
private _arrayAir = player getVariable ['perf_arrayAir',[]];
private _arrayAll = _array + _arrayB + _arrayAir;


// call for exitWith
call {

	// if player is no longer on his body or not a curator uncache
	// todo map opened
	// if no map open && camera not on player && no curator camera, uncache all
	if ((!visibleMap) && !(positionCameraToWorld [0,0,0] inarea [player,50,50,0,false]) && {isNull curatorCamera}) exitWith {
		call _uncache_all;

		// set variable to notify the server that client paused
		['perf_pause',true] call perf_fnc_srvVar;

		// take a nap to make sure everything gets uncached
		sleep 1;
	};

	// unpause on the server
	if (player getVariable ['perf_pause',false]) then {
		['perf_pause',false] call perf_fnc_srvVar;
	};


	// initialize distance
	private _dist = player getVariable ['perf_dist',viewDistance];

	// distance 2 for quick check (1.1x normal distance)
	// 1000 + (1000/5 == 200) == 1333 (+ 300)
	private _dist2 = (_dist + (_dist/5)+250);


	// set player as target
	private _target = player;

	// if there's a curator camera, use it as target
	if (!isNull curatorCamera) then {
		_target = curatorCamera;

		private _curator = player getVariable ['perf_curator',player];
		if (_curator isEqualTo player) then {

			private _curatorObj = 'Land_HelipadEmpty_F' createVehicle [0,0,0];
			['perf_curator',_curatorObj] call perf_fnc_srvVar;

			// spawn loop for zeus pos
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


	// if there are no objects in the list, create a new list
	if (_toCheck isEqualTo []) then {

		// debug every full loop
		private _lastCheck = time - (player getVariable ['perf_lastCheck',0]);

		if (_lastCheck < 0.5) exitWith {};

		/*

		private _arrayB = player getVariable ['perf_arrayB',[]];
		private _array = player getVariable ['perf_array',[]];
		private _arrayAir = player getVariable ['perf_arrayAir',[]];
		private _arrayAll = _array + _arrayB + _arrayAir;
		systemChat (format ["Total Stuff: %2 | Cached Stuff: %3",diag_fps,(count _arrayAll),({_x getVariable ['perf_cached',false]}count _arrayAll),_lastCheck]);

		*/
		//systemChat (format ["FPS: %1 | Total Stuff: %2 | Cached Stuff: %3 | Check time: %4",diag_fps,(count _arrayAll),({_x getVariable ['perf_cached',false]}count _arrayAll),_lastCheck]);
		player setVariable ['perf_lastCheck',(time)];

		// check if the list of cached has changed
		if !(_cachedArrNew isEqualTo []) then {
			[_cachedArrNew] call perf_fnc_srvUpC;
			_cachedArrNew = [];
			player setVariable ['perf_cachedArrNew',_cachedArrNew];
		};

		// check if remove list has changed and brodcast it.
		if !(_cachedArrRem isEqualTo []) then {

			//todo test, disabled removing
			[_cachedArrRem,player,true] call perf_fnc_srvUpC;
			_cachedArrRem = [];
			player setVariable ['perf_cachedArrRem',_cachedArrRem];
		};

		// update view distance on the server
		if !((player getVariable ['perf_dist',_dist]) isEqualTo viewDistance) then {
			['perf_dist',viewDistance,true] call perf_fnc_srvVar;
		};


		// get the objects that exist from perf_array
		_array = _array select {!isNil "_x" && {!isNull _x}};

		// save the array now that it's checked for existance
		player setVariable ['perf_array',_array];

		// timed check
		private _lastB = player getVariable ['perf_lastB',0];

		// check for new buildings every 300 seconds
		if ((time - _lastB) > 300) then {

			// save new time for buildings
			player setVariable ['perf_lastB',time];

			_arrayB = allMissionObjects "building";

			// save new buildings
			player setVariable ['perf_arrayB',_arrayB];
		};

		// update clusters
		private _clusters = player getVariable ['perf_clusters',[]];
		if (isServer) then {
			_clusters = missionNamespace getVariable ['perf_clusters',[]];
		};


		// todo no update
		//private _clusters = call perf_fnc_updateClusters;
		// remove clusters that are near
		_clusters = (_clusters - (nearestLocations [_target, ["Invisible"], (_dist2)]));

		// cache the clusters that are not yet cached
		private _nil = {
			// cache all units in this cluster
			_clusterUnits = _x getVariable ['perf_clusterUnits',[]];
			private _nil = {
				if (!isNull _x) then {
					_x call _cache;
				};
				false
			} count _clusterUnits;
			false
		} count _clusters;

		// new check list
		_toCheck = [];

		// add air to check list
		_toCheck append _arrayAir;

		// update tocheck array
		player setVariable ['perf_toCheck',_toCheck];

	};

	// if there are no objects in the array, exit with sleep.
	if (_toCheck isEqualTo []) exitWith {
		//sleep 0.01;
	};

	private _fastCheck = player getVariable ['perf_fastCheck',true];
	// if there are more than 100. Do a quick inAreaArray check
	// this will quickly go through all of them
	if (count _toCheck > 100 && (_fastCheck)) exitWith {

		private _toCache = [];
		_toCache append _arrayB;
		_toCache append _array;
		_toCache append _arrayAir;

		private _tooClose = [];
		private _pos = getpos _target;

		// test
		// 1 less inAreaArray check
		_tooClose append _arrayB;
		_tooClose append _array;
		_tooClose = (_tooClose inAreaArray [_pos,_dist2,_dist2,0,false]);

		//_tooClose append (_arrayB inAreaArray [_pos,_dist2,_dist2,0,false]);
		//_tooClose append (_array inAreaArray [_pos,_dist2,_dist2,0,false]);
		_dist2 = (_dist2 + 750) max 3000;
		_tooClose append (_arrayAir inAreaArray [_pos,_dist2,_dist2,0,false]);

		_toCache = _toCache - _tooClose;

		private _nil = {
			_x call _cache;
			false
		} count _toCache;

		player setVariable ['perf_toCheck',[]];
	};

	// make distance2 80% of distance
	//_dist2 = _dist - _dist/5;

	// save distance as distance 3
	//private _dist3 = _dist;

	// get the first object
	private _obj = _toCheck param [0];

	// remove it from object array
	_toCheck = _toCheck - [_obj];

	// update tocheck array
	player setVariable ['perf_toCheck',_toCheck];

	// if object is an air vehicle, increase distance by 750 with minimum result 3000
	if ((vehicle _obj) isKindOf "Air") then {
		_dist2 = ((_dist2 + 750) max 3000);
	};

	// check if object position in polygon
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