/* ----------------------------------------------------------------------------
Function: shop_fnc_buy

Description:
	Buying logic and checks for clients

Parameters:
0:	_unit			- unit that will drop the item
1:	_price			- how much for the transaction to succeed
2:	_code			- Code to run when transaction succeeds

Returns:
	nothing
Examples:
	[player,300,{
		params [['_unit',objNull]];
		[player,'primary',"hgun_Pistol_heavy_02_F",[],true] call shop_fnc_buyWeapon;
	}] call shop_fnc_buy;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params [['_unit',objNull,[objNull]],['_price',300,[0]],['_code',{},[{}]]];

if (isNull _unit) exitWith {};

// see if we can make another purchase yet
private _nextBuyTime = missionNamespace getVariable ['mission_shop_nextPurchase',(CBA_Missiontime)];

// if current time is smaller than next buy time, exit
if (CBA_Missiontime < _nextBuyTime) exitWith {};

// set the time for next purchase
missionNamespace setVariable ['mission_shop_nextPurchase', CBA_Missiontime + 1];


// check if player has enough money to perform the transaction
private _uid = getPlayerUID _unit;
private _varName = ('mission_shop_' + _uid + '_money');

// get current money
private _money = missionNamespace getVariable [_varName,(missionNamespace getVariable ['mission_shop_moneyDefault',800])];

// exit if less money than the price
if (_money < _price) exitWith {};

// get transaction id
private _id = missionNamespace getVariable ['mission_shop_transaction_nextID',1];
missionNamespace setVariable ['mission_shop_transaction_nextID',(_nextId + 1)];

// save the code based on the id
missionNamespace setVariable [('mission_shop_transaction_' + str _id + '_code'),_code];

// ask server to perform the transaction
[_unit,_price,_id] remoteExec ['shop_fnc_buySrv',2];



