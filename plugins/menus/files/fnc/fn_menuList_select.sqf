/* ----------------------------------------------------------------------------
Function: menus_fnc_listSelect

Description:
	Changes the selection for menulist
	Deletes old control group for databox
	Calls the code attached to the button
	This code is used to create the data control

Parameters:
0:	_ctrl	- Control this is called from
1:	_index	- index of list item which was selected
Returns:
	nothing
Examples:
	_this call menus_fnc_listSelect;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

_this spawn {
	disableSerialization;

	//--- Delete all controls attached to the main group (4110)
	_display = (findDisplay 304000);
	_allCtrls = allControls _display;
	_controlGroup = _display displayCtrl 4110;

	// loop through all the controls and if their ctrl parent group is 4110 (the item data display) they will be deleted
	_delete = _allCtrls select {if (ctrlParentControlsGroup _x isEqualTo _controlGroup) then {ctrlDelete _x};false};

	//--- Call the code from the button
	params ["_ctrl","_index"];
	// todo check if this works with 2 calls
	call compile (_ctrl lbData _index)
};
false