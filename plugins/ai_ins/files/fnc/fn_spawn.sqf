/* ----------------------------------------------------------------------------
Function: ai_ins_fnc_spawn

Description:
	Spawns units

Parameters:
0:  _target         - Target player of which units will be moved to the server
Returns:
	nothing
Examples:
	[objNull,_pos,east,10] call ai_ins_fnc_spawn;

	// using extra stuff
	// the position of variable and data must match
	// if variable does not need data, put bool
	[objNull,_pos,east,8,
		[
			['sPool',['classname']],			// custom classname pool
			['sArea',[100,100,0,false]],		// use area instead of range
			['sAreaMarker','areaMarker_01'],	// use area marker
			['sAreaTrigger',trigger_01]			// use area trigger
		]
	] call ai_ins_fnc_spawn;

Extra parameters:
// third element (public)
// will send it to all clients

//--- spawning
['sPos', [500,500,0]]						// any, any position (marker,trigger,object,pos3d)
['sDist', 100]								// int, distance for spawning units (only used if not area)
['sArea',[a,b,angle,isrectangle]			// array, based on cba_fnc_randPosArea
['sAreaMarker', true]						// bool, Use marker area
['sAreaTrigger', true]						// bool, use trigger area
['sPerim',true]								// bool, spawn on perimieter of area
['sPoolRandom', true]						// bool, random from the pool (otherwise from top to bottom)
['sPool', ['B_Soldier_SL_F']				// array, classanmes
['sVehicle', "B_MRAP_01_F"]					// str, classname of vehicle
['sInCargo', true]							// bool, spawn units in cargo of vehicle (only works if unit spawned with a vehicle)
['sAir', true]								// bool, spawn the vehicle in air
['sWater', true]							// bool, spawn the vehicle in water (false for land only)
['sAny', true]								// bool, spawn the vehicle on water or land (does not matter)
['sGrad', 0.5]								// int, spawn position gradient
['sRoad', false]							// bool, spawn on road

//--- patrol
['pDist', 100]								// int, distance for patrolling
['pPos', [500,500,0]]						// any, any position (marker,trigger,object,pos)
['housePos', [100,100,0]]					// array, pos to teleport unti to after uncaching (ATL)
['pHouse', true]							// bool, patrol houses too?
['pOnlyHouse', true]						// bool, Patrol only houses
['pHouseSize', 2]							// int, size of house that would be patrolled/garrisond
['pHouseChecks',2]							// int, how many house checks for buildings pos
['pTrans', true]							// bool, Use the vehicle as transport (get out after a few waypoints)
['pRoad', true]								// bool, Use the vehicle as transport (get out after a few waypoints)
['Garrison', true]							// bool, garrison into house (static)
['garrisonUnit',_unit]						// obj, unit that is garrisoned, this will be used to cache etc.

//--- code
['unitSpawnCode', [{},{}]]					// array, containg code that will be run when unit is spawned. PARAMS: [_unit,_group,_pos,_pad]
['groupSpawnCode', [{},{}]]					// array, containg code that will be run after all units are spawned. PARAMS: [_group,_pos,_pad]
['vehicleSpawnCode', [{},{}]]				// array, containg code that will be run when vehicle is spawned. PARAMS: [_vehicle,_side,_pos,_pad]

//--- caching
['cached', true,true]						// bool, RESERVED for caching system
['group', true,true]						// bool, RESERVED for caching system
['cachedPos',[_pos]]						// array, RESERVED for caching system
['startCached', true]						// bool, start the groups cached
['allowCaching', true]						// bool, allow stage 1 caching
['allowCaching2', true]						// bool, allow stage 2 caching
['cachingRange', [1500,1600]]				// bool, stage 1 caching range
['cachingRange2', [1200,1300]]				// bool, stage 2 caching range

['savedSide',west]							// side, used by spawning script for uncaching / saved spawning
['savedPos',_pos]							// array or obj, used by spawning script for uncaching / saved spawning
['savedAmount',5]							// int, amount of units, used by spawning script for uncaching / saved spawning


Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params [['_pad',objNull],'_pos','_side','_amount',['_extra',[]],['_return',false]];

// exit if no pad and no position
if (isNull _pad && isNil '_pos') exitWith {
	'ai_ins_fnc_spawn: MISSING POS' call debug_fnc_log;
};

// create the pad
if (isNull _pad) then {
	_pad = "Land_HelipadEmpty_F" createVehicle _pos;
};

// set extra for pad
private _nil = {
	_x params ['_n','_v',['_p',false]];
	[_pad,_n,_v,_p] call ai_ins_fnc_setParam;
	false
} count _extra;

// if sPos defined, use that and remove it(so it does not overwrite later)
private _sPos = [_pad,"sPos",[0,0,0]] call ai_ins_fnc_findParam;

// if spos is not 000 and it's not objNull, then use sPos instead of pos
if ((_sPos isEqualType [] && {!(_sPos isEqualTo [0,0,0])}) || (_sPos isEqualType objNull && {!(_sPos isEqualTo objNull)})) then {
	_pos = _sPos;
	[_pad,'sPos',nil] call ai_ins_fnc_setParam;
};

// get possible save position
//if (_pos isEqualTo [0,0,0]) then {
	_pos = [_pad,"savedPos",_pos] call ai_ins_fnc_findParam;
//};

// check to make sure pos is not 000
if (_pos isEqualTo [0,0,0]) exitWith {
	'ai_ins_fnc_spawn: MISSING POS' call debug_fnc_log;
	deleteVehicle _pad;
};

// if no side defined, get saved side, default to east if not found
if (isNil '_side') then {
	_side = [_pad,"savedSide",east] call ai_ins_fnc_findParam;
};

// save side
[_pad,"savedSide",_side] call ai_ins_fnc_setParam;

// saved amount
if (isNil '_amount') then {
	_amount = [_pad,"savedAmount",1] call ai_ins_fnc_getSetParam;
};

// set pPos to spawn pos if it's not defined
private _pPos = [_pad,"pPos",_pos] call ai_ins_fnc_getSetParam;


// if group has to start cached, don't spawn anything
private _startCached = [_pad,"startCached",false] call ai_ins_fnc_findParam;
if (_startCached) exitWith {
	[_pad,"savedAmount",_amount] call ai_ins_fnc_setParam;
	[_pad,"savedPos",_pos] call ai_ins_fnc_setParam;
	[_pad,"cached",true,true] call ai_ins_fnc_setParam;
	[_pad,"startCached",false] call ai_ins_fnc_setParam;


	// run the pad saver in unscheduled
	isNil {
		private _pads = missionNamespace getVariable ['ai_ins_pads',[]];
		if (isNil '_pads') then {
			_pads = [];
			missionNamespace setVariable ['ai_ins_pads',_pads];
		};
		_pads pushBackUnique _pad;
	};
};

// Parameters used in this function
private _airSpawn = [_pad,"sAir",false] call ai_ins_fnc_findParam;
private _pool = [_pad,"sPool",[]] call ai_ins_fnc_findParam;
private _poolRandom = [_pad,"sPoolRandom",false] call ai_ins_fnc_findParam;
private _vehicleClass = [_pad,"sVehicle",""] call ai_ins_fnc_findParam;
private _unitSpawnCode = [_pad,"unitSpawnCode",[]] call ai_ins_fnc_findParam;
private _groupSpawnCode = [_pad,"groupSpawnCode",[]] call ai_ins_fnc_findParam;
private _vehSpawnCode = [_pad,"vehSpawnCode",[]] call ai_ins_fnc_findParam;
private _spawnInCargo = [_pad,"sInCargo",false] call ai_ins_fnc_findParam;
private _cachedPos = [_pad,"cachedPos",[]] call ai_ins_fnc_findParam;
private _ai_ins_nr = [_pad,"nr",0] call ai_ins_fnc_findParam;

// unique indentifier number (debug)
if (_ai_ins_nr isEqualTo 0) then {
	_ai_ins_nr = missionNamespace getVariable ["ai_ins_nr",0];
	_ai_ins_nr = _ai_ins_nr + 1;
	missionNamespace setVariable ["ai_ins_nr",_ai_ins_nr];
	[_pad,"nr",_ai_ins_nr] call ai_ins_fnc_setParam;
};


// If custom pool is empty, use default pool
// todo loadout
if (_pool isEqualTo []) then {
	_pool = call {
		if (_side isEqualTo west) exitWith {
			[
				"B_Soldier_SL_F",
				"B_Soldier_LAT_F",
				"B_Soldier_GL_F",
				"B_Soldier_AR_F",
				"B_Soldier_TL_F",
				"B_Soldier_LAT_F",
				"B_medic_F",
				"B_Soldier_AR_F"
			]
		};
		if (_side isEqualTo east) exitWith {
			[
				"O_Soldier_SL_F",
				"O_Soldier_LAT_F",
				"O_Soldier_GL_F",
				"O_Soldier_AR_F",
				"O_Soldier_TL_F",
				"O_Soldier_LAT_F",
				"O_medic_F",
				"O_Soldier_AR_F"
			]
		};
		if (_side isEqualTo resistance) exitWith {
			[
				"I_Soldier_SL_F",
				"I_Soldier_LAT_F",
				"I_Soldier_GL_F",
				"I_Soldier_AR_F",
				"I_Soldier_TL_F",
				"I_Soldier_LAT_F",
				"I_medic_F",
				"I_Soldier_AR_F"
			]
		};
	};
};

// Check if there are too many groups on this side and exit with an error
if ({_x isEqualTo _side}count allGroups > 280) exitWith {
	format["ai_ins_fnc_spawn: TOO MANY GROUPS FOR %1",_side] call debug_fnc_log;
};


// Get random position
private _spawnPos = [_pos,_pad] call ai_ins_fnc_flatPos;

// Check to make sure spawnPos exists
if (!(_spawnPos isEqualType []) || {!(count _spawnPos isEqualTo 3)}) exitWith {
	'ai_ins_fnc_spawn: SPAWNPOS FAILURE' call debug_fnc_log;

	// if not returning group in the end, add it as cached
	// this means it will be cached until new groups are allowed
	if (!_return) then {

		// set the things as cached
		[_pad,"savedAmount",_amount] call ai_ins_fnc_setParam;
		[_pad,"savedPos",_pos] call ai_ins_fnc_setParam;
		[_pad,"cached",true] call ai_ins_fnc_setParam;
		[_pad,"startCached",false] call ai_ins_fnc_setParam;

		// run the pad saver in unscheduled
		isNil {
			private _pads = missionNamespace getVariable ['ai_ins_pads',[]];
			if (isNil '_pads') then {
				_pads = [];
				missionNamespace setVariable ['ai_ins_pads',_pads];
			};
			_pads pushBackUnique _pad;
		};
	};
};

// separate pool from the normal pool so it can be deleted from
private _poolUse = [];

// create group
private _group = createGroup _side;

// define vehicle private in this scope
private "_vehicle";

private _special = "NONE";
// Spawn vehicle
if !(_vehicleClass isEqualTo "") then {

	// Check if it shoul be spawned in air
	if (_airSpawn) then {
		_special = "AIR";
		_spawnPos set [2,200];
	};

	// Create the vehicle
	_vehicle = createVehicle [_vehicleClass,_spawnPos, [], 0, _special];

	// Run vehicle spawn codes
	if !(_vehSpawnCode isEqualTo []) then {
		private _nil = {
			[_vehicle,_side,_pos,_pad] call _x;
			false
		} count _vehSpawnCode;
	};
	_group addVehicle _vehicle;
};

// Loop for as many units in group (amount)
for '_i' from 1 to _amount do {

	// If use pool empty, get units from main pool
	// using append here so the main pool does not get edited by deleteAt
	// todo cached class pool
	if (_poolUse isEqualTo []) then {
		_poolUse append _pool;
	};

	// Delete the entry based on pool randomization
	// no randomization deletes the first element (0)
	private _class = _poolUse deleteAt ([0,(floor (random (count _poolUse)))] select _poolRandom);

	// If a vehicle was spawned change the special param to CARGO
	private _special = "NONE";

	// check if there's a car and has to spawn in cargo
	if (_spawnInCargo && {!isNil "_vehicle"}) then {
		_special = "CARGO";
	};

	// create the unit
	private _unit = _group createUnit [_class, _spawnPos, [], 3, _special];
	_unit setDir (random 360);

	// add identifyer
	_unit setVariable ['ai_ins',true];

	// setSkill
	// todo skill settings
	_unit setSkill 1;
	_unit setskill ["aimingAccuracy",0.3];
	_unit setskill ["aimingShake",0.5];
	_unit setskill ["aimingSpeed",0.5];
	_unit setskill ["spotTime",0.8];
	_unit setskill ["spotDistance",0.8];
	_unit setskill ["Courage",0.5];
	_unit allowFleeing 0;
	//_unit disableAI "AUTOCOMBAT";

	// cached position move
	if !(_cachedPos isEqualTo []) then {
		_unit setposATL (_cachedPos deleteAt 0);
	};

	// unit code
	// todo loadout?
	if !(_unitSpawnCode isEqualTo []) then {
		private _nil = {
			[_unit,_group,_pos,_pad] call _x;
			false
		} count _unitSpawnCode;
	};
	{
		[_x,[[_unit],true]] remoteExec ["addCuratorEditableObjects",2];
	} forEach allCurators;
};

// unit is spawned in, it cannot be cached (delete cache pos)
[_pad,"cachedPos",[]] call ai_ins_fnc_setParam;

// group code
if !(_groupSpawnCode isEqualTo []) then {
	private _nil = {
		[_group,_pos,_pad] call _x;
		false
	} count _groupSpawnCode;
};

// active groups
[_pad,"cached",false,true] call ai_ins_fnc_setParam;
[_pad,"group",_group] call ai_ins_fnc_setParam;


if (_return) exitWith {
	_group
};

// all groups
_group setVariable ['ai_ins_pad',_pad];
isNil {
	private _pads = missionNamespace getVariable 'ai_ins_pads';
	if (isNil '_pads') then {
		_pads = [];
		missionNamespace setVariable ['ai_ins_pads',_pads];
	};
	_pads pushBack _pad;
};


// tryout for group storing
/*
// seems slow
_logicCenter = createCenter sideLogic;
_logicGroup = createGroup _logicCenter;
_logs = [];
for '_i' from 0 to 1000 do {
	_pos = ([random 4000,random 4000,0]);
	_myLogicObject = _logicGroup createUnit ["Logic", _pos, [], 0, "NONE"];
	_logs pushBack _myLogicObject;
};
n_logs = _logs;

//

_logs = [];
for '_i' from 0 to 1000 do {
	_pos = ([random 4000,random 4000,0]);
    _veh = "Land_HelipadEmpty_F" createVehicle _pos;
    _logs pushBack _veh;
};
n_logs = _logs;
*/