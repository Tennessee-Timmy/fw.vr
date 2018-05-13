/* ----------------------------------------------------------------------------
Function: jip_fnc_menu

Description:
	Creates the dialog in the mission menu (menus plugin)

Parameters:
	none
Returns:
	nothing
Examples:
	call jip_fnc_menu;

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
private _title = ["Teleport to frinedlies",[0,0,14,1.2],true]call menus_fnc_addTitle;

private _button1 = ["Teleport to squad",[3,1.5,8,1],"[player] call jip_fnc_teleport;",-1]call menus_fnc_addButton;
_button1 ctrlSetTooltip "Teleport to your squad";

private _button2 = ["Teleport to nearest",[3,3,8,1],"[player,true] call jip_fnc_teleport;",-1]call menus_fnc_addButton;
_button2 ctrlSetTooltip "Teleport to nearest player";