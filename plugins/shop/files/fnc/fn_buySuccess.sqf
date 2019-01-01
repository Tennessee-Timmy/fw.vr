/* ----------------------------------------------------------------------------
Function: shop_fnc_buySuccess

Description:
	Runs the code for this transaction

Parameters:
0:	_id			- id of the code to execute

Returns:
	nothing
Examples:
	// remoteExec the code
	[_id] remoteExec ['shop_fnc_buySuccess',_unit];

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params [['_id',0,[0]]];

private _code = missionNamespace getVariable [('mission_shop_transaction_' + str _id + '_code'),{}];
[player] call _code;