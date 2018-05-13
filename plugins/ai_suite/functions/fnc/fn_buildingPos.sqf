_this params ["_loc","_dist","_house","_size"];
if (_size < 2) then {_size = 2;};
private _buildingsArray = nearestObjects [_loc, ["building"], _dist];

if (isNull _house) then {
	while {count _buildingsArray > 0} do {
		_num = floor (random (count _buildingsArray));
		_ent = [_buildingsArray select _num , _size] call BIS_fnc_isBuildingEnterable;
		if (((count _buildingsArray < 3 && _ent)  || (_ent && !((_buildingsArray select _num) in aiMaster_patrolHouses))) && !(typeof (_buildingsArray select _num) in ["Land_HouseV2_03","Land_Nasypka","Land_HouseV_1L2","Land_HouseV_1L1","Land_HouseV_1I1"])) exitWith {_house = _buildingsArray select _num};
		[_buildingsArray,(_buildingsArray select _num)] call aiMaster_fnc_depend;
	};
};
if (isNil "_house") exitWith {nil};
_buildingPos = _house call BIS_fnc_buildingPositions;
if (count _buildingsArray > 1) then {
	aiMaster_patrolHouses = aiMaster_patrolHouses + [_house];
};
[(_buildingPos), _house]