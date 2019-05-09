/* ----------------------------------------------------------------------------
Function: loot_fnc_clusterDeActivate

Description:
	De activates the cluster

Parameters:
0:	_cluster			- cluster to de activate

Returns:
	nothing
Examples:
	_cluster call loot_fnc_clusterDeActivate;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

params [['_cluster',objNull]];

if (isNull _cluster) exitWith {};

// onDeActivate code
_cluster call loot_fnc_onClusterDeActivate;


if !((_cluster getVariable ['lootCluster_level',99]) isEqualTo 0) exitWith {};
//if !(_cluster getVariable ['lootCluster_active',false]) exitWith {};
//_cluster setVariable ['lootCluster_active',false];


// get positions for loot
private _clusterPosArr = _cluster getVariable ['lootCluster_posArr',[]];
private _cachedArr = _cluster getVariable ['lootCluster_cachedArr',[]];
private _holderArr = _cluster getVariable ['lootCluster_holderArr',[]];

// if no holders at time of deletion, clear this cluster
if (_holderArr isEqualTo []) exitWith {
	_cluster setVariable ['lootCluster_holderArr',[]];
	_cluster setVariable ['lootCluster_cachedArr',[]];
	_cluster setVariable ['lootCluster_posArr',[]];
	_cluster setVariable ['lootCluster_empty',true];
};

// loop through all holders
{
	private _gwh = [_x] param [0,objNull];
	private _lootArr = [_gwh] call loot_fnc_save;
	_cachedArr set [_forEachIndex,(_lootArr)];
	deleteVehicle _x;	// todo this might error
} forEach _holderArr;

_cluster setVariable ['lootCluster_holderArr',[]];
_cluster setVariable ['lootCluster_cachedArr',_cachedArr];
_cluster setVariable ['lootCluster_posArr',_clusterPosArr];