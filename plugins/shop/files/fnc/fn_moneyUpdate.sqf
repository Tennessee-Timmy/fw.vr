/* ----------------------------------------------------------------------------
Function: shop_fnc_moneyUpdate

Description:
	Updates the money for a single player

Parameters:
0:	_uid			- User id of the money owner to update (getPlayerUID)
1:	_change			- Change in money (can be negative)
2:	_isOverride		- override the money instead of adding it

Returns:
	nothing
Examples:
	// Add 300 money
	[(getPlayerUID player), 300] call shop_fnc_moneyUpdate;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

if (!isServer) exitWith {
	_this remoteExec ["shop_fnc_moneyUpdate",2];
};

params [["_uid",'',['']],["_change",0,[0]],['_isOverride',false,[false]]];

// exit if invalid uid
if (_uid isEqualTo '') exitWith {};

// variable name for this player money
private _varName = ('mission_shop_' + _uid + '_money');

// get current money, or create it
private _money = missionNamespace getVariable _varName;
if (isNil '_money') then {
	_money = missionNamespace getVariable ['mission_shop_moneyDefault',800];

	// add the uid to the money list of all moneyes
	private _moneyList = missionNamespace getVariable ['mission_shop_moneyUIDList',[]];
	_moneyList pushBackUnique _uid;
	missionNamespace setVariable ['mission_shop_moneyUIDList',_moneyList];
};

if (_isOverride) then {

	// replace the moeny
	_money = _change;
} else {

	// update the money
	_money = _money + _change;
};

// make sure money is between limits
_money = _money min (missionNamespace getVariable ['mission_shop_moneyMax',16000]);
_money = _money max (missionNamespace getVariable ['mission_shop_moneyMin',0]);

//update the variable
missionNamespace setVariable [_varName,_money,true];