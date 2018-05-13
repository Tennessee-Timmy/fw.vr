params ["_transGroup","_transPatrol","_transCached","_transFight","_transWave","_transCachedActive","_transCUnits","_transCustomLimit","_transSpeaker","_transSide","_transBuildingPatrol","_transAlert"];

private _transArray = _this;
_transCacheLeader = leader _transGroup;

if (isNil "_transSpeaker") then {
	_transSpeaker = speaker (leader _transGroup);
	_transArray set [8,_transSpeaker];
};


_transUnitList = units _transGroup;
[_transUnitList,_transCacheLeader] call aiMaster_fnc_depend;
_transUnitList pushback _transCacheLeader;
reverse _transUnitList;
{
		_unit = _x;
		_gear = _unit call aiMaster_fnc_getGear;
		_skill = _unit call aiMaster_fnc_getSkill;
		_type = typeOf _unit;
		_pos = getposATL _unit;
		_damage = damage _unit;
		_transCUnits pushBack [_gear,_pos,_damage,_skill,_type];
		_transArray set [6,_transCUnits];
		deleteVehicle _x;
} count _transUnitList;
deleteGroup _transGroup;
_transArray set [0,nil];

