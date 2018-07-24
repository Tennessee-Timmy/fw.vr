#include "script_component.cpp" //
/////////////////////////////////
if !(missionNamespace getVariable ['mission_supp_enabled',false]) exitWith {};
params [
	"_unit",		// Unit that shot the projectile
	"_weapon",		// Weapon fired
	"",
	"",
	"_ammo",		// Ammo shot
	"",
	"_projectile"	// The projectile (duh!)
];
if (toLower(_weapon) isEqualTo "put") exitWith {};
if (isNull _projectile) then { // Fixes a locality issue with slow projectiles. Thanks to killzone kid!
     _projectile = nearestObject [_unit, _ammo];
};
if (!(player inArea [_unit,2500,2500,0,false])) exitWith {};
//if ((player distance _unit) >= 2500) exitWith {};
if ((side effectiveCommander (vehicle _unit)) != (side player)) then {
	if ((_weapon in ["throw","put"])) exitWith {};

	private _hit = [(configFile >> "CfgAmmo" >> _ammo >> "hit"), format ['mission_supp_cached_hit_%1', _ammo]] call supp_fnc_readCacheValues;
	if (_hit == 0) exitWith {};

	private _dDist = (7 + (_hit / 2)) min 28;				// Calculate the detectionDistance (dDist)

	mission_supp_mainArray pushBack [_projectile, _dDist, _hit];
};
