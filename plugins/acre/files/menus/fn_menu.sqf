/* ----------------------------------------------------------------------------
Function: acre_fnc_menu

Description:
	Creates the dialog in the mission menu (menus plugin)

Parameters:
	none
Returns:
	nothing
Examples:
	call acre_fnc_menu;

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
private _title = ["ACRE MENU",[0,0,14,1.2],true]call menus_fnc_addTitle;

private _button1 = ["Reset EVERYONE's Settings",[0.5,1.5,10,1],"remoteExec ['acre_fnc_setupRadios',0]",-1]call menus_fnc_addButton;
_button1 ctrlSetTooltip "Restore all radio settings for everyone";

private _button2 = ["Re-Add radios to EVERYONE",[0.5,3,10,1],"remoteExec ['acre_fnc_addRadios',0];",-1]call menus_fnc_addButton;
_button2 ctrlSetTooltip "Add default radios to everyone";

_dropList = [
	"Reset Player",
	[0.5,4.5,10,1],
	{
		private _array = [];
		private _nil = {
			private _value = _x;
			private _name = name _value;
			private _toolTip = ('Reset '  +  _name + "'s radio settings");
			_array pushBack [_name,_value,_toolTip];
			false
		} count PLAYERLIST;
		_array
	},
	{remoteExec ["acre_fnc_setupRadios",_this]}
] call menus_fnc_dropList;
_dropList ctrlSetTooltip "Reset settings for a player";

_dropList2 = [
	"Re-add Radios to Player",
	[0.5,6,10,1],
	{
		private _array = [];
		private _nil = {
			private _value = _x;
			private _name = name _value;
			private _toolTip = ('Re-add default radios to '  +  _name);
			_array pushBack [_name,_value,_toolTip];
			false
		} count PLAYERLIST;
		_array
	},
	{remoteExec ["acre_fnc_addRadios",_this]}
] call menus_fnc_dropList;
_dropList2 ctrlSetTooltip "Re-add default radios to a player";