/* ----------------------------------------------------------------------------
Function: briefing_fnc_rosterOn

Description:
	Handles the showing of dead texts
	used in onload

Parameters:
	none
Returns:
	nothing
Examples:
	spawn briefing_fnc_rosterOn
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// Allow saving display as variable
disableSerialization;

params ["_display"];

if (_display isEqualTo displayNull) exitWith {};
// get controls
private _rosterText = (_display displayCtrl 1002);
private _group = (_display displayCtrl 1000);

//private _closeButton = ["x",[10.5,0,1,1],"(ctrlParent (_this select 0)) closeDisplay 1;",-1,_display,_group] call menus_fnc_addButton;
(_display displayCtrl 1002) ctrlEnable false;
(_display displayCtrl 1001) ctrlEnable false;
private _keyDown = (_display) displayAddEventHandler ["KeyDown", {
	call briefing_fnc_keyDown;
}];
waitUntil {
	_rosterText call briefing_fnc_rosterUpdate;

	(_display isEqualTo displayNull)
};