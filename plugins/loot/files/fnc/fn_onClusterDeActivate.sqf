/* ----------------------------------------------------------------------------
Function: loot_fnc_onClusterDeActivate

Description:
	onDeActivation code for clusters
	runs automatically

Parameters:
0:	_cluster			- cluster to run deActivation code on

Returns:
	nothing
Examples:
	[_cluster] call loot_fnc_onClusterDeActivate;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

params [['_cluster',objNull]];
if (isNull _cluster) exitWith {};

private _fnc = missionNamespace getVariable ['mission_loot_onClusterDeActivate',{}];

// exit if it's not a code block
if !(_fnc isEqualType {}) exitWith {};

private _clusterLvl = _cluster getVariable ['lootCluster_level',99];
private _clusterParent = _cluster getVariable ['lootCluster_parent',objNUll];
private _clusterClusters = _cluster getVariable ['lootCluster_clusters',[]];
private _clusterPosArr = _cluster getVariable ['lootCluster_posArr',[]];

_cluster call _fnc;