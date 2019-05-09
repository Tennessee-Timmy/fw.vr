/* ----------------------------------------------------------------------------
Function: loot_fnc_clusterSpawn

Description:
	Spawns loot in the cluster

Parameters:
0:	_cluster			- cluster to spawn loot on

Returns:
	nothing
Examples:
	call loot_fnc_clusterSpawn;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

params [['_cluster',objNull]];

if (isNull _cluster) exitWith {};

// get positions for loot
private _clusterPosArr = _cluster getVariable ['lootCluster_posArr',[]];
private _cachedArr = _cluster getVariable ['lootCluster_cachedArr',[]];
private _holderArr = _cluster getVariable ['lootCluster_holderArr',[]];
private _isEmpty = _cluster getVariable ['lootCluster_empty',false];

// exit if cluster is set as empty (resources exhausted)
if (_isEmpty) exitWith {};

// create cached loot array
if (_cachedArr isEqualTo []) then {
	_cachedArr resize (count _clusterPosArr);
	_cachedArr = _cachedArr apply {[]};
};
if (_holderArr isEqualTo []) then {
	_holderArr resize (count _clusterPosArr);
	_holderArr = _holderArr apply {objNull};
};

// loop through all positions
{
	//private _loot = ([_x,(_cachedArr select _forEachIndex)] call loot_fnc_create);

	private _loot = [_x,(_cachedArr select _forEachIndex)] call {
		params [['_pos',[]],['_lootArr',[]]];

		if (_lootArr isEqualTo []) then {
			private _lootCat = _pos param [3,'default'];


			// only put loot in 1/3 spots
			if (random 3 > 1) then {
				_lootArr = ['empty'];
			} else {
				_lootArr = [_lootCat] call loot_fnc_findLoot;
			};
		};

		

		// if no loot created exit
		if (_lootArr isEqualTo [] || (_lootArr param [0,'empty']) isEqualTo 'empty') exitWith {
			[objNull,'empty']
		};

		//private _crate = "Fort_Crate_wood" createVehicle [0,0,0]; // Land_PaperBox_01_small_closed_brown_F
		private _crate = "AmmoCrate_NoInteractive_" createVehicle [0,0,0];

		// add object to zeus
		if (isServer && hasInterface) then {
			(allCurators select 0) addCuratorEditableObjects [[_crate],false];
		};

		private _position = +_pos;
		_position resize 3;

		// set the position (and try the float fix)
		_crate setPosATL _position;
		private _posLoot = getPosASL _crate;
		_posLoot set [2,((_posLoot select 2)-((visiblePosition _crate)select 2))-0.1];
		_crate setPosASL _posLoot;

		_crate enableSimulationGlobal false;

		// set variables for the crate
		_crate setVariable ['loot_holder_lootCluster',_cluster];
		_crate setVariable ['loot_holder_lootArr',_lootArr];
		_crate setVariable ['loot_holder_lootPos',_pos];
		_crate setVariable ['loot_holder_lootIsCrate',true,true];

		[_crate,_lootArr]

	};
	_cachedArr set [_forEachIndex,(_loot select 1)];
	_holderArr set [_forEachIndex,(_loot select 0)];
} forEach _clusterPosArr;

_cluster setVariable ['lootCluster_holderArr',_holderArr];
_cluster setVariable ['lootCluster_cachedArr',_cachedArr];
_cluster setVariable ['lootCluster_posArr',_clusterPosArr];
