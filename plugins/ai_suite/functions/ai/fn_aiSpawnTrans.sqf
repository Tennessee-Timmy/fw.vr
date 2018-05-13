// [_vehicle,_side] call aiMaster_fnc_aiSpawnTrans
// spawns transported units into a vehicle
// return : group
//
params ["_vehicle","_side","_units"];

#include "includes\trans.sqf"

_usedSpots = fullCrew [_vehicle,''];
_allSpots = fullCrew [_vehicle,'',true];
_emptySpots = _allSpots - _usedSpots;
_emptySpots = (count _emptySpots);


private _transUnitList = [];

_transUnitArray = call compile format ["_%1_%2",_side,_units];
_transGroup = createGroup (_side);
_unitPos = [(_pos select 0),_dist,[nil, _dist] select _out] call aiMaster_fnc_landPos;

{
	if (_emptySpots <= (count _transUnitList)) exitWith {};
	_unit = _transGroup createUnit [ _x, _unitPos, [], 20, "NONE" ];
	_unit addEventHandler ["Killed", aiMaster_fnc_onKilled];
	_unit setSkill _skill;
	_unit setskill ["aimingAccuracy",0.3];
	_unit setskill ["aimingShake",0.5];
	_unit setskill ["aimingSpeed",0.5];
	_unit setskill ["spotDistance",0.8];
	if (_offensive select 1) then {
		_unit disableAI "AUTOCOMBAT";
	};
	_transUnitList pushBack _unit;
	//_voice = selectRandom ["Male01PER","Male02PER","Male03PER"];
	//_unit setSpeaker _voice;
	true
} count _transUnitArray;


[(units _transGroup),_vehicle] call aiMaster_fnc_loadTransIn;

_transGroup