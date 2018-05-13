/* ----------------------------------------------------------------------------
Function: respawn_fnc_menu

Description:
	Creates the dialog in the mission menu (menus plugin)

Parameters:
	none
Returns:
	nothing
Examples:
	call respawn_fnc_menu;
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
private _title = ["ADMIN RESPAWN MENU",[0,0,14,1.2],true]call menus_fnc_addTitle;
private _respawnButton1 = ["Respawn Everyone",[0.5,1.5,5,1],"[] call respawn_fnc_respawn",5000]call menus_fnc_addButton;
_respawnButton1 ctrlSetTooltip "Respawn Everyone";

// Respawn player list button
_dropList = [
	"Respawn Player",
	[0.5,3,5,1],
	{
		private _array = [];
		private _nil = {
			private _value = _x;
			private _name = name _value;
			private _toolTip = ('Respawn '  +  _name);
			_array pushBack [_name,_value,_toolTip];
			false
		} count ([] call respawn_fnc_getDeadArray);
		_array
	},
	{[_this] call respawn_fnc_respawn}
] call menus_fnc_dropList;
_dropList ctrlSetTooltip "Respawn Player";

// Respawn side list button
_dropList = [
	"Respawn Side",
	[0.5,4.5,5,1],
	{
		private _array = [
			["BLUFOR",west,'Respawn BLUFOR'],
			["OPFOR",east,'Respawn OPFOR'],
			["INDFOR",resistance,'Respawn Independent'],
			["CIVILIAN",civilian,'Respawn Civilians']
		];
		_array
	},
	{[_this] call respawn_fnc_respawn},
	false
] call menus_fnc_dropList;
_dropList ctrlSetTooltip "Respawn Side";