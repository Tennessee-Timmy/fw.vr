/* ----------------------------------------------------------------------------
Function: shop_fnc_moneyUpdateAll

Description:
	Updates the money for all

Parameters:
0:	_uidList		- list of User id of the money owner to update (getPlayerUID) [empty array or udnefined defaults to all players]
1:	_change			- Change in money (can be negative)
2:	_isOverride		- override the money instead of adding it

Returns:
	nothing
Examples:
	// Add 300 money to all players
	[[], 300] call shop_fnc_moneyUpdateAll;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

if (!isServer) exitWith {
	_this remoteExec ["shop_fnc_moneyUpdateAll",2];
};

params [["_uidList",[],[[]]],["_change",0,[0]],['_isOverride',false,[false]]];

// get all players if uidlist is empty
if (_uidList isEqualTo []) then {
	_uidList = missionNamespace getVariable ['mission_shop_moneyUIDList',[]];
	private _nil = {
		if (isPlayer _x) then {
			_uidList pushBackUnique (getPlayerUID _x);
		};
		false
	} count (allUnits + allDeadMen);
};

// update the money for all uids
{
	[_x, _change, _isOverride] call shop_fnc_moneyUpdate;
	false
} count _uidList;