/* ----------------------------------------------------------------------------
Function: perf_fnc_clientInit

Description:
	client init, sets up all the variables for the client

Parameters:
	none
Returns:
	nothing
Examples:
	call perf_fnc_clientInit;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

// get all buildings
private _arrayB = player getVariable ['perf_arrayB',(allMissionObjects "Building")];
player setVariable ['perf_arrayB',_arrayB];

// create array of all objects
private _array = player getVariable ['perf_array',[]];
player setVariable ['perf_array',_array];

// air array
private _arrayAir = player getVariable ['perf_arrayAir',[]];
player setVariable ['perf_arrayAir',_arrayAir];


// event handlers to add all new buildings and vehicles to arrays
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


// setup variables
private _dist = player getVariable ['perf_dist',viewDistance];
['perf_dist',_dist,true] call perf_fnc_srvVar;

// to stop the process
private _stop = player getVariable ['perf_stop',false];
['perf_stop',_stop,true] call perf_fnc_srvVar;

// to pause the process
private _pause = player getVariable ['perf_pause',false];
['perf_pause',_pause,true] call perf_fnc_srvVar;

// will come from server
private _toUnCache = player getVariable ['perf_toUnCache',[]];
player setVariable ['perf_toUnCache',_toUnCache];

// will be checked on server
// would be different on server until cachedNew is updated on the server
// todo think / test
private _cached = player getVariable ['perf_cachedArr',[]];
['perf_cachedArr',_cached,true] call perf_fnc_srvVar;

// checked on client to see if list updated
private _cachedOld = player getVariable ['perf_cachedArrOld',[]];
player setVariable ['perf_cachedArrOld',_cachedOld];

// sent from client to server as updated to what just got cached
private _cachedNew = player getVariable ['perf_cachedArrNew',[]];
player setVariable ['perf_cachedArrNew',_cachedNew];

private _toCache = player getVariable ['perf_toCache',[]];
player setVariable ['perf_toCache',_toCache];

// this will be removed from and added to all the time to check 1 by 1
private _toCheck = player getVariable ['perf_toCheck',[]];
player setVariable ['perf_toCheck',_toCheck];


//private _pol = player getVariable ['perf_pol',[0,0,0]];
//player setVariable ['perf_pol',_pol];
private _pol = missionNamespace getVariable ['perf_pol',[0,0,0]];
missionNamespace setVariable ['perf_pol',_pol];

// create clusters
[false] call perf_fnc_updateClusters;