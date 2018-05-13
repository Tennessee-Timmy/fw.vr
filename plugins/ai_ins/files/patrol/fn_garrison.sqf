/* ----------------------------------------------------------------------------
Function: ai_ins_fnc_garrison

Description:
	Garrisons the group or units in a building, the units will be teleported instantly.

Parameters:
0:	_pad			- Array to garrison
1:	_group			- group to garrison
2:	_distance		- Distance from position
3:	_size			- minimum size of house
4:	_check			- Check if there are already units in that building
5:	_houses			- How many house checks?(useful to fill a huge area)

Returns:
	array			- Array of house positions
Examples:
	[_pad,_distance,_size] call ai_ins_fnc_garrison;

Author:
	nigel
---------------------------------------------------------------------------- */
//#include "script_component.cpp"
// Code begins

params ['_pad','_group',['_distance',500],['_size',5],['_check',true],['_houses',1]];

// remove from groups
private _pads = missionNamespace getVariable 'ai_ins_pads';
if (isNil '_pads') then {
	_pads = [];
	missionNamespace setVariable ['ai_ins_pads',_pads];
};
_pads deleteAt (_pads find _pad);

// set the spawn amount to 1 (every unit will be (un)cached alone from now)
[_pad,"savedAmount",1] call ai_ins_fnc_setParam;

// get group for this garrison side
private _gGroup = missionNamespace getVariable [(format ["ai_ins_gGroup_%1",side _group]),nil];

// if group does not exist, create it and declear it.
if (isNil "_gGroup" || {isNull _gGroup}) then {
	_gGroup = createGroup (side _group);
	missionNamespace setVariable [(format ["ai_ins_gGroup_%1",side _group]),_gGroup];
};

// get garrison arrays
private _garrsion = missionNamespace getVariable 'ai_ins_gPads';
if (isNil '_garrsion') then {
	_garrsion = [];
	missionNamespace setVariable ['ai_ins_gPads',_garrsion];
};

// Check if this array already has a housepos (this means unit needs to join garrison groups)
_oldpos = [_pad,"housePos",false] call ai_ins_fnc_findParam;
_pos = [_pad,"housePos",_pos] call ai_ins_fnc_findParam;

// if pos exists, send units to garrison group
if !(_oldpos isEqualType false) exitWith {
	private _nil = {
		_x disableAI 'PATH';
		[_x] joinSilent _gGroup;
		_x setUnitPos "UP";

		// create new pad
		private _newPad = "Land_HelipadEmpty_F" createVehicle _pos;
		private _params = [_pad,_newPad] call ai_ins_fnc_copyParams;
		_garrsion pushBack _newPad;
		false
	} count (units _group);
};

// get current spawncode for this array
private _unitSpawnCode = [_pad,"unitSpawnCode",[]] call ai_ins_fnc_findParam;

// add spawncode that will put the unit into the position it was previously in
_unitSpawnCode pushBack {
	private _unit = _this param [0];
	private _extra = _this param [3];
	private _pos = [_extra,"pos",false] call ai_ins_fnc_findParam;
	_pos = [_extra,"housePos",false] call ai_ins_fnc_findParam;
	if (_pos isEqualType false) exitWith {deleteVehicle _unit};
	[_extra,"garrisonUnit",_unit] call ai_ins_fnc_setParam;
	_unit setPosATL _pos;
	_unit disableAI 'PATH';
	private _gGroup = missionNamespace getVariable [(format ["ai_ins_gGroup_%1",side _group]),nil];
	if (isNil "_gGroup" || {isNull _gGroup}) then {
		_gGroup = createGroup (side _group);
		missionNamespace setVariable [(format ["ai_ins_gGroup_%1",side _group]),_gGroup];
	};
	[_unit] joinSilent _gGroup;
	_unit setUnitPos "UP";
};
[_pad,"unitSpawnCode",_unitSpawnCode] call ai_ins_fnc_setParam;

while {!((units _group) isEqualTo [])} do {

	// current houseposition is empty
	private _housePos = [];

	// loop for as many housechecks as requested
	for "_i" from 0 to _houses do {

		// get housepositions and add them if they are new
		private _newPos = [_pos,_distance,_size,true] call ai_ins_fnc_housePos;
		{_housePos pushBackUnique _x}forEach _newPos;
	};

	// loop through all units
	private _nil = {
		// make sure there are enough positions
		if (_housePos isEqualTo []) exitWith {
			[_pad,"patrolDist",(_distance+50)] call ai_ins_fnc_setParam;
			_distance = _distance + 50;
		};

		private _usedPos = (_housePos deleteAt (floor (random (count _housePos))));

		// move every unit to a separate position
		_x setposATL _usedPos;
		_x disableAI 'PATH';
		[_x] joinSilent _gGroup;
		_x setUnitPos "UP";

		// new pad
		private _newPad = "Land_HelipadEmpty_F" createVehicle _pos;
		private _params = [_pad,_newPad] call ai_ins_fnc_copyParams;

		// save housepos and garrison unit for newpad
		[_newPad,"housePos",(getPosATL _x)] call ai_ins_fnc_setParam;
		[_newPad,"garrisonUnit",_x] call ai_ins_fnc_setParam;

		// save the new pad in garrison array
		_garrsion pushBack _newPad;
		 false
	} count (units _group);
};