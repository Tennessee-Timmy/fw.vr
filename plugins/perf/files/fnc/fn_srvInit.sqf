/* ----------------------------------------------------------------------------
Function: perf_fnc_srvInit

Description:
	server init, sets up all the variables for the server

Parameters:
	none
Returns:
	nothing
Examples:
	call perf_fnc_srvInit;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

// get all buildings
private _arrayB = missionNamespace getVariable ['perf_arrayB',(allMissionObjects "Building")];
missionNamespace setVariable ['perf_lastB',time];
missionNamespace setVariable ['perf_arrayB',_arrayB];

// create array of all objects
private _array = missionNamespace getVariable ['perf_array',[]];
missionNamespace setVariable ['perf_array',_array];
private _arrayAir = missionNamespace getVariable ['perf_arrayAir',[]];
missionNamespace setVariable ['perf_arrayAir',_arrayAir];


// event handlers to add all new buildings and vehicles to arrays
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