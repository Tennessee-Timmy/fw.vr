/* ----------------------------------------------------------------------------
Function: safe_fnc_menu

Description:
	Creates the dialog in the mission menu (menus plugin)

Parameters:
	none
Returns:
	nothing
Examples:
	call safe_fnc_menu;
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
private _title = ["ADMIN SAFE MENU",[0,0,14,1.2],true]call menus_fnc_addTitle;

private _button1 = ["Disable",[0.5,1.5,5,1],"missionNamespace setVariable ['mission_safe_pause',true,true];",-1]call menus_fnc_addButton;
_button1 ctrlSetTooltip "Pauses all safezones";

private _button2 = ["Enable",[6,1.5,5,1],"missionNamespace setVariable ['mission_safe_pause',false,true];",-1]call menus_fnc_addButton;
_button2 ctrlSetTooltip "Resumes all safezones";

_dropList = [
	"Remove a zone",
	[0.5,3,5,1],
	{
		private _array = [];
		{
			private _value = _x;
			private _name = str _x;
			if (_x isEqualType true) then {
				_name = 'global';
			};
			private _toolTip = ('Remove this zone');
			_array pushBack [_name,_value,_toolTip];
			false
		} forEach (missionNamespace getVariable ['mission_safe_zones',[]]);
		_array
	},
	{
		[_this,true] call safe_fnc_addZone;
	}
] call menus_fnc_dropList;
_dropList ctrlSetTooltip "Clicking will remove the zone";

private _button3 = ["Add Global Zone",[6,3,5,1],"
	[true] call safe_fnc_addZone;
",-1]call menus_fnc_addButton;
_button3 ctrlSetTooltip "Safezone everywhere";

_dropList2 = [
	"Change timer",
	[0.5,4.5,5,1],
	{
		private _array = [];
		{
			private _value = _x;
			private _name = str _value;
			private _toolTip = (format ['Set to %1 seconds',_value]);
			_array pushBack [_name,_value,_toolTip];
			false
		} forEach [0,10,30,60,120,300,600,60000];
		_array
	},
	{
		[_this,false] call safe_fnc_setTime;
	}
] call menus_fnc_dropList;
_dropList2 ctrlSetTooltip "Needs to be >0 for safezones to work";
systemChat format ['Current safezone time: %1',(str (missionNamespace getVariable ['mission_safe_time',0]))];


//--- restriction
private _title2= ["Area restriction",[0,6,14,1.2],true]call menus_fnc_addTitle;

private _button4 = ["Disable",[0.5,7.5,5,1],"missionNamespace setVariable ['mission_safe_restrict_pause',true,true];",-1]call menus_fnc_addButton;
_button4 ctrlSetTooltip "Pauses all area restrictions";

private _button5 = ["Enable",[6,7.5,5,1],"missionNamespace setVariable ['mission_safe_restrict_pause',false,true];",-1]call menus_fnc_addButton;
_button5 ctrlSetTooltip "Resumes all area restrictions";


_dropList3 = [
	"Change timer",
	[0.5,9,5,1],
	{
		private _array = [];
		{
			private _value = _x;
			private _name = str _value;
			private _toolTip = (format ['Set to %1 seconds',_value]);
			_array pushBack [_name,_value,_toolTip];
			false
		} forEach [0,10,30,60,120,300,600,60000];
		_array
	},
	{
		[_this,true] call safe_fnc_setTime;
	},
	false
] call menus_fnc_dropList;
_dropList3 ctrlSetTooltip "Needs to be >0 for restrictions to work";
systemChat format ['Current zone restriction time: %1',(str (missionNamespace getVariable ['mission_safe_restrict_time',0]))];

// disable all



private _button6 = ["DISABLE ALL",[0.5,10.5,5,1],"remoteExec ['safe_fnc_disable'];",-1]call menus_fnc_addButton;
_button6 ctrlSetTooltip "Permenantly disables all zones";

private _button7 = ["RESTART ALL",[6,10.5,5,1],"remoteExec ['safe_fnc_enable'];",-1]call menus_fnc_addButton;
_button7 ctrlSetTooltip "Restarts all safe plugin services for clients.";