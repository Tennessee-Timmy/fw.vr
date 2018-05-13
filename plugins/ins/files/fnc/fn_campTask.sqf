params ["_pos","_distance","_task","_content","_name"];
private ["_buildings","_building","_campPosition","_cache","_safeDist","_safePos"];
_campPosition = _pos getpos [random _distance, random 360];
_name = format["ins_camp_%1",_name];
_campArray = missionNamespace getVariable [_name,[]];
_buildings = [];
_safePos = [_campPosition,0, 350, 15, 0 ,0.5, 0] call BIS_fnc_findSafePos;
_safeDist = _distance;
while {_safePos distance [7100,7750,300] < 100 || _safePos distance [0,0,0] < 100 || _safePos distance getmarkerPos "respawn_west" < 1500} do {
	_safeDist = _safeDist *2;
	_safePos = [_campPosition,0, 350, 15, 0 ,0.5, 0] call BIS_fnc_findSafePos;
};
_safePos = [_safePos select 0,_safePos select 1, 0];
[(_safePos),(100),(100),[east,2],[false,"SAFE","LIMITED"],false,[1,1],[true,false],0.8,[true,50,false,false]] call aiMaster_fnc_aiSpawnInf;
[(_safePos),(100),(300),[east,3],[false,"SAFE","LIMITED"],true,[2,2],[true,true],0.8,[true,50,false,false]] call aiMaster_fnc_aiSpawnInf;
[(_safePos),(50),(50),[east,3],[false,"SAFE","LIMITED"],false,[2,2],[false,true],0.8,[true,50,false,false]] call aiMaster_fnc_aiSpawnInf;
for "_i" from 1 to (ceil random 3) do {
	_buildingPos = [_safePos,(0), 15, 5, 0 ,0.5, 0] call BIS_fnc_findSafePos;
	if (_buildingPos distance [7100,7750,300] > 100 && _buildingPos distance [0,0,0] > 100) then {
		_building = "Land_tent_east" createVehicle [_buildingPos select 0,_buildingPos select 1, 0];
		_building setDir random 360;
		_building setVectorUp (surfacenormal [_buildingPos select 0,_buildingPos select 1, 0]);
		_buildings pushBack _building;
		[([_buildingPos select 0,_buildingPos select 1, 0]),(60),(60),[east,2],[true,"SAFE","LIMITED"],false,[0,1],[false,true],0.8,[true,50,false,false]] call aiMaster_fnc_aiSpawnInf;
	};
};
_campArray = _buildings;
missionNamespace setVariable [_name,_campArray];
if (_task) then {
	_cacheTent = selectrandom _buildings;
	_taskPos = _cacheTent modelToWorld [0.390625,0.399414,-1.77202];
	_cache = "Box_FIA_Ammo_F" createVehicle _taskPos;
	_cache setpos _taskPos;
	_cache setDir (random 360);
	_cache setVectorUp (surfacenormal _taskPos);
	if (isNil "_content") then {
		_content = ["ins_cache"];
	};
	//_cargo = [_cache, "blufor", _content] spawn fnc_assignCargo;
	_cache
};
