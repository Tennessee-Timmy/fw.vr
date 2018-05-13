/* ----------------------------------------------------------------------------
Function: menus_fnc_updateList

Description:
	Updates the list and checks the conditions
	Removes items that are good to remove
	Hides items that are to be removed

todo:
	Add bars?
Parameters:
	none
Returns:
	nothing
Examples:
	call menus_fnc_updateList;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// Serialization must be disabled because controls / displays are saved as variables
disableSerialization;

// Get displays and controls
private _display = (findDisplay 304000);
private _list = _display displayctrl 4104;
private _adminList = _display displayctrl 4105;

// Get list of items currently in the list
private _menu_items_current = missionNamespace getVariable ["menu_items_current",[]];

// Get all items from mission
private _mission_menu_items = missionNamespace getVariable ["mission_menu_items",[]];

// Get all items from player
private _unit_menu_items = ["unit_menu_items",[]] call seed_fnc_getVars;

// combine mission and player items
private _menu_items = _unit_menu_items + _mission_menu_items;

// Array for current items
private _menu_items_current_new = [];

// List indexes
private _listIndex = _display getVariable ["menus_listIndex",[]];

// Loop through the items
_menu_items_current_new = _menu_items select {
	private _item = _x;
	_item params ["_itemName","_function",["_conditions",[{true},{false}]],["_admin",false]];
	_conditions params [["_conditionDisplay",{true}],["_conditionRemove",{false}]];

	// Call so we can exitWith
	call {
		// check if this item already exists in the current items array
		private _existsArray = _menu_items_current select {(_x select 0) isEqualTo _itemName};
		private _itemExists = !(_existsArray isEqualTo []);

		// If _admin is true select adminlist, else mission list
		private _itemToList = [_list,_adminList] select _admin;

		// if condition to remove is true exitWith
		if (call _conditionRemove) then {

			// If item is a mission item, remove it from mission items
			if (_item in _mission_menu_items) then {
				[[_itemName],[""]] call menus_fnc_removeItem;
			};

			// If item is player item remove it from player items
			if (_item in _unit_menu_items) then {
				[[_itemName],[player]] call menus_fnc_removeItem;
			};

			// Make sure we will cease displaying the item
			_conditionDisplay = {false};
		};

		// if displaying condition is true
		if (call _conditionDisplay) then {

			// Check if item is already in item list (displayed) and exit if so
			if (_itemExists) exitWith {
				false
			};

			// Add the item to the chosen list
			private _index = _itemToList lbAdd _itemName;
			_listIndex pushBack [_index,_itemName];

			// Set the data (function for dialog) for the item we just added
			_itemToList lbSetData [_index, _function];

			true

		} else {

			// if item is not currently displayed exitwith false so it's not added to the list
			if !(_itemExists) exitWith {false};

			// Remove item from list because it exists and leave with false
			private _lbIndex = ((_listIndex select {(_x select 1) isEqualTo _itemName})select 0 select 0);

			if (isNil "_lbIndex" || {_lbIndex isEqualTo []}) exitWith {false};
			// If item is selected, change to default screen
			if ((lbCurSel _itemToList) isEqualTo _lbIndex) then {
				_allCtrls = allControls _display;
				_controlGroup = _display displayCtrl 4110;
				_delete = _allCtrls select {if (ctrlParentControlsGroup _x isEqualTo _controlGroup) then {ctrlDelete _x};false};
				[] spawn menus_fnc_menuList_default;
			};
			_listIndex = _listIndex select {!((_x select 0) isEqualTo _lbIndex)};

			_itemToList lbDelete _lbIndex;
			false
		};
	};
};
_display setVariable ["menus_listIndex",_listIndex];
_menu_items_current_new append _menu_items_current;
missionNamespace setVariable ["menu_items_current",_menu_items_current_new];