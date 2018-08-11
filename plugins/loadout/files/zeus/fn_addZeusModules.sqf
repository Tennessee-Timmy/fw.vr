/* ----------------------------------------------------------------------------
Function: tfr_fnc_addZeusModules

Description:
	Add custom module to zeus
	Requires achilles

Parameters:
	none
Returns:
	nothing
Examples:
	// Use this to register custom modules
	call tfr_fnc_addZeusModules;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// code begins

// Leave if achilles is not loaded
if !(isClass (configFile >> "CfgPatches" >> "achilles_modules_f_achilles")) exitWith {};

// player
["* Mission Loadout", "Edit player",
{

	disableSerialization;
    private _newDisplay = (findDisplay 312) call menus_fnc_addDisplay;
	private _ctrlGroup = [[15,3,15,15],-1,_newDisplay] call menus_fnc_addGroup;
	private _background = [[0.2,0.2,0.2,1],[0,0,12,6],-1,_newDisplay,_ctrlGroup] call menus_fnc_addBackground;
	private _title = ["Edit player loadout",[0,0,12,1.2],true,-1,_newDisplay,_ctrlGroup] call menus_fnc_addTitle;
	private _closeButton = ["x",[11,0,1,1],"(ctrlParent (_this select 0)) closeDisplay 1;",-1,_newDisplay,_ctrlGroup] call menus_fnc_addButton;

	missionNamespace setVariable ["loadout_menu_selectedPlayer",nil];

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
			((findDisplay 1000) displayCtrl 6002) ctrlShow true;
			((findDisplay 1000) displayCtrl 6003) ctrlShow true;
			((findDisplay 1000) displayCtrl 6004) ctrlShow true;
		},
		true,
		6001,
		_newDisplay,
		_ctrlGroup
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
		6002,
		_newDisplay,
		_ctrlGroup
	] call menus_fnc_dropList;
	_dropList2 ctrlSetTooltip "Choose new role to selected player";
	_dropList2 ctrlShow false;



	private _dropList3 = [
		"Update faction",
		[6,3,5,1],
		{
			private _list = [
				["AUTO WEST",west,"Auto select west loadout"],
				["AUTO EAST",east,"Auto select east loadout"],
				["AUTO GUER",independent,"Auto select independent loadout"],
				["AUTO CIV",civilian,"Auto select civilian loadout"],
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
			_target setVariable ["unit_loadout_faction",_this,true];
			systemChat format ["%1 faction changed to %2",(name _target),_this];
		},
		false,
		6003,
		_newDisplay,
		_ctrlGroup
	] call menus_fnc_dropList;
	_dropList3 ctrlSetTooltip "Choose new faction/side to selected player";
	_dropList3 ctrlShow false;

	private _button1 = ["Reset loadout",[0.5,4.5,5,1],"
		_target = missionNamespace getVariable ['loadout_menu_selectedPlayer',nil];
		if (isNil '_target') exitWith {systemChat 'Failed resetting loadout, selected player fail'};
		[_target] call loadout_fnc_unit;
		systemChat format ['%1 loadout has been reset',(name _target)];
		",
		6004,
		_newDisplay,
		_ctrlGroup
	] call menus_fnc_addButton;
	_button1 ctrlSetTooltip "The selected player's loadout will be reset";
	_button1 ctrlShow false;
}] call Ares_fnc_RegisterCustomModule;


// functions
["* Mission Loadout", "Mission Functions",
{

	disableSerialization;
    private _newDisplay = (findDisplay 312) call menus_fnc_addDisplay;
	private _ctrlGroup = [[15,3,15,15],-1,_newDisplay] call menus_fnc_addGroup;
	private _background = [[0.2,0.2,0.2,1],[0,0,12,9],-1,_newDisplay,_ctrlGroup] call menus_fnc_addBackground;
	private _title = ["Mission Loadout Function",[0,0,12,1.2],true,-1,_newDisplay,_ctrlGroup] call menus_fnc_addTitle;
	private _closeButton = ["x",[11,0,1,1],"(ctrlParent (_this select 0)) closeDisplay 1;",-1,_newDisplay,_ctrlGroup] call menus_fnc_addButton;

	private _button1 = ["Reset All Players",[0.5,1.5,5,1],"
		[] spawn {
			private _nil = {
				[_x] call loadout_fnc_unit;
				false
			} count (allPlayers - entities 'HeadlessClient_F');
		};
		",
		7001,
		_newDisplay,
		_ctrlGroup
	] call menus_fnc_addButton;
	_button1 ctrlSetTooltip "All players will recieve their default loadouts";

	private _button2 = ["Reset All ai",[6,1.5,4.5,1],"
		[] spawn {
			private _nil = {
				[_x] call loadout_fnc_unit;
				false
			} count allUnits - (allPlayers);
		};
		",
		7002,
		_newDisplay,
		_ctrlGroup
	] call menus_fnc_addButton;
	_button2 ctrlSetTooltip "All ai will recieve their default loadouts";

	private _button3 = ["Reset All cargo",[0.5,3,5,1],"
		[] spawn {
			private _nil = {
				[_x] call loadout_fnc_cargo;
				false
			} count vehicles;
		};
		",
		7003,
		_newDisplay,
		_ctrlGroup
	] call menus_fnc_addButton;
	_button3 ctrlSetTooltip "All vehicles boxes will recieve auto cargo";

	loadout_menu_autoCargoButton = {
		private _enabled = param [0,(missionNamespace getVariable ["mission_loadout_auto_enabled",LOADOUT_SETTING_AUTO_ENABLED])];

		missionNamespace setVariable ["mission_loadout_auto_enabled",_enabled,true];
	    if (!_enabled) then {
			systemChat str "Auto gear is disabled";
			((findDisplay 1000) displayCtrl 7004) ctrlSetText "Enable Auto-gear";
			((findDisplay 1000) displayCtrl 7004) ctrlSetTooltip "Enable auto cargo/gear for units and vehicles";
			((findDisplay 1000) displayCtrl 7004) buttonSetAction "true call loadout_menu_autoCargoButton";
		} else {
			systemChat str "Auto gear is enabled";
			((findDisplay 1000) displayCtrl 7004) ctrlSetText "Disable Auto-gear";
			((findDisplay 1000) displayCtrl 7004) ctrlSetTooltip "Disable auto cargo/gear for units and vehicles";
			((findDisplay 1000) displayCtrl 7004) buttonSetAction "false call loadout_menu_autoCargoButton";
		};
	};
	private _button4 = ["",[6,3,6,1],"",7004,_newDisplay,_ctrlGroup]call menus_fnc_addButton;
	[] call loadout_menu_autoCargoButton;

	private _button5 = ["Fix nudes",[0.5,4.5,5,1],"
		[] spawn {
			private _nil = {
				if ((uniform _x) isEqualTo '') then {
					[_x] call loadout_fnc_unit;
				};
				false
			} count (allUnits - entities 'HeadlessClient_F');
		};
	",7005,_newDisplay,_ctrlGroup]call menus_fnc_addButton;
	_button5 ctrlSetTooltip "Reset all uniformless units";

	// Faction side
	private _title = ["Change side auto faction/loadout",[0,6,12,1.2],true,-1,_newDisplay,_ctrlGroup] call menus_fnc_addTitle;

	private _dropList1 = [
		"SIDE",
		[0.5,7.5,5,1],
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
		8001,
		_newDisplay,
		_ctrlGroup
	] call menus_fnc_dropList;
	_dropList1 ctrlSetTooltip "Choose new side that will get new faction/loadout";

	private _dropList2 = [
		"New faction",
		[6,7.5,5,1],
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
		8002,
		_newDisplay,
		_ctrlGroup
	] call menus_fnc_dropList;
	_dropList2 ctrlSetTooltip "Select new auto faction for selected side";
}] call Ares_fnc_RegisterCustomModule;



// Change side faction
["* Mission Loadout", "Edit target loadout/cargo",
{

	disableSerialization;
	missionNamespace setVariable ["loadout_zeus_target",nil];
    private _selected_object = param [1,ObjNull,[ObjNull]];
	if (_selected_object isEqualTo objNull) exitWith {
		systemChat "Wrong target, place this module on a unit/vehicle/cargobox";
	};
	missionNamespace setVariable ["loadout_zeus_target",_selected_object];

    private _newDisplay = (findDisplay 312) call menus_fnc_addDisplay;
	private _ctrlGroup = [[15,3,15,15],-1,_newDisplay] call menus_fnc_addGroup;
	private _background = [[0.2,0.2,0.2,1],[0,0,12,4.5],-1,_newDisplay,_ctrlGroup] call menus_fnc_addBackground;
	private _closeButton = ["x",[11,0,1,1],"(ctrlParent (_this select 0)) closeDisplay 1;",-1,_newDisplay,_ctrlGroup] call menus_fnc_addButton;

	if (_selected_object isKindOf "CAManBase") exitWith {
		private _title = ["Edit unit loadout",[0,0,12,1.2],true,-1,_newDisplay,_ctrlGroup] call menus_fnc_addTitle;

		private _dropList2 = [
			"Update role",
			[0.5,1.5,5,1],
			{
				call loadout_fnc_roleList;
			},
			{
				_target = missionNamespace getVariable ["loadout_zeus_target",nil];
				if (isNil "_target") exitWith {systemChat "Failed chaning role, selected player fail"};
				_target setVariable ["unit_loadout_role",_this,true];
				systemChat format ["%1 role changed to %2",(name _target),_this];
			},
			false,
			6002,
			_newDisplay,
			_ctrlGroup
		] call menus_fnc_dropList;
		_dropList2 ctrlSetTooltip "Choose new role to selected unit";

		private _dropList3 = [
			"Update faction",
			[6,1.5,5,1],
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
				_target = missionNamespace getVariable ["loadout_zeus_target",nil];
				if (isNil "_target") exitWith {systemChat "Failed chaning faction, selected player fail"};
				if (_this in ["west","east","resistance","civilian"]) then {
					_this = call compile _this;
				};
				_target setVariable ["unit_loadout_faction",(_this),true];
				systemChat format ["%1 faction changed to %2",(name _target),_this];
			},
			false,
			6003,
			_newDisplay,
			_ctrlGroup
		] call menus_fnc_dropList;
		_dropList3 ctrlSetTooltip "Choose new side/faction to selected unit";

		private _button1 = ["Reset loadout",[0.5,3,5,1],"
			_target = missionNamespace getVariable ['loadout_zeus_target',nil];
			if (isNil '_target') exitWith {systemChat 'Failed resetting loadout, selected player fail'};
			[_target] remoteExec ['loadout_fnc_unit',_target];
			systemChat format ['%1 loadout has been reset',(name _target)];
			",
			6004,
			_newDisplay,
			_ctrlGroup
		] call menus_fnc_addButton;
		_button1 ctrlSetTooltip "The selected unit's loadout will be reset";

	};

	private _title = ["Edit object cargo",[0,0,12,1.2],true,-1,_newDisplay,_ctrlGroup] call menus_fnc_addTitle;

	private _dropList2 = [
		"Add Cargo Type",
		[0.5,1.5,5,1],
		{
			[

				["Pistol","pistol"],
				["Rifle","rifle"],
				["Mg","mg"],
				["At","at"],
				["Radios","radios"],
				["SR Radio","radiosSR"],
				["LR Radios","radiosLR"],
				["Weapons","weapons"],
				["WeaponsBig","weaponsbig"],
				["Ammo","ammo"],
				["AmmoBig","ammoBig"],
				["MedsSmall","medsSmall"],
				["Meds","meds"],
				["bags","bags"],
				["Empty","empty"],
				["Custom 1","custom1"],
				["Custom 2","custom2"],
				["Custom 3","custom3"]

			]
		},
		{
			_target = missionNamespace getVariable ["loadout_zeus_target",nil];
			if (isNil "_target") exitWith {systemChat "Failed chaning cargotype, selected object fail"};
			private _currentCargoType = ["empty"];
			if !(_this isEqualTo "empty") then {
				_currentCargoType = _target getVariable ["unit_loadout_cargoType",[]];
				_currentCargoType pushBack _this;
				systemChat format ["%2 cargoType added to %1",(typeOf _target),_this];
			} else {
				systemChat format ["%1 cargotypes replaced with %2",(typeOf _target),_this];
			};
			_target setVariable ["unit_loadout_cargoType",_currentCargoType,true];
		},
		false,
		6002,
		_newDisplay,
		_ctrlGroup
	] call menus_fnc_dropList;
	_dropList2 ctrlSetTooltip "Choose cargotype to add";

	private _dropList3 = [
		"Update faction",
		[6,1.5,5,1],
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
			_target = missionNamespace getVariable ["loadout_zeus_target",nil];
			if (isNil "_target") exitWith {systemChat "Failed chaning faction, selected player fail"};
			if (_this in ["west","east","resistance","civilian"]) then {
				_this = call compile _this;
			};
			_target setVariable ["unit_loadout_faction",(_this),true];
			systemChat format ["%1 faction changed to %2",(name _target),_this];
		},
		false,
		6003,
		_newDisplay,
		_ctrlGroup
	] call menus_fnc_dropList;
	_dropList3 ctrlSetTooltip "Choose new faction/side for selected object";

	private _button1 = ["Reset Cargo",[0.5,3,5,1],"
		_target = missionNamespace getVariable ['loadout_zeus_target',nil];
		if (isNil '_target') exitWith {systemChat 'Failed resetting cargo, selected object fail'};
		[_target] call loadout_fnc_cargo;
		systemChat format ['%1 cargo has been reset',(typeOf _target)];
		",
		6004,
		_newDisplay,
		_ctrlGroup
	] call menus_fnc_addButton;
	_button1 ctrlSetTooltip "The selected object's cargo will be reset";

	private _button2 = ["Remove Cargo",[6,3,5,1],"
		_target = missionNamespace getVariable ['loadout_zeus_target',nil];
		if (isNil '_target') exitWith {systemChat 'Failed removing cargo, selected object fail'};
		_target setVariable ['unit_loadout_cargoType',[],true];
		[_target] call loadout_fnc_cargo;
		systemChat format ['%1 cargo has been removed',(typeOf _target)];
		",
		6004,
		_newDisplay,
		_ctrlGroup
	] call menus_fnc_addButton;
	_button2 ctrlSetTooltip "The selected object's cargo will be removed";

}] call Ares_fnc_RegisterCustomModule;


/*


    private _module_position = param [0,[0,0,0],[[]]];
    private _selected_object = param [1,ObjNull,[ObjNull]];
	private _position = _module_position;
	if !(_selected_object isEqualTo objNull) then {
		_position = _selected_object;
	};

	*/