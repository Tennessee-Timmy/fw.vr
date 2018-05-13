_vehicle params ["_cachedVehicle","_vehiclePos","_vehicleDir","_vehicleDamage"];
if ((_vehiclePos select 2) > 30) then {
	_vehicle = createVehicle [_cachedVehicle, _vehiclePos, [], 0, "FLY"];
	_vehicle setvelocity [0,0,50];
} else {
	_vehicle = _cachedVehicle createVehicle _vehiclePos;
};
_vehicle setPosATL _vehiclePos;
_vehicle engineOn true;
_vehicle setDir _vehicleDir;
_vehicle setDamage _vehicleDamage;
_array set [10,_vehicle];
if (isNil "_group") then {_group = createGroup _side};
if (isNull _group) then {_group = createGroup _side};
_none = {
	_form = "NONE";
	_radius = 0;
	_x params ["_gear","_pos","_damage","_skill","_type"];
	if (_active) then {
		_form = "FORM";
		_radius = 10;
		_pos = getPos leader _group
	};
	_base = _type;
	_unit = _group createUnit [_base, [0,0,0], [], _radius, _form];
	_unit allowDamage false;
	_unit setPosATL _pos;
	if ((count units _group) isEqualTo 1) then {_group selectLeader _unit};
	_gear = [_unit,_gear] call aiMaster_fnc_setGear;
	_skill = [_unit,_skill] call aiMaster_fnc_setSkill;
	_unit setDamage _damage;
	if (_fight select 1) then {
		_unit disableAI "AUTOCOMBAT";
	};
	_unit addEventHandler ["Killed", aiMaster_fnc_onKilled];
	_unit setSpeaker _speaker;
	_turrets = allTurrets _vehicle;
	call {
		if (isNull (assignedDriver _vehicle)) exitWith {
			_unit moveInDriver _vehicle;
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
			_unit setskill ["aimingAccuracy",0.01];
			_turrets = _turrets - [(_turrets select 0)];
		};
		if ((_vehicle emptyPositions "cargo") > 0) exitWith {
			_unit moveInCargo _vehicle;
		};
	};
	_unit allowDamage true;
	true
} count _cUnits;
_array set [6,[]];
_array set [0,_group];
if (_useCustomLimit) then {missionNamespace setvariable [_customLimit,_customLimitNR+1]};

//
// unCache transport group
if (_transType > 0) then {
	[_transArray,_vehicle] call aiMaster_fnc_unCacheTrans;
};