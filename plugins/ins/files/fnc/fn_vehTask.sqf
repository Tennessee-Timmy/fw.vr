params ["_pos","_distance","_task","_name","_classname"];
private ["_buildings","_building","_campPosition","_cache","_safeDist","_vehicle","_safePos"];
_campPosition = _pos getpos [random _distance, random 360];
_name = format["ins_vehicle_%1",_name];
_campArray = missionNamespace getVariable [_name,[]];
_buildings = [];
_safePos = [_campPosition,0, 350, 5, 0 ,0.5, 0] call BIS_fnc_findSafePos;
_safeDist = 350;
while {_safePos distance [7100,7750,300] < 100 || _safePos distance [0,0,0] < 100 || _safePos distance getmarkerPos "respawn_west" < 1000} do {
	_safeDist = _safeDist *2;
	_safePos = [_campPosition,0, _safeDist, 5, 0 ,0.5, 0] call BIS_fnc_findSafePos;
};
_safePos = [_safePos select 0,_safePos select 1, 0];
[(_safePos),(100),(100),[east,1],[false,"SAFE","LIMITED"],false,[2,2],[true,false],0.8,[true,50,false,false]] call BRM_aiMaster_fnc_aiSpawnInf;
[(_safePos),(100),(500),[east,2],[false,"SAFE","LIMITED"],true,[4,4],[true,true],0.8,[true,50,false,false]] call BRM_aiMaster_fnc_aiSpawnInf;
[(_safePos),(50),(50),[east,1],[false,"SAFE","LIMITED"],false,[1,1],[false,true],0.8,[true,50,false,false]] call BRM_aiMaster_fnc_aiSpawnInf;

_buildingPos = [_safePos,(0), 15, 3, 0 ,0.5, 0] call BIS_fnc_findSafePos;
if (_buildingPos distance [7100,7750,300] > 100 && _buildingPos distance [0,0,0] > 100) then {
	_building = "CamoNet_BLUFOR_big_F" createVehicle [_buildingPos select 0,_buildingPos select 1, 0];
	_building setDir random 360;
	_building setVectorUp (surfacenormal [_buildingPos select 0,_buildingPos select 1, 0]);
	_buildings pushBack _building;
	[([_buildingPos select 0,_buildingPos select 1, 0]),(60),(60),[east,2],[true,"SAFE","LIMITED"],false,[0,1],[false,true],0.8,[true,50,false,false]] call BRM_aiMaster_fnc_aiSpawnInf;
};

_campArray = _buildings;
missionNamespace setVariable [_name,_campArray];
if (_task) then {
	_cacheTent = selectrandom _buildings;
	_taskPos = _cacheTent modelToWorld [-0.130859,-1.37695,-2.18495];
	_vehicle = _classname createVehicle _taskPos;
	_vehicle setpos _taskPos;
	_vehicle setDir (getDir _cacheTent + 180);
	_vehicle setVectorUp (surfacenormal _taskPos);
	_cargo = [_vehicle, "blufor", [""]] spawn BRM_fnc_assignCargo;
	_vehicle
};
