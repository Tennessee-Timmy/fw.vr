/* ----------------------------------------------------------------------------
Function: loot_fnc_srvLoop

Description:
	Code to run every fromae in srvLoopAdd PFH

Parameters:
	none

Returns:
	nothing
Examples:
	call loot_fnc_srvLoop;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

#define ALIVELIST2 allUnits select {private _v = velocityModelSpace player;private _speed = ((abs(_v select 0)) + (abs (_v select 1)));isPlayer _x && (_speed < 15)}
#define ALIVELIST3 allUnits select {isPlayer _x}


// this is a temporary array so clusters can be iterated over 1 by 1
private _toCheckClusters = missionNamespace getVariable ['mission_loot_toCheckClusters',[]];

// array of all active clusters that need to be checked
private _activeClusters = missionNamespace getVariable ['mission_loot_activeClusters',[]];

// if there are no active clusters, check lvl 6 clusters
if (_activeClusters isEqualTo []) then {

	// =+ creates a deep copy, so the main clusters array will never be edited
	_activeClusters = + (missionNamespace getVariable ['mission_loot_clusters_6',[]]);
};

// if no clusters to check use active clusters
if (_toCheckClusters isEqualTo []) then {

	// deep copy active clusters to check
	_toCheckClusters = + _activeClusters;
};

// if still no clusters, exit
if (_toCheckClusters isEqualTo []) exitWith {};

// get a cluster and check it
private _cluster = _toCheckClusters deleteAt 0;

private _clusterLvl = _cluster getVariable ['lootCluster_level',99];


// get parent (if lvl 5 cluster is active, then it's parent must not be checked)
//private _parent = _cluster getVariable ['lootCluster_parent',objNull];

// lvl 0 cluster will check speed ( so you  can't fly around and activate everything etc.)
private _aliveList = if (_clusterLvl == 0) then {
	ALIVELIST2
} else {
	ALIVELIST3
};

// cluster activation check
call {

	// if cluster is already active, exit
	if (_cluster getVariable ['lootCluster_active',false]) exitWith {};

	// check if any alive players near cluster
	if ((_aliveList inAreaArray _cluster) isEqualTo []) exitWith {};

	_cluster setVariable ['lootCluster_active',true];

	// this cluster is active, make sure it's in the active cluster array
	_activeClusters pushBackUnique _cluster;

	// remove parent from active clusters
	//_activeClusters = _activeClusters - [_parent];

	// cluster level
	//private _clusterLvl = _cluster getVariable ['lootCluster_level',99];

	// if level is 0, call cluster activate, which will spawn in loot
	[_cluster] call loot_fnc_clusterActivate;

	// add the children of this cluster to the active array, so they are checked too
	private _clusters = _cluster getVariable ['lootCluster_clusters',[]];
	_activeClusters append _clusters;
	_toCheckClusters append _clusters;
};

// cluster de-activation check
call {

	// if cluster is not active don't check de-activation
	if (!(_cluster getVariable ['lootCluster_active',false])) exitWith {};

	// get children
	private _clusters = _cluster getVariable ['lootCluster_clusters',[]];

	// get array of active children
	private _childrenActive = _clusters select {
		(_x getVariable ['lootCluster_active',false])
	};

	// if there are active children, quit (can't deactive before all children are deactivated)
	if !(_childrenActive isEqualTo []) exitWith {};

	// get the size of the cluster for distance
	// size will be diameter (radius needed for inArea(array))
	// diameter of 100m will turn into 75 m radius

	// ^ is invalid.
	// 1.1 100m is 110m
	private _distance = ((size _cluster) select 0) * 1.25;

	// if near array is not empty (players present) exit
	if !((_aliveList inAreaArray [(position _cluster),_distance,_distance,0,false]) isEqualTo []) exitWith {};

	_cluster setVariable ['lootCluster_active',false];

	// add parent back to active clusters
	//_activeClusters pushBackUnique _parent;

	//private _clusterLvl = _cluster getVariable ['lootCluster_level',99];

	// only remove clusters that are not lvl 6
	//if !(_clusterLvl isEqualTo 6) then {
	//	_activeClusters = _activeClusters - [_cluster];
	//};

	// if cluster is lvl 0, deactive it's loot
	[_cluster] call loot_fnc_clusterDeActivate;

	// Remove the cluster children
	private _clusters = _cluster getVariable ['lootCluster_clusters',[]];
	_activeClusters = _activeClusters - _clusters;
	_toCheckClusters = _toCheckClusters  - _clusters;

};



// save arrays
missionNamespace setVariable ['mission_loot_activeClusters',_activeClusters];
missionNamespace setVariable ['mission_loot_toCheckClusters',_toCheckClusters];