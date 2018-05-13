/* ----------------------------------------------------------------------------
Function: ai_ins_fnc_getNearestGroups

Description:
	finds the nearest groups

Parameters:
0:  _pos			- position or object
1:	_checkCount		- int, Only get the this amount
2:	_checkSides		- Array, sides to return
3:	_checkDist		- Float, distance from pos
4:	_checkCached	- 0, only cached. 1, only active. 2, both
5:	_checkGarrison	- 0, only garrisoned. 1, only normal. 2, both
Returns:
	array			- nearest groups
Examples:
	// Get 1 group in 1000 meter area from player that is cached(not garrisoned)
	[player,1,[east],1000,0,1] call ai_ins_fnc_getNearestGroups;


	// Get 999 groups in 1000 meter area from player of any kind
	[player,999,[west,east,resistance,civilian],1000,2,2] call ai_ins_fnc_getNearestGroups;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ['_checkPos',['_checkCount',1],['_checkSides',[east]],['_checkDist',50],['_checkCached',2],['_checkGarrison',2]];

if !(_checkPos isEqualType []) then {
	_checkPos = getposATL _checkPos;
};

private _found = [];

private _checkArr = {
	params [['_pad',objNull],'_garr'];

	// check if pad exists
	if (isNull _pad) exitWith {};

	// get pad pos
	private _pos = getpos _pad;

	if !(_side in _checkSides) exitWith {false};

	private _units = [];
	if (_garr) then {
		_units = [([_extra,"garrisonUnit",objNull] call ai_ins_fnc_findParam)];
	} else {
		private _group = [_extra,"group",grpNull] call ai_ins_fnc_findParam;
		if (_group isEqualType grpNull && {!(_group isEqualTo grpNull)}) then {
			_units = units _group;
		};
	};
	private _cached = [_extra,"cached",false] call ai_ins_fnc_findParam;
	private _cachedPos = [_extra,"cachedPos",[_pos]] call ai_ins_fnc_findParam;

	if (_cached) exitWith {
		if (_checkCached isEqualTo 1) exitWith {false};
		if ((_cachedPos inAreaArray [_checkPos,_checkDist,_checkDist,0,false]) isEqualTo []) exitWith {
			false
		};
		true
	};
	if (_checkCached isEqualTo 0) exitWith {false};
	if ((_units inAreaArray [_checkPos,_checkDist,_checkDist,0,false]) isEqualTo []) exitWith {
		false
	};
	true
};

private _groups = missionNamespace getVariable ['ai_ins_pads',[]];
private _garrison = missionNamespace getVariable ['ai_ins_gpads',[]];

if (_checkGarrison in [1,2]) then {
	/*
	_found append (_groups select {
		[_x,false] call _checkArr
	});
	*/
	_found append _groups;
};

if (_checkGarrison in [0,2]) then {
	/*
	_found append (_garrison select {
		[_x,true] call _checkArr
	});
	*/
	// selects the groups that are on the correct side and gets the ones that are inAreaArray distance
	_found append _garrison;
};

// selects the groups that are on the correct side and get the ones that are inAreaArray distance
_found = _found select {
	private _cached = [_x,"cached",false] call ai_ins_fnc_findParam;

	// return group if it's on the correct side AND
	([_x,"savedSide",east] call ai_ins_fnc_findParam) in _checkSides &&

	// if it's cached and checkcached is 0 or 2 (cachced or all) OR
	(_cached && (_checkCached in [0,2])) ||

	// if it's not cached and checkcached in 1 or 2
	(!_cached && (_checkCached in [1,2]))
};

// Only return the ones that are near enough
_found = (_found inAreaArray [_checkPos,_checkDist,_checkDist,0,false]);



_found resize (_checkCount min (count _found));
_found

/*
// for displaying the stuff for zeus
[
	(allCurators select 0),
	["\a3\ui_f\data\igui\cfg\simpleTasks\types\move_ca.paa", [1,1,1,0.5], locationPosition(nig_locations select 6), 0.5, 0.5, 0, "Cached", 1, 0.05, "TahomaB"],
	true,
	true
] call bis_fnc_addCuratorIcon;

*/