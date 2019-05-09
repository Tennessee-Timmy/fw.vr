/* ----------------------------------------------------------------------------
Function: loot_fnc_clusterActivate

Description:
	Activates lvl 0 cluster

Parameters:
0:	_cluster			- Cluster which will be activated

Returns:
	nothin
Examples:
	_cluster call loot_fnc_clusterActivate;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

params [['_cluster',objNull]];
if (isNull _cluster) exitWith {};

//systemchat str getpos _cluster;

// on activate code
_cluster call loot_fnc_onClusterActivate;


if !((_cluster getVariable ['lootCluster_level',99]) isEqualTo 0) exitWith {};
//_cluster setVariable ['lootCluster_active',true];

_cluster call loot_fnc_clusterSpawn;
