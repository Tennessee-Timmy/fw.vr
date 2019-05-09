/* ----------------------------------------------------------------------------
Function: loot_fnc_activate

Description:
	DEPRECATED
	Activates clusters near array of positions

Parameters:
0:	_posArr			- array of positions to spawn loot in

Returns:
	nothing
Examples:
	[_pos] call loot_fnc_activate;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

params [['_posArr',[]]];
if (_posArr isEqualTo []) exitWith {};

private _clustersActive = missionNamespace getVariable ['mission_loot_clustersActive',[]];
private _nil = {
	private _pos = getPosASL _x;
	private _clustersNear = nearestLocations [_pos,['Invisible'],(50)];
	_clustersNear = _clustersNear select {
		if (
			((_x getVariable ['lootCluster_level',99]) isEqualTo 0) &&
			!(_x getVariable ['lootCluster_active',false])
		) then {
			_x call loot_fnc_spawn;
			true
		} else {
			false
		};
	};
	_clustersActive append _clustersNear;
} count _posArr;

missionNamespace setVariable ['mission_loot_clustersActive',_clustersActive];