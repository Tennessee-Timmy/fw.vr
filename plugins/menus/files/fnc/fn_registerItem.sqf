/* ----------------------------------------------------------------------------
Function: menus_fnc_registerItem

Description:
	Register or updates the menus item
	Each condition must have a unique itemName (will be displayed)
	If the name matches the item will be removed and re-added instead
	"mission items" will be shared between all units
	Avoid adding mission objects from clients (will be brodcasted over network)
	This operation should be only done on the server

Parameters:
0:	_item						- Data about the menu item
	0:	_itemName				- Name to be displayed in the menu list
	1:	_function				- (code) code to run when control is selected
	2:	_condition				- {code} conditions
		0:	_conditionDisplay	- condition to display item
		1:	_conditionRemove	- condition to remove item
	3:	_admin					- (optional) this item will be added to the admin menu instead
1:	_targets					- Targets to which the item will be added to Unit, Group, Side or everyone (mission_menu_items)
Returns:
	nothing
Examples:
	// Adds item only to specified unit
	[["Respawn Units","call respawn_fnc_respawnSide",[{true},{false}],false],[player]] call menus_fnc_registerItem;
	// Adds item only to specified side
	[["Respawn Units","call respawn_fnc_respawnSide",[{true},{false}],false],[east]] call menus_fnc_registerItem;
	// Adds item to everyone (should only be done on server) (MISSION/GLOBAL ITEMS)
	[["Respawn Units","call respawn_fnc_respawnSide",[{true},{false}],false],[""]] call menus_fnc_registerItem;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_item",["_units",["empty"]]];
_item params ["_itemName","_function",["_conditions",[{true},{false}]],["_admin",false]];

// Loop through all targets
_nul = {
	// call for cheap switch (exitWith)
	call {
		// Check the typename of current target
		private _target = _x;

		// Object > player
		if (_target isEqualType objNull) exitWith {
			private _unit = _target;

			// Work with multiplayer
			if (local _unit) then {
				[_itemName,_function,_conditions,_admin] call menus_fnc_registerItemUnit;
			} else {
				[_itemName,_function,_conditions,_admin] remoteExec ["menus_fnc_registerItemUnit",_unit];
			};
		};

		// Group > players in group
		if (_target isEqualType grpNull) exitWith {
			_group = _target;
			private _nil = {
				private _unit = _x;

				// Work with multiplayer
				if (local _unit) then {
					[_itemName,_function,_conditions,_admin] call menus_fnc_registerItemUnit;
				} else {
					[_itemName,_function,_conditions,_admin] remoteExec ["menus_fnc_registerItemUnit",_unit];
				};
				false
			} count units _group;
		};

		// Side > players in side
		if (_target isEqualType sideEmpty) exitWith {
			private _side = _target;
			private _nil = {
				if ((side _x)isEqualTo _side) then {
					private _unit = _x;

					// Work with multiplayer
					if (local _unit) then {
						[_itemName,_function,_conditions,_admin] call menus_fnc_registerItemUnit;
					} else {
						[_itemName,_function,_conditions,_admin] remoteExec ["menus_fnc_registerItemUnit",_unit];
					};
				};
				false
			} count PLAYERLIST;
		};

		// Add it as mission item instead (GLOBAL/EVERYONE)

		// Get default / old items
		private _mission_menu_items = missionNamespace getVariable ["mission_menu_items",[]];

		// Leave only items that don't have matchign names
		_mission_menu_items = _mission_menu_items select {!((_x select 0) isEqualTo _itemName)};

		// Add the new item
		_mission_menu_items pushBackUnique [_itemName,_function,_conditions,_admin];

		// Publish it across the network
		missionNamespace setVariable ["mission_menu_items",_mission_menu_items,true];
	};
	false
} count _units;
