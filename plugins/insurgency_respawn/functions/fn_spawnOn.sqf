private ["_close"];
_target = missionNamespace getVariable ["BRM_insurgency_respawn_selectedUnit",nil];
if (isNil "_target") exitWith {
	hint 'NO SPAWN POINT SELECTED';
};
if (side _target isEqualTo civilian) exitWith {
	_target spawn BRM_insurgency_respawn_fnc_telePort;
};
_close = false;
{
	if (!(side _x isEqualTo side player) && _x distance _target < 300) then {_close = true;};
	true
}count allUnits;
if (_close) exitWith {
	hint 'ENEMY TOO CLOSE TO SELECTED UNIT';
};
if (vehicle _target isEqualTo _target) then {
	_target spawn BRM_insurgency_respawn_fnc_telePort;
} else {
	_target spawn BRM_insurgency_respawn_fnc_telePortVehicle;
};