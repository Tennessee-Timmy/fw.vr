#include "script_component.cpp" //
/////////////////////////////////
/*
 * Author: LAxemann, Jokoho482
 * Tracks projectiles
 *
 */
// todo select instead of forEach
private _deleted = false;
{
	_x params [
		"_projectile",
		"_dDist",
		"_hit"
	];
	if !(alive _projectile) then {
		mission_supp_mainArray set [_forEachIndex, objNull];
		_deleted = true;
	} else {

		private _playerPos = getPosATL _projectile;
		//if (_playerPos inArea [_projectile,_dDist,_dDist,0,false,_dDist]) then {
		if ((player distance _projectile) <= _dDist) then {
			private _divisor =  OVERHEADDIVISOR;
			private _pPos = getPosATL _projectile;
			private _lis = lineIntersectsSurfaces [ATLToASL _pPos, eyePos player, player];
			if (_lis isEqualTo []) then {
				_dDist = _dDist * 0.65
			};

			//if (_playerPos inArea [_pPos,_dDist,_dDist,0,false,_dDist]) then {
			if ((_pPos distance player) <= _dDist) then {
				_divisor = IMPACTDIVISOR;
				mission_supp_lastShotAt = time;

				//if (_playerPos inArea [_pPos,4.3,4.3,0,false,4.3]) then {
				if ((_pPos distance player) <= 4.3) then {
					[] call supp_fnc_impact;
				};
			};

			if (_divisor != 0) then {
				if ((isNull objectParent player) || (isTurnedOut player)) then {
					mission_supp_threshold = (mission_supp_threshold + (_hit/_divisor)) min MAXSUPP;
				};
			};
			mission_supp_mainArray set [_forEachIndex, objNull];
            _deleted = true;
		};
	};
	nil
} forEach mission_supp_mainArray;

if (_deleted) then {
    mission_supp_mainArray = mission_supp_mainArray - [objNull];
    _deleted = false;
};