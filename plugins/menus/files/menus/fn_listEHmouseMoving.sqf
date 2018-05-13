/* ----------------------------------------------------------------------------
Function: menus_fnc_listEHmouseMoving

Description:
	mouseMoving eventhandler function for dropList button

Parameters:
0:	_ctrlMenu		- Control the EH fired on
1:	_xPos			- Mouse position on x axis
2:	_yPos			- Mouse position on y axis
3:	_inside			- Mouse pointer is inside the control
Returns:
	nothing
Examples:
	_ctrlList ctrlSetEventHandler ["mouseMoving",{call menus_fnc_listEHmouseMoving}];

Author:
	nigel
---------------------------------------------------------------------------- */
// code begins

// Allow to save displays and controls as variables
disableSerialization;
params ["_ctrlList","_xPos","_yPos","_inside"];

// If mouse is on the control, exit
if (_inside) exitWith {};

//(_ctrlList getVariable 'menu_info') params ['_buttonCtrl'];
//_buttonCtrl ctrlShow true;

// delete the control (crashes game if not spawned)
[_ctrlList] spawn {ctrlDelete (_this select 0);};