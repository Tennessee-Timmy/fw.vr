params ["_idc","_path"];
private ["_spawnUnit","_marker"];
_value = _idc tvValue _path;
if (_value isEqualTo -1) then {
	_spawnUnit = missionNamespace getVariable ["BRM_insurgency_respawn_selectedUnit",(insurgency_respawn_spawnList select 0)];
} else {
	_spawnUnit = insurgency_respawn_spawnList select _value;
};
_spawnUnit call BRM_insurgency_respawn_fnc_selectUnit;