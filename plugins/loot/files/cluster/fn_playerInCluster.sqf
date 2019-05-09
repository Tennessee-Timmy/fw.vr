/* ----------------------------------------------------------------------------
Function: loot_fnc_playerInCluster

Description:
	DEPRICATED, now all the cluster checks done on the server
	Returns the level 0 cluster the player is in

Parameters:
	none

Returns:
	cluster object
Examples:
	call loot_fnc_playerInCluster;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

private _pos = getposASL player;

private _clustersNear = nearestLocations [_pos,['Invisible'],(50)];
_clustersNear = _clustersNear select {
	((_x getVariable ['lootCluster_level',99]) isEqualTo 0) &&
	!(_x getVariable ['lootCluster_active',false])
};

private _clusterPosArr = [];
private _clustersActive = missionNamespace getVariable ['mission_loot_clustersActive',[]];

{
	_clusterPosArr pushBack (getPosASL _x);
	_clustersActive pushBack _x;
	_x setVariable ['lootCluster_active',true];
	false
} count _clustersNear;

_clustersActive append _clustersNear;
_clustersActive = _clustersActive select {
	if (_x inArea [_pos,100,100,0,false]) then {
		true
	} else {
		_x setVariable ['lootCluster_active',false];
		false
	};
};

[_clustersPosArr] remoteExec ['loot_fnc_srvActivate',2];
missionNamespace setVariable ['mission_loot_clustersActive',_clustersActive];