	/*aiSpawnVeh
	[
		[*spawn logic*,*patrol logic*],						//either a logic or an array of 2 logics
		*spawn distance*,									//number
		*patrol distance*,									//number
		[*side*,*unitArray*],								//west,east,independent,civilian, true for transport
		[*only roads*,*stance*,*speed*,*trans*],			//bool to enable only roads and behaviour in qouates // https://community.bistudio.com/wiki/setWaypointBehaviour // https://community.bistudio.com/wiki/setWaypointSpeed // tranport ( true )
		[*outer, [trans]*],									//spawn units outside of spawn area, useful for defencive missions, w/ building patrols units will search buildings around patrol logic
															//trans type, trans unit pool
		*road spawn*,										//spawn vehicles only on roads
		[*min*,*max*],										//amount of groups to spawn
		*offencive*,										//bool
		*skill*,											//0 to 1 check aiMaster_skill for more
		[*startCached*,*limit*,*disabled*],					//bool, active group limit, caching disabled
		*wave_var*											//wave
	] call fw_fnc_aiSpawnInf;
[base,300,300,[west,2,false],[true,"SAFE","LIMITED"],[false,[0,1]],true,[5,10],true,0.5,[true,10]] call fw_fnc_aiSpawnVeh;
[[opfor1,base],300,300,[east,2,true],[false,"AWARE","FULL"],[false,0],false,[5,10],true,0.5,[false,10,true]] call fw_fnc_aiSpawnVeh;
*/
params ["_pos","_dist","_distP","_units","_patrol","_outtrans","_road","_gAmount","_offensive","_skill","_cached","_wave","_customLimit"];
_outtrans params ["_out",["_trans",[0,1]]];
// _transTypes :
// 0 - diabled
// 1 - drop and go (delete)
// 2 - drop and stay (cover)
// 3 - fastrope ???
// 4 - paradrop


private _pos1 = nil;
private _pos2 = nil;
private _pos3 = objNull;
if (typeName _pos == "ARRAY") then {
	if (count _pos isEqualTo 2) then {
		_pos1 = _pos select 0;
		_pos2 = _pos select 1;
		if (typename _pos1 isequalto "OBJECT") then {
			_pos3 = _pos1;
			_pos1 = position _pos1;
		};
		if (typename _pos2 isequalto "OBJECT") then {
			_pos3 = _pos2;
			_pos2 = position _pos2;
		};
		_pos = [_pos1,_pos2,_pos3];
	} else {
		_pos1 = _pos;
		_pos = [_pos1,_pos1];
	};
} else {
	if (_pos isEqualType objNull) then {
		_pos3 = _pos;
	};
	_pos1 = position _pos;
	_pos = [_pos1,_pos1,_pos3];
};


#include "includes\vehicles.sqf"
_landPos = {[(_this select 0),(param [2, 0]), _this select 1, 5, (param [3, 0]), 0.3, 0] call BIS_fnc_findSafePos};

if (isNil "_groupsVeh")then {_groupsVeh = [];};
for "_i" from 1 to ((_gAmount select 0) + round(random((_gAmount select 1) - (_gAmount select 0)))) step 1 do {
	_unitArray = call compile format ["_%1_%2",_units select 0,_units select 1];
	_gName = createGroup (_units select 0);
	private _vehPos = nil;
	private _setPos = nil;
	private _unitPos = nil;
	private _dir = 0;
	if (_road) then {
		_unitPos = [_pos select 0,_dist,[nil, _dist] select _out] call aiMaster_fnc_landPos;
		_vehPos = [(_pos select 0),_dist] call aiMaster_fnc_roadPos;
		if (isNil "_vehPos") then {
			_vehPos = _unitPos;
			_setPos = _unitPos;
		} else {
			if (_vehPos distance [0,0,0] < 100) then {
				_setPos = _unitPos;
				_vehPos = _unitPos;
			} else {
				_setPos = position _vehPos;
			};
		};
		_vehPos2 = [_vehPos,30] call aiMaster_fnc_roadPos;
		if (isNil "_vehPos2") then {
			_dir = random 360;
		} else {
			_dir = ([_vehPos, _vehPos2] call BIS_fnc_dirTo);
		};
	};
	if (!_road) then {
		_vehPos = [_pos select 0,_dist,[nil, _dist] select _out,([1,0] select ((_units select 1) < 10))] call _landPos;
		//systemChat format ["unit = %1 | _land = %2",(_units select 1),[0,1] select ((_units select 1) < 10)];
		_setPos = _vehPos;
		_dir = random 360;
	};
	if !(isNil "_vehPos") then {
		if (_vehPos distance [0,0,0] < 100) then {
			_vehPos = _unitPos;
		};
	} else {
		_vehPos = _unitPos;
	};

	private _vehicle = nil;
	_veh = _unitArray select 0;
	// spawn trans into air
	if ((_units select 1) >= 10) then {
		_setPos = [(_setPos select 0), (_setPos select 1), 150];
		_vehicle = createVehicle [_veh, _setPos, [], 0, "FLY"];
	} else {
		_vehicle = _veh createVehicle _setPos;

	};



	_vehicle setDir _dir;
	_unitArray = _unitArray - [(_unitArray select 0)];
	aimaster_spawned_veh = aimaster_spawned_veh + 1;
	_turrets = allTurrets [_vehicle,true];
	{
		aimaster_spawned_inf = aimaster_spawned_inf + 1;
		_unit = _gName createUnit [ _x, position _vehicle, [], 20, "NONE" ];
		_unit addEventHandler ["Killed", aiMaster_fnc_onKilled];
		_unit setSkill _skill;
		_unit setskill ["aimingAccuracy",0.01];
		call {
			if (isNull (assignedDriver _vehicle)) exitWith {
				_unit moveInDriver _vehicle;
				_unit setskill ["aimingAccuracy",0.01];
			};
			if ((_vehicle emptyPositions "Gunner") > 0) exitWith {
				_unit moveInGunner _vehicle;
				_unit setskill ["aimingAccuracy",0.01];
			};
			if ((_vehicle emptyPositions "Commander") > 0) exitWith {
				_unit moveInCommander _vehicle;
				_unit setskill ["aimingAccuracy",0.01];
			};
			if (count _turrets > 0) exitWith {
				_unit moveInTurret [_vehicle,(_turrets select 0)];
				_turrets = _turrets - [ (_turrets select 0)];
				_unit setskill ["aimingAccuracy",0.01];
			};
			if ((_vehicle emptyPositions "cargo") > 0) exitWith {
				_unit moveInCargo _vehicle;
				_unit setskill ["aimingAccuracy",0.25];
			};
		};
		_unit setskill ["aimingSpeed",0.3];
		_unit setskill ["spotTime",0.7];
		_unit setskill ["spotDistance",0.8];
		_unit setskill ["Courage",0.5];
		_unit allowFleeing 0;
		true
	} count _unitArray;
	private _transGroup = nil;

	// transport
	// Add transport units
	if ((_trans select 0) > 0) then {
		_transGroup = [_vehicle,(_units select 0),(_trans select 1)] call aiMaster_fnc_aiSpawnTrans;

		// spawn trans into air
		//_airPos = [(_setPos select 0), (_setPos select 1), 150];
		//_vehicle setpos _airPos

	};





	_gName setBehaviour (_patrol select 1);
	if (!isNil "_customLimit")then {
		missionNamespace setvariable [_customLimit,(call compile _customLimit+1)];
	};
	_gVars = [
		_gName,														//Group				0
		[_pos select 1,_distP,_patrol,_out,_pos select 2],			//Patrol			1
		_cached,													//Cache				2
		[_offensive select 0,_offensive select 1, nil, nil],		//Fight				3
		if (isNil "_wave") then {nil} else {_wave},					//Wave				4
		[false,false],												//CacheActive		5
		[],															//cUnits			6
		if (isNil "_customLimit") then {nil} else {_customLimit},	//CustomLimit		7
		nil,														//Speak				8
		side _gName,												//Side				9
		_vehicle,													//vehicle			10
		nil,														//Alert				11
		[(_trans select 0)]											//transport			12
	];

	//
	// Create trans group array
	if ((_trans select 0) > 0) then {
		_transArray = [_transGroup,_gVars] call aiMaster_fnc_createTransArray;
		_gVars set [12,[(_trans select 0),_transArray]];
	};

	aiMaster_groupsVeh pushBack _gVars;
	missionNamespace setVariable ["aiMaster_groupsVeh",aiMaster_groupsVeh];
	_startCached = _cached select 0;
	if (_startCached) then {_gVars spawn aiMaster_fnc_aiCacheVeh;} else {aiMaster_activeGroupsVeh pushBack _gVars;};
};
true