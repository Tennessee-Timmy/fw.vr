_cacheGroup = _group;
_cacheLeader = leader _cacheGroup;
_cacheVehicle = assignedVehicle _cacheLeader;

if (isNil "_speaker") then {
	_speaker = speaker leader _group;
	_array set [8,_speaker];
};

//
// delete transport group if it's done transporting
_transDelete = _group getVariable ['aiMaster_cacheTrans_delete',false];
if (_transDelete) exitWith {
	{deleteVehicle _x}count units _group;
	deleteGroup _cacheGroup;
	_transType = 0;
	_vehicle setDamage [true,false];
	deleteVehicle _cacheVehicle;
};

//
// cache transport group
if (_transType > 0) then {
	_transArray call aiMaster_fnc_cacheTrans;
};


_unitList = units _cacheGroup;
[_unitList,_cacheLeader] call aiMaster_fnc_depend;
_unitList pushback _cacheLeader;
reverse _unitList;
{
	if (!(_x isEqualTo _cacheLeader) || !_active) then {
		_unit = _x;
		_gear = _unit call aiMaster_fnc_getGear;
		_skill = _unit call aiMaster_fnc_getSkill;
		_pos = getposATL _unit;
		_damage = damage _unit;
		_type = typeOf _unit;
		_cUnits pushBack [_gear,_pos,_damage,_skill,_type];
		_array set [6,_cUnits];
		deleteVehicle _x;
	};
} count _unitList;
deleteGroup _cacheGroup;
_array set [0,nil];
_pos = getposATL _cacheVehicle;
_damage = damage _cacheVehicle;
_cachedVehicle = typeOf _cacheVehicle;
_vehicleDir = direction _cacheVehicle;
_array set [10,[_cachedVehicle,_pos,_vehicleDir,_damage]];
deleteVehicle _cacheVehicle;
if (_useCustomLimit) then {missionNamespace setvariable [_customLimit,_customLimitNR-1]};