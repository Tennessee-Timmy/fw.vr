/* ----------------------------------------------------------------------------
Function: headless_fnc_menu

Description:
	Creates the dialog in the mission menu (menus plugin)

Parameters:
	none
Returns:
	nothing
Examples:
	call headless_fnc_menu;
	call it on the zeus menu item

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
disableSerialization;

//	Get display and ctrlgroup
private _display = (findDisplay 304000);
if (_display isEqualTo displayNull) exitWith {};
private _controlGroup = _display displayCtrl 4110;

//	Define grid for use if controls are created / edited in this dialog
private _GUI_GRID_W = (safezoneW / 40);
private _GUI_GRID_H = (safezoneH / 25);
private _GUI_GRID_X = (0);
private _GUI_GRID_Y = (0);

// Create a control already defined in dialogs.hpp
private _title = ["ADMIN HEADLESS MENU",[0,0,14,1.2],true]call menus_fnc_addTitle;

private _button1 = ["Move All Units",[0.5,1.5,5,1],"false remoteExec ['headless_fnc_moveAllMission',2];",-1]call menus_fnc_addButton;
_button1 ctrlSetTooltip "Moves all the units and vehicles to the HC";

private _button2 = ["Move Everything",[0.5,3,6,1],"true call headless_fnc_moveAllMission;",-1]call menus_fnc_addButton;
_button2 ctrlSetTooltip "Moves everything to the HC, including buildings";