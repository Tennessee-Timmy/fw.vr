/* ----------------------------------------------------------------------------
Function: menus_fnc_removeItemUnit

Description:
	Remove the menus item (unit must be local)
	WARNING!
	This script must be in scheduled environment!
	WARNING!

Parameters:
0:	_item			- Data about the menu item
	0:	_itemName		- Name to be displayed in the menu list
1:	_unit			- Add item to player (player setVariable)
Returns:
	nothing
Examples:
	// Adds item only to specified unit
	[["Respawn Units"],player] spawn menus_fnc_removeItemUnit;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_item","_unit"];
_item params ["_itemName"];

// Get default / old items
private _unit_menu_items = [_unit,"unit_menu_items",[]] call seed_fnc_getVarsTarget;

// Only leave items that don't match with item
_unit_menu_items = _unit_menu_items select {!((_x select 0) isEqualTo _itemName)};

// Save new items on profile
[_unit,"unit_menu_items",_unit_menu_items] call seed_fnc_setVarsTarget;



/*
menus_mission_items = missionNamespace getVariable ["menus_mission_items",[]];
menus_admin_items = missionNamespace getVariable ["menus_admin_items",[]];
*/