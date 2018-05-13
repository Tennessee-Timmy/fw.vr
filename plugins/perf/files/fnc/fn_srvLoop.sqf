/* ----------------------------------------------------------------------------
Function: perf_fnc_srvLoop

Description:
	server loop script
	code to run every frame/time loop runs

Parameters:
	none
Returns:
	nothing
Examples:
	call perf_fnc_srvLoop;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

// get list of players to check
private _players = missionNamespace getVariable ['perf_srv_playerList',[]];

// if the current list is empty, get a new list
if (_players isEqualTo []) then {

	// get the players that are not paused
	_players = (allPlayers - entities "HeadlessClient_F") select {
		!(_x getVariable ['perf_pause',false])
	};
	missionNamespace setVariable ['perf_srv_playerList',_players];

	// check how long since last array update
	private _lastUpdate = missionNamespace getVariable ['perf_lastUpdate',0];
	if ((time - _lastUpdate) > 10) then {
		missionNamespace setVariable ['perf_lastUpdate',time];

		// update arrays
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

		// update buildings with allmissionobjects if it's been more than 300 seconds
		private _oldTime = missionNamespace getVariable ['perf_lastB',0];
		if (time - _oldTime > 300) then {
			_arrayB = allMissionObjects 'building';
			missionNamespace setVariable ['perf_arrayB',_arrayB];
			missionNamespace setVariable ['perf_lastB',time];
		};
	};
};

if (_players isEqualTo []) exitWith {};

// grab player we currently work on
private _player = _players deleteAt 0;

// make sure he exists
if (isNil '_player' || {isNull _player}) exitWith {};

// check if player has stopped and make sure he's got at least 1 cached unit
if (_player getVariable ['perf_pause',false]) exitWith {};

// get cached units for this player
private _cached = _player getVariable 'perf_cachedArrSrv';

// if cached does not exists, create it and link it (allows pushback)
if (isNil '_cached') then {
	_cached = [];
	_player setVariable ['perf_cachedArrSrv',_cached];
};

// get new additions for this player and add them to the cached list
private _cachedNew = _player getVariable ['perf_cachedArrSrvNew',[]];
_cached append _cachedNew;
_player setVariable ['perf_cachedArrSrvNew',[]];

// remove units that are sent as no longer cached
private _cachedRem = _player getVariable ['perf_cachedArrSrvRem',[]];
_cached = _cached - _cachedRem;
_player setVariable ['perf_cachedArrSrvRem',[]];


// remove null array from cached and update it
// todo
_cached = _cached - [objNull];
_player setVariable ['perf_cachedArrSrv',_cached];

// exit if nothing cached (no need to check for uncaching)
if (_cached isEqualTo []) exitWith {};

// get player view distance
private _distance = _player getVariable ['perf_dist',1000];

// get all buildings
private _arrayB = missionNamespace getVariable ['perf_arrayB',[]];
missionNamespace setVariable ['perf_arrayB',_arrayB];


// get air targets
private _arrayAir =  missionNamespace getVariable ['perf_arrayAir',[]];

// get variables needed for arrays
private _checkArr = [];
private _unCacheArr = [];
private _curator = _player getVariable ['perf_curator',_player];

if (isNull _curator) then {
	_curator = _player;
};

private _pos = getpos _curator;

// update distance
// 1000 + (1000/10 == 100) == 1100 (+300)
_distance = (_distance + (_distance/8) + 250);

// get clusters that are in uncaching distance
private _clusters = (nearestLocations [_pos, ["Invisible"], (_distance)]);

// get all the units in the cluster
private _nil = {
	// add all the cluster units to checkArr
	_clusterUnits = _x getVariable ['perf_clusterUnits',[]];
	_unCacheArr append _clusterUnits;
	false
} count _clusters;


// check air
// air distance is bigger
_distance = (_distance + 1000) max 3000;

// checkarr is only cached airunits
// todo
_checkArr = _arrayAir arrayIntersect _cached;

// check if they are near enough to uncache
_unCacheArr append (_checkArr inAreaArray [_pos,_distance,_distance,0,false]);

// only have the units that are cached
// todo
_unCacheArr = _unCacheArr arrayIntersect _cached;

// update cached for _player (on server)
// remove the units that will be uncached
// todo
_cached = _cached - _unCacheArr;
//_cached = _cached arrayIntersect _cached;
_player setVariable ['perf_cachedArrSrv',_cached];

// make sure no doubles in uncache
// todo
//_unCacheArr = _unCacheArr arrayIntersect _unCacheArr;

// send the uncache array to player
[_unCacheArr,_player] call perf_fnc_clientUpUC;





// the old one
/*

// get list of players to check
private _players = missionNamespace getVariable ['perf_srv_playerList',[]];

// if the current list is empty, get a new list
if (_players isEqualTo []) then {

	// get the players that are not paused
	_players = (allPlayers - entities "HeadlessClient_F") select {
		!(_x getVariable ['perf_pause',false])
	};
	missionNamespace setVariable ['perf_srv_playerList',_players];

	// check how long since last array update
	private _lastUpdate = missionNamespace getVariable ['perf_lastUpdate',0];
	if ((time - _lastUpdate) > 10) then {
		missionNamespace setVariable ['perf_lastUpdate',time];

		// update arrays
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

		// update buildings with allmissionobjects if it's been more than 300 seconds
		private _oldTime = missionNamespace getVariable ['perf_lastB',0];
		if (time - _oldTime > 300) then {
			_arrayB = allMissionObjects 'building';
			missionNamespace setVariable ['perf_arrayB',_arrayB];
			missionNamespace setVariable ['perf_lastB',time];
		};
	};
};

if (_players isEqualTo []) exitWith {};

// grab player we currently work on
private _player = _players deleteAt 0;

// make sure he exists
if (isNil '_player' || {isNull _player}) exitWith {};

// check if player has stopped and make sure he's got at least 1 cached unit
if (_player getVariable ['perf_pause',false]) exitWith {};

// get cached units for this player
private _cached = _player getVariable 'perf_cachedArrSrv';

// if cached does not exists, create it and link it (allows pushback)
if (isNil '_cached') then {
	_cached = [];
	_player setVariable ['perf_cachedArrSrv',_cached];
};

// get new additions for this player and add them to the cached list
private _cachedNew = _player getVariable ['perf_cachedArrSrvNew',[]];
_cached append _cachedNew;
_player setVariable ['perf_cachedArrSrvNew',[]];

// remove units that are sent as no longer cached
private _cachedRem = _player getVariable ['perf_cachedArrSrvRem',[]];
_cached = _cached - _cachedRem;
_player setVariable ['perf_cachedArrSrvRem',[]];


// remove null array from cached and update it
// todo
_cached = _cached - [objNull];
_player setVariable ['perf_cachedArrSrv',_cached];

// exit if nothing cached (no need to check for uncaching)
if (_cached isEqualTo []) exitWith {};

// get player view distance
private _distance = _player getVariable ['perf_dist',1000];

// get all buildings
private _arrayB = missionNamespace getVariable ['perf_arrayB',[]];
missionNamespace setVariable ['perf_arrayB',_arrayB];


// get air targets
private _arrayAir =  missionNamespace getVariable ['perf_arrayAir',[]];

// get variables needed for arrays
private _checkArr = [];
private _unCacheArr = [];
private _curator = _player getVariable ['perf_curator',_player];

if (isNull _curator) then {
	_curator = _player;
};

private _pos = getpos _curator;

// update distance
// 1000 + (1000/10 == 100) == 1100 (+300)
_distance = (_distance + (_distance/8) + 250);

// get clusters that are in uncaching distance
private _clusters = (nearestLocations [_pos, ["Invisible"], (_distance)]);

// get all the units in the cluster
private _nil = {
	// add all the cluster units to checkArr
	_clusterUnits = _x getVariable ['perf_clusterUnits',[]];
	_unCacheArr append _clusterUnits;
	false
} count _clusters;


// check air
// air distance is bigger
_distance = (_distance + 1000) max 3000;

// checkarr is only cached airunits
// todo
_checkArr = _arrayAir arrayIntersect _cached;

// check if they are near enough to uncache
_unCacheArr append (_checkArr inAreaArray [_pos,_distance,_distance,0,false]);

// only have the units that are cached
// todo
_unCacheArr = _unCacheArr arrayIntersect _cached;

// update cached for _player (on server)
// remove the units that will be uncached
// todo
_cached = _cached - _unCacheArr;
//_cached = _cached arrayIntersect _cached;
_player setVariable ['perf_cachedArrSrv',_cached];

// make sure no doubles in uncache
// todo
//_unCacheArr = _unCacheArr arrayIntersect _unCacheArr;

// send the uncache array to player
[_unCacheArr,_player] call perf_fnc_clientUpUC;
*/