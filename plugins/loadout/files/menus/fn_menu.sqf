/* ----------------------------------------------------------------------------
Function: loadout_fnc_menu

Description:
	Creates the dialog in the mission menu (menus plugin)

Parameters:
	none
Returns:
	nothing
Examples:
	call loadout_fnc_menu;

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
private _title = ["LOADOUT MENU",[0,0,14,1.2],true]call menus_fnc_addTitle;

missionNamespace setVariable ["loadout_menu_selectedPlayer",nil];
missionNamespace setVariable ["loadout_menu_selectedSide",nil];

private _dropList1 = [
	"Choose player to edit",
	[0.5,1.5,10.5,1],
	{
		private _array = [];
		private _nil = {
			private _value = _x;
			private _name = name _value;
			private _toolTip = ('Edit '  +  _name + "'s loadout");
			_array pushBack [_name,[_value,_name],_toolTip];
			false
		} count PLAYERLIST;
		_array
	},
	{
		missionNamespace setVariable ["loadout_menu_selectedPlayer",(_this select 0)];
		ctrlSetText [6001, (_this select 1)];
		ctrlShow [6002, true];
		ctrlShow [6003, true];
		ctrlShow [6004, true];
	},
	true,
	6001
] call menus_fnc_dropList;
_dropList1 ctrlSetTooltip "Choose player to update";


private _dropList2 = [
	"Update role",
	[0.5,3,5,1],
	{
		call loadout_fnc_roleList;
	},
	{
		_target = missionNamespace getVariable ["loadout_menu_selectedPlayer",nil];
		if (isNil "_target") exitWith {systemChat "Failed chaning role, selected player fail"};
		_target setVariable ["unit_loadout_role",_this,true];
		systemChat format ["%1 role changed to %2",(name _target),_this];
	},
	false,
	6002
] call menus_fnc_dropList;
_dropList2 ctrlSetTooltip "Choose new role to selected player";
_dropList2 ctrlShow false;



private _dropList3 = [
	"Update faction",
	[6,3,5,1],
	{
		private _list = [
			["AUTO WEST","west","Auto select west loadout"],
			["AUTO EAST","east","Auto select east loadout"],
			["AUTO GUER","resistance","Auto select independent loadout"],
			["AUTO CIV","civilian","Auto select civilian loadout"],
			["Disabled","disabled","The loadout will be disabled"]
		];
		private _nil = {
			_list pushBack [_x,_x,(_x + " faction")];
			false
		} count (LOADOUT_SETTING_FACTIONS);
		_list
	},
	{
		_target = missionNamespace getVariable ["loadout_menu_selectedPlayer",nil];
		if (isNil "_target") exitWith {systemChat "Failed chaning faction, selected player fail"};
		if (_this in ["west","east","resistance","civilian"]) then {
			_this = call compile _this;
		};
		_target setVariable ["unit_loadout_faction",(_this),true];
		systemChat format ["%1 faction changed to %2",(name _target),_this];
	},
	false,
	6003
] call menus_fnc_dropList;
_dropList3 ctrlSetTooltip "Choose new faction/side to selected player";
_dropList3 ctrlShow false;

private _button1 = ["Reset loadout",[0.5,4.5,5,1],"
	_target = missionNamespace getVariable ['loadout_menu_selectedPlayer',nil];
	if (isNil '_target') exitWith {systemChat 'Failed resetting loadout, selected player fail'};
	[_target] call loadout_fnc_unit;
	systemChat format ['%1 loadout has been reset',(name _target)];
",6004]call menus_fnc_addButton;
_button1 ctrlSetTooltip "The selected player's loadout will be reset";
_button1 ctrlShow false;



// Loadout function
private _title = ["Mission Functions",[0,6,14,1],true,-1]call menus_fnc_addTitle;

private _button1 = ["Reset All Players",[0.5,7.5,5,1],"
	[] spawn {
		private _nil = {
			[_x] call loadout_fnc_unit;
			false
		} count (allPlayers - entities 'HeadlessClient_F');
	};
",7001]call menus_fnc_addButton;
_button1 ctrlSetTooltip "All players will recieve their default loadouts";

private _button2 = ["Reset All ai",[6,7.5,4.5,1],"
	[] spawn {
		private _nil = {
			[_x] call loadout_fnc_unit;
			false
		} count allUnits - (allPlayers);
	};
",7002]call menus_fnc_addButton;
_button2 ctrlSetTooltip "All ai will recieve their default loadouts";

private _button3 = ["Reset All cargo",[0.5,9,5,1],"
	[] spawn {
		private _nil = {
			[_x] call loadout_fnc_cargo;
			false
		} count vehicles;
	};
",7003]call menus_fnc_addButton;
_button3 ctrlSetTooltip "All vehicles boxes will recieve auto cargo";

loadout_menu_autoCargoButton = {
	private _enabled = param [0,(missionNamespace getVariable ["mission_loadout_auto_enabled",LOADOUT_SETTING_AUTO_ENABLED])];

	missionNamespace setVariable ["mission_loadout_auto_enabled",_enabled,true];
    if (!_enabled) then {
		systemChat str "Auto gear is disabled";
		((findDisplay 304000) displayCtrl 7004) ctrlSetText "Enable Auto-gear";
		((findDisplay 304000) displayCtrl 7004) ctrlSetTooltip "Enable auto cargo/gear for units and vehicles";
		((findDisplay 304000) displayCtrl 7004) buttonSetAction "true call loadout_menu_autoCargoButton";
	} else {
		systemChat str "Auto gear is enabled";
		((findDisplay 304000) displayCtrl 7004) ctrlSetText "Disable Auto-gear";
		((findDisplay 304000) displayCtrl 7004) ctrlSetTooltip "Disable auto cargo/gear for units and vehicles";
		((findDisplay 304000) displayCtrl 7004) buttonSetAction "false call loadout_menu_autoCargoButton";
	};
};
private _button4 = ["",[6,9,6,1],"",7004]call menus_fnc_addButton;
[] call loadout_menu_autoCargoButton;

private _button5 = ["Fix nudes",[0.5,10.5,5,1],"
	[] spawn {
		private _nil = {
			if ((uniform _x) isEqualTo '') then {
				[_x] call loadout_fnc_unit;
			};
			false
		} count (allUnits - entities 'HeadlessClient_F');
	};
",7005]call menus_fnc_addButton;
_button5 ctrlSetTooltip "Reset all uniformless units";


// Change side faction
private _title = ["Change side auto faction/loadout",[0,12,14,1],true,-1]call menus_fnc_addTitle;

private _dropList1 = [
	"SIDE",
	[0.5,13.5,5,1],
	{
		private _list = [
			["WEST","WEST","Select west to be changed"],
			["EAST","EAST","Select east to be changed"],
			["GUER","GUER","Select independent to be changed"],
			["CIV","CIV","Select civilian to be changed"]
		];
		_list
	},
	{
		missionNamespace setVariable ["loadout_menu_selectedSide",_this];
		ctrlSetText [8001, _this];
	},
	false,
	8001
] call menus_fnc_dropList;
_dropList1 ctrlSetTooltip "Choose new side that will get new faction/loadout";

private _dropList2 = [
	"New faction",
	[6,13.5,5,1],
	{
		private _list = [
			["Disabled","disabled","The loadout will be disabled"]
		];
		private _nil = {
			_list pushBack [_x,_x,(_x + " faction")];
			false
		} count (LOADOUT_SETTING_FACTIONS);
		_list
	},
	{
		_target = missionNamespace getVariable ["loadout_menu_selectedSide",nil];
		if (isNil "_target") exitWith {systemChat "Failed chaning faction, selected side fail"};
		private _varName = format ["mission_loadout_faction_%1",toLower(_target)];
		missionNamespace setVariable [_varName,_this,true];
		systemChat format ["%1 side faction changed to %2",(str _target),_this];
	},
	false,
	8002
] call menus_fnc_dropList;
_dropList2 ctrlSetTooltip "Select new auto faction for selected side";