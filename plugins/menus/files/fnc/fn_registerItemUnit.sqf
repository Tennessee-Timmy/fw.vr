/* ----------------------------------------------------------------------------
Function: menus_fnc_registerItemUnit

Description:
	Register or update the menus item
	WARNING!
	This script must be in scheduled environment!
	WARNING!

Parameters:
0:	_itemName		- Name to be displayed in the menu list
1:	_function		- (string) containg code to execute which will create the controls
2:	_condition		- {code} conditions
	0:	_conditionDisplay	- condition to display item
	1:	_conditionRemove	- condition to remove item
3:	_admin			- (optional) this item will be added to the admin menu instead
Returns:
	nothing
Examples:
	// Adds item only to specified unit
	[["Respawn Units","call respawn_fnc_respawnSide",[{true},{false}],true],player] spawn menus_fnc_registerItemUnit;
	// Work with multiplayer
	if (local _unit) then {
		[_itemName,_function,_conditions,_admin] call menus_fnc_registerItemUnit;
	} else {
		[_itemName,_function,_conditions,_admin] remoteExec ["menus_fnc_registerItemUnit",_unit];
	};
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_itemName","_function",["_conditions",[{true},{false}]],["_admin",false]];

// Get default / old items
private _unit_menu_items = ["unit_menu_items",[]] call seed_fnc_getVars;

// Leave only items that don't have matchign names
_unit_menu_items  = _unit_menu_items select {!((_x param [0]) isEqualTo _itemName)};

// Add the new item
_unit_menu_items pushBackUnique [_itemName,_function,_conditions,_admin];

// Save new items on profile
["unit_menu_items",_unit_menu_items] call seed_fnc_setVars;