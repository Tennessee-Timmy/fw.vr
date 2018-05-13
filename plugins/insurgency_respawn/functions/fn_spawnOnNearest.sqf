private ["_close","_spawnableList","_closestDistance","_closest","_unit"];
_closestDistance = 100000;
_list = missionNamespace getVariable ["insurgency_respawn_spawnList",nil];
_spawnableList = [];
if (isNil "_list") exitWith {hint 'NO SPAWN POINTS DETECTED';};
reverse _list;

{
	_close = false;
	_unit = _x;
	{
		if (!(side _x isEqualTo side player) && _x distance _unit < 300) then {
			_close = true;
		};
		true
	}count allUnits;
	if (!_close && side _x isEqualTo side player) then {
		_spawnableList pushBackUnique _x;
	};
	true
} count _list;
if (count _spawnableList isEqualTo 0) exitWith {hint 'NO SPAWN POINTS DETECTED';};
_closest = [player, _spawnableList] call BRM_insurgency_respawn_fnc_findNearest;

if (vehicle _closest isEqualTo _closest) then {
	_closest spawn BRM_insurgency_respawn_fnc_telePort;
} else {
	_closest spawn BRM_insurgency_respawn_fnc_telePortVehicle;
};