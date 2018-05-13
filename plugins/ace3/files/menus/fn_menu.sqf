/* ----------------------------------------------------------------------------
Function: ace3_fnc_menu

Description:
	Creates the dialog in the mission menu (menus plugin)

Parameters:
	none
Returns:
	nothing
Examples:
	call ace3_fnc_menu;

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
private _title = ["ADMIN ACE MENU",[0,0,14,1.2],true]call menus_fnc_addTitle;

private _button1 = ["Heal myself",[0.5,1.5,6,1],"[player,player] call ACE_medical_fnc_treatmentAdvanced_fullHealLocal;",-1]call menus_fnc_addButton;
_button1 ctrlSetTooltip "You little cheat";

private _button2 = ["Heal everyone",[0.5,3,6,1],"
private _nil = {[player,_x] call ACE_medical_fnc_treatmentAdvanced_fullHeal;false} count (allPlayers - entities 'HeadlessClient_F');
",-1]call menus_fnc_addButton;
_button2 ctrlSetTooltip "heal everyone";