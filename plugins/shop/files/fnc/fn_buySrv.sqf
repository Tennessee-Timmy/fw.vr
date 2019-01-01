/* ----------------------------------------------------------------------------
Function: shop_fnc_buySrv

Description:
	Buying logic for srv

Parameters:
0:	_unit			- unit that will drop the item
1:	_price			- how much for the transaction to succeed
2:	_id				- transaction id

Returns:
	nothing
Examples:
	[_unit,_price,_id] remoteExec ['shop_fnc_buySrv',2];

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params [['_unit',objNull,[objNull]],['_price',300,[0]],['_id',0,[0]]];

// check if player has enough money to perform the transaction
private _uid = getPlayerUID _unit;
private _varName = ('mission_shop_' + _uid + '_money');

// get current money
private _money = missionNamespace getVariable [_varName,(missionNamespace getVariable ['mission_shop_moneyDefault',800])];

// exit if less money than the price
if (_money < _price) exitWith {};

// update money
[(_uid), -_price] call shop_fnc_moneyUpdate;

// remoteExec the code
[_id] remoteExec ['shop_fnc_buySuccess',_unit];