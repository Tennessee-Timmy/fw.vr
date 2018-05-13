/* ----------------------------------------------------------------------------
Function: round_fnc_loadAO

Description:
	Loads the ao buildings and stuff

Parameters:
0:	_delete					- <bool>, false to disable deleting other AOs
1:	_aoName					- <string>, ao that will be forced to create(instead of mission_round_aoName)
2:	_deleteOnly				- <bool>, true to only delete stuff

Returns:
	nothing
Examples:
	// default:
	call round_fnc_loadAO;

	// delete all AOs and reload them all:
	[true,'',true] call round_fnc_loadAO;
	private _aoList = missionNamespace getVariable ["mission_round_aoList",ROUND_SETTING_AOLIST];
	{
		private _aoName = _x param [0,''];
		[false,_aoName] call round_fnc_loadAO;
		false
	} count _aoList;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

if !(isServer) exitWith {};
params [['_delete',true],'_aoName',['_deleteOnly',false],['_onlyReplace',false]];

// only replace will reduce performance impact of the script
if (_onlyReplace) then {
	_delete = false;

};

private _ao = [];

// if delete, delte all other AOs
if (_delete) then {
	_ao = missionNamespace getVariable ["mission_round_aoList",ROUND_SETTING_AOLIST];
};

// if no ao name given, grab aoname from current aoName for this round
if (isNil '_aoName' || {!(_aoName isEqualType '')}) then {
	_aoName = missionNamespace getVariable ['mission_round_aoName',''];
};
private _varName = format ['mission_round_savedAO_%1',_aoName];

// if onlyReplace, still delete other AOs
if (_onlyReplace) then {
	_ao = ((missionNamespace getVariable ["mission_round_aoList",ROUND_SETTING_AOLIST]) select {
		!(_aoName isEqualTo (_x param [0,'']))
	});
};

// get saved stuff from the ao
private _stuff = missionNamespace getVariable [_varName,[]];

// error if no stuff loaded
if (_stuff isEqualTo []) exitWith {systemChat 'round_fnc_loadAO failed no ao to load'};

// delete all AOs:
{
	private _marker = _x param [2,'ao'];

	// loop through all terrain objects in the area and elete them
	// todo this is so fucking slow don't do this
	if (false) then {
		{
			if (!isNil '_x' && {(!isNull _x) && {(((toLower(typeOf _x)) find 'emptydet') isEqualTo -1 && !(typeOf _x isEqualTo ''))}}) then {
				hideObjectGlobal _x;
				hideObject _x;
				deleteVehicle _x;
			};
		} forEach ((nearestTerrainObjects[(getMarkerPos _marker),['CHURCH','CHAPEL','BUNKER','FORTRESS','VIEW-TOWER','LIGHTHOUSE','FUELSTATION','HOSPITAL','FENCE','WALL','BUSSTOP','TRANSMITTER','TOURISM','WATERTOWER','POWERSOLAR','POWERWIND','building','house'],5000,false]) inAreaArray _marker);
	};

	// loop through all units and vehicles in the area and delete them
	{
		if (!isNil '_x' && {(!isNull _x) && {(((toLower(typeOf _x)) find 'emptydet') isEqualTo -1)}}) then {
			deleteVehicle _x;
		};
	} forEach (
		(allDead + allUnits + vehicles) inAreaArray _marker
		/* SLOW *//*((allMissionObjects "") inAreaArray _marker) - allUnits*/
	);
	false
} count _ao;

// if only task was to delte shit, LEAVE NOW!
if (_deleteOnly) exitWith {};

private _createdCount = 0;
private _i = 0;

// iterate through all the saved objects
private _nil = {
	if (_i > 30) then {
		sleep 0.01;
		_i = 0;
	} else {
		_i = _i + 1;
	};

	private _saved = _x;
	_saved call {

		// get data for the saved object:
		params ['_obj', '_name','_class','_posASL','_VDU','_inv','_extra'];
		_inv params [['_items',[]],['_weapons',[]],['_mags',[]],['_bags',[]]];
		_extra params ['_dmg','_sim','_dam'];


		private _isNew = false;

		// check if the object does not exist
		if ((isNil '_obj') || {(isNull _obj)}) then {

			// object was not fine, so it will be re-created
			_obj = createVehicle [_class,[0,0,1000+(random 5000)],[],0,"NONE"];
			_createdCount = _createdCount + 1;
			_isNew = true;
			systemChat str _saved;
			_saved set [0,_obj];
			systemChat str _saved;
		} else {
			// object was fine, so it can still be used
		};

/*
		// this is actually not needed, because I can reload inventory anyhow
		// must have no inventory items (all objects with inventory are replaced)
		((_items isEqualTo []) && (_weapons isEqualTo []) && (_mags isEqualTo []) && (_bags isEqualTo [])) && (

			// must be still in the same area and retain

		)
*/


		//private _obj = createVehicle [_class,[0,0,1000+(random 5000)],[],0,"NONE"];

		// if object does not have simulation enabled and it was not re-created, exit
		if (!_isNew && !_sim) exitWith {};


		if !(_name isEqualTo '') then {
			_obj setVehicleVarName _name;
			missionNamespace setVariable [_name,_obj,true];
		};
		_obj setVariable ["unit_loadout_disabled",true];

		clearBackpackCargoGlobal _obj;
		clearItemCargoGlobal _obj;
		clearMagazineCargoGlobal _obj;
		clearWeaponCargoGlobal _obj;

		// inventory
		if !(_items isEqualTo []) then {
			{_obj addItemCargoGlobal [_x,1]} forEach _items;
		};
		if !(_weapons isEqualTo []) then {
			{_obj addWeaponCargoGlobal [_x,1]} forEach _weapons;
		};
		if !(_mags isEqualTo []) then {
			{_obj addMagazineCargoGlobal [_x,1]} forEach _mags;
		};
		if !(_bags isEqualTo []) then {
			{_obj addBackpackCargoGlobal [_x,1]} forEach _bags;
		};



		// if same position as before, exit immediately
		if ((_posASL isEqualTo (getPosASL _obj)) && ((_VDU isEqualTo ([vectorDir _obj,vectorUp _obj])))) exitWith {};

		// disable damage and reset damage
		_obj allowDamage false;
		//_obj enableSimulation false;
		_obj setDamage 0;

		// set positions:
		_obj setPosASL (_posASL);
		_obj setVectorDirAndUp _VDU;

		// loop to make sure position is kept and enabling simulation:
		[_obj,_sim,_posASL,_VDU,_dmg,_dam,_isNew] spawn {
			params['_obj','_sim','_posASL','_VDU','_dmg','_dam','_isNew'];
			if (_isNew) then {
				sleep (random 1);
				for '_i' from 1 to (ceil(random 3)) do {
					if (isNil '_obj' || {isNull _obj}) exitWith {};
					_obj setPosASL (_posASL);
					_obj setVectorDirAndUp _VDU;
					_obj setVelocity [0,0,0];
					sleep 1;
				};
			};
			if (isNil '_obj' || {isNull _obj}) exitWith {};
			_obj allowDamage _dmg;
			_obj setDamage _dam;
			if (missionNamespace getVariable ['mission_load_sim_disabled',false]) exitWith {};
			_obj enableSimulationGlobal _sim;
			_obj allowDamage _dmg;
			_obj enableSimulation _sim;
		};
	};
	true
} count _stuff;

systemChat (format['I just iterated through %1 objects and created %2 new objects',_nil,_createdCount]);