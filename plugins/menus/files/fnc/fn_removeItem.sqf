/* ----------------------------------------------------------------------------
Function: menus_fnc_removeItem

Description:
	Removes the menus item
	based on itemname
	"mission items" will be shared between all units
	Avoid removing mission objects on clients (will be brodcasted over network)
	This operation should be only done on the server

Parameters:
0:	_item					- Data about the menu item
	0:	_itemName			- Name to be displayed in the menu list
1:	_targets				- Targets to which the item will be added to Unit, Group, Side or everyone (mission_menu_items)
Returns:
	nothing
Examples:
	// Removes item only from specified unit
	[["Respawn Units"],[player]] call menus_fnc_removeItem;
	// Removes item from specified side
	[["Respawn Units"],[east]] call menus_fnc_removeItem;
	// Removes the item from everyone (should be only done on the server)(MISSION ITEMS)
	[["Respawn Units"],[""]] call menus_fnc_removeItem;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_item",["_units",["empty"]]];
_item params ["_itemName"];
// Loop through all targets
_nul = {
	// Call for cheap switch (exitWith)
	call {
		// Check the typename of current target
		private _target = _x;

		// Object > player
		if (_target isEqualType objNull) exitWith {
			private _unit = _target;

			// remove item function for target
			[[_itemName],_unit] spawn menus_fnc_removeItemUnit;
			// [[_itemName,_function,_conditions,_admin],_unit] remoteExec ["menus_fnc_registerItemUnit",_unit];
		};

		// Group > players in group
		if (_target isEqualType grpNull) exitWith {
			_group = _target;
			_nil ={
				private _unit = _x;

				// remove item function for units in target group
				[[_itemName],_unit] spawn menus_fnc_removeItemUnit;
				false
			} count units _group;
		};

		// Side > players in side
		if (_target isEqualType sideEmpty) exitWith {
			private _side = _target;
			_nil ={
				if ((side _x)isEqualTo _side) then {
					private _unit = _x;

					// remove item from unit in target side
					[[_itemName],_unit] spawn menus_fnc_removeItemUnit;
				};
				false
			} count PLAYERLIST;
		};

		// Remove it as mission item instead (GLOBAL/EVERYONE)

		// Get default / old items
		private _mission_menu_items = missionNamespace getVariable ["mission_menu_items",[]];

		// Leave only items that don't have matchign names
		_mission_menu_items = _mission_menu_items select {!((_x select 0) isEqualTo _itemName)};

		// Publish it across the network
		missionNamespace setVariable ["mission_menu_items",_mission_menu_items,true];
	};
	false
} count _units;
