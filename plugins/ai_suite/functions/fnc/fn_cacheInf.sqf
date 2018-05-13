params ["_cacheGroup","_cacheLead"];
_cacheLeader = leader _cacheGroup;

if (isNil "_speaker") then {
	_speaker = speaker (leader _group);
	_array set [8,_speaker];
};

_unitList = units _cacheGroup;
[_unitList,_cacheLeader] call aiMaster_fnc_depend;
_unitList pushback _cacheLeader;
reverse _unitList;
{
	if (_x isEqualTo _cacheLeader && _active && _cacheLead) then {
		[0, {_this enableSimulationGlobal false;}, _x] call CBA_fnc_globalExecute;
		[0, {_this hideObjectGlobal true;}, _x] call CBA_fnc_globalExecute;
		_x setSpeaker "NoVoice";
		_array set [5,[true,_cachedUnits]];
	};
	if (!(_x isEqualTo _cacheLeader) || !_active) then {
		_unit = _x;
		_gear = _unit call aiMaster_fnc_getGear;
		_skill = _unit call aiMaster_fnc_getSkill;
		_type = typeOf _unit;
		_pos = getposATL _unit;
		_damage = damage _unit;
		_cUnits pushBack [_gear,_pos,_damage,_skill,_type];
		_array set [6,_cUnits];
		deleteVehicle _x;
	};
} count _unitList;
deleteGroup _cacheGroup;
_array set [0,nil];
if (_useCustomLimit) then {missionNamespace setvariable [_customLimit,_customLimitNR-1]};