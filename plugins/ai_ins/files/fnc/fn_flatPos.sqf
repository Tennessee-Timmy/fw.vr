/* ----------------------------------------------------------------------------
Function: ai_ins_fnc_flatPos

Description:
	finds the parameter from array

Parameters:
0:  _pos			- position
1:	_extra			- extra data
2:	_spawn			- use spawn parameters
Returns:
	value			- found value
Examples:
	[_pos,_extra] call ai_ins_fnc_flatPos;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ['_pos',['_extra',[]],['_spawn',true]];

// private variables for this scope
private '_area';
private '_areaMarker';
private '_areaTrigger';
private '_dist';
private '_perim';
private '_airPos';
private '_waterSpawn';
private '_anySpawn';
private '_gradSpawn';
private '_roadSpawn';

// check which parameter pool to use
if (_spawn) then {
	_area = [_extra,"sArea",[]] call ai_ins_fnc_findParam;
	_areaMarker = [_extra,"sAreaMarker",false] call ai_ins_fnc_findParam;
	_areaTrigger = [_extra,"sAreaTrigger",false] call ai_ins_fnc_findParam;
	_dist = [_extra,"sDist",10] call ai_ins_fnc_findParam;
	_perim = [_extra,"sPerim",false] call ai_ins_fnc_findParam;
	_airPos = [_extra,"sAir",false] call ai_ins_fnc_findParam;
	_waterSpawn = [_extra,"sWater",false] call ai_ins_fnc_findParam;
	_anySpawn = [_extra,"sAny",false] call ai_ins_fnc_findParam;
	_gradSpawn = [_extra,"sGrad",1] call ai_ins_fnc_findParam;
	_roadSpawn = [_extra,"sRoad",false] call ai_ins_fnc_findParam;
} else {
	_area = [_extra,"pArea",[]] call ai_ins_fnc_findParam;
	_areaMarker = [_extra,"pAreaMarker",false] call ai_ins_fnc_findParam;
	_areaTrigger = [_extra,"pAreaTrigger",false] call ai_ins_fnc_findParam;
	_dist = [_extra,"pDist",250] call ai_ins_fnc_findParam;
	_perim = [_extra,"pPerim",false] call ai_ins_fnc_findParam;
	_airSpawn = [_extra,"pAir",false] call ai_ins_fnc_findParam;
	_waterSpawn = [_extra,"pWater",false] call ai_ins_fnc_findParam;
	_anySpawn = [_extra,"pAny",false] call ai_ins_fnc_findParam;
	_gradSpawn = [_extra,"pGrad",1] call ai_ins_fnc_findParam;
	_roadSpawn = [_extra,"pRoad",false] call ai_ins_fnc_findParam;
};

// Determine position coordinates
private _position = call {
	if (_pos isEqualType objNull) exitWith {
		getPosATL _pos
	};
	if (_pos isEqualType "") exitWith {
		getMarkerPos _pos
	};
	if (_pos isEqualType []) exitWith {
		_pos
	};
};

// Get the spawning position
private _posArea = call {

	// Exit with the position if no area is not used
	if (!_areaMarker && {!_areaTrigger && {_area isEqualTo []}}) exitWith {
		[_position,_dist,_dist,0,false]
	};

	// If area marker, use marker
	if (_areaMarker) exitWith {_pos};

	// If area trigger, use marker
	if (_areaTrigger) exitWith {_pos};

	// Using area, use position as center and area as rest of array
	if !(_area isEqualTo []) then {
		_position = [_position];
		_position = _position + _area;
	};
	_position
};

// Determine water/land spawning
private _overLand = 0;
if (_waterSpawn) then {
	_overLand = 2;
};
if (_anySpawn) then {
	_overLand = -1;
};

// loop variables
private "_flatPos";
private '_randPos';
private _checks = 100;
private _distance = 1;

// loop until _flat pos is found
while {isNil "_flatPos"} do {
	private _flat = false;

	// if 100 checks are passed, show an error and add some distance
	if (_checks <= 0) then {
		'ai_ins_fnc_flatPos: FAILED AFTER 100 tries, increasing distance' call debug_fnc_log;
		(format ["ai_ins_fnc_flatPos: %1",_this]) call debug_fnc_log;
		_checks = 100;
		_distance = _distance + 30;
	};
	_checks = _checks - 1;

	if (_roadSpawn) then {

		// get near roads and pos of a random one
		private _roads = _randPos nearRoads (_dist + _distance);
		if !(_roads isEqualTo []) then {
			_flat = true;
			_flatPos = getPosATL(selectRandom _roads);
		};
	} else {

		// get random position in area
		_randPos =  [_posArea,_perim] call CBA_fnc_randPosArea;

		// add the extra distance from this
		_randPos = _randPos getPos [_distance,random 360];


		// check if found position is flat and quit if it is flat
		_flat = _randPos isFlatEmpty [0.5, -1, _gradSpawn, 3, _overLand, false];
		_flat = !(_flat isEqualTo []);
	};
	if (_flat) exitWith {
		_flatPos = _randPos;
	};
};

_flatPos