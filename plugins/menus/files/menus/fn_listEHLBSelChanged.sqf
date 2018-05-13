/* ----------------------------------------------------------------------------
Function: menus_fnc_listEHLBSelChanged

Description:
	LBSelChanged eventhandler function for dropList button

Parameters:
0:	_buttonCtrl		- Control the EH fired on
Returns:
	nothing
Examples:
	_ctrlList ctrlSetEventHandler ["LBSelChanged",{call menus_fnc_listEHLBSelChanged}];

Author:
	nigel
---------------------------------------------------------------------------- */
// code begins

// Allow to save displays and controls as variables
disableSerialization;

params ['_ctrlList','_index'];

// Get info from the list
(_ctrlList getVariable 'list_info') params ['_buttonCtrl','_selectCode'];
//_buttonCtrl ctrlShow true;

// Call and compile the code to run on selection
call compile (_ctrlList lbData _index) call _selectCode;

// Delete list (crashes game if not spawned)
[_ctrlList] spawn {ctrlDelete (_this select 0);};