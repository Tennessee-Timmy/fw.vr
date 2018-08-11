/* ----------------------------------------------------------------------------
Function: revive_fnc_menu

Description:
	Creates the dialog in the mission menu (menus plugin)

Parameters:
	none
Returns:
	nothing
Examples:
	call revive_fnc_menu;
	call it on the respawn menu item

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
private _title = ["REVIVE MENU",[0,0,14,1.2],true]call menus_fnc_addTitle;
private _respawnButton1 = ["Respawn",[0.5,1.5,5,1],"if (player getVariable ['unit_revive_canRespawn',false]) then {[player] call respawn_fnc_respawn} else {systemChat 'You can no longer respawn, wait for the next wave, or for someone to pick you up.'};",5000]call menus_fnc_addButton;
_respawnButton1 ctrlSetTooltip "Stop waiting for a revive and respawn right now (at the base)";
