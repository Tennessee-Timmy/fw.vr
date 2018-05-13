// return array of enterable building objects which have min 3 positions inside
// passed params are [[pos], radius]
// usage : _avaible_buildings = [[pos], radius] call fnc_findbuildings;
params ["_center","_radius","_buildings", "_enterable"];

_buildings = _center nearObjects ["building", _radius];
{_buildings pushback _x;true}count allMissionObjects "building";
_enterable = [];
{
	if (count (_x buildingPos -1) > 0) then {
		//this both buildings are not enterable but pickedup by BIS_fnc_isBuildingEnterable
		if (typeof _x in ["Land_HouseV2_03","Land_Nasypka","Land_HouseV_1L2","Land_HouseV_1L1","Land_HouseV_1I1","Land_Misc_deerstand"] || _x distance getPos base_blu_1 < 750 || _x distance getpos base_op_1 < 750) exitWith {};
		_enterable  pushback _x;
		true
	};
}count _buildings;
_enterable