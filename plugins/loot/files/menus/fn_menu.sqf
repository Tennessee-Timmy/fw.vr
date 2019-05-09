/* ----------------------------------------------------------------------------
Function: loot_fnc_menu

Description:
	Creates the dialog in the mission menu (menus plugin)

Parameters:
	none
Returns:
	nothing
Examples:
	call loot_fnc_menu;
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
private _title = ["ADMIN LOOT MENU",[0,0,14,1.2],true]call menus_fnc_addTitle;
/*
private _zeusButton1 = ["Become Zeus",[0.5,1.5,5,1],"player remoteExec ['zeus_fnc_srvAdd',2];",-1]call menus_fnc_addButton;
_zeusButton1 ctrlSetTooltip "Become the almighty god ZEUS";

private _zeusButton2 = ["Check Performance",[0.5,3,6,1],"call zeus_fnc_displayPerf;",-1]call menus_fnc_addButton;
_zeusButton2 ctrlSetTooltip "Check client/server/hc performance";*/