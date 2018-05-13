/* ----------------------------------------------------------------------------
Function: acre_fnc_addZeusModules

Description:
	Add custom module to zeus
	Requires achilles

Parameters:
	none
Returns:
	nothing
Examples:
	// Use this to register custom modules
	call acre_fnc_addZeusModules;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// code begins

// Leave if achilles is not loaded
if !(isClass (configFile >> "CfgPatches" >> "achilles_modules_f_achilles")) exitWith {};

["* Mission ACRE", "Add def. Radios",
{
	[] spawn {

	disableSerialization;
    private _newDisplay = (findDisplay 312) call menus_fnc_addDisplay;
	private _ctrlGroup = [[15,3,15,15],-1,_newDisplay] call menus_fnc_addGroup;
	private _background = [[0.2,0.2,0.2,1],[0,0,11.5,5.5],-1,_newDisplay,_ctrlGroup] call menus_fnc_addBackground;
	private _title = ["Add Default Radios",[0,0,11.5,1.2],true,-1,_newDisplay,_ctrlGroup] call menus_fnc_addTitle;

	private _button2 = ["Re-Add radios to EVERYONE",[0.5,2,10,1],"remoteExec ['acre_fnc_addRadios',0];",-1,_newDisplay,_ctrlGroup] call menus_fnc_addButton;
	_button2 ctrlSetTooltip "Add default radios to everyone";

	_dropList2 = [
		"Re-add Radios to Player",
		[0.5,4,10,1],
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
		{remoteExec ["acre_fnc_addRadios",_this]},
		true,
		-1,
		_newDisplay,
		_ctrlGroup
	] call menus_fnc_dropList;
	_dropList2 ctrlSetTooltip "Re-add default radios to a player";
	};
}] call Ares_fnc_RegisterCustomModule;

["* Mission TFAR", "Reset Radio Settings",
{
	[] spawn {

	disableSerialization;
    private _newDisplay = (findDisplay 312) call menus_fnc_addDisplay;
	private _ctrlGroup = [[15,3,15,15],-1,_newDisplay] call menus_fnc_addGroup;
	private _background = [[0.2,0.2,0.2,1],[0,0,11.5,5.5],-1,_newDisplay,_ctrlGroup] call menus_fnc_addBackground;
	private _title = ["Reset Default Radio Settings",[0,0,11.5,1.2],true,-1,_newDisplay,_ctrlGroup]call menus_fnc_addTitle;

	private _button1 = ["Reset EVERYONE's Settings",[0.5,2,10,1],"remoteExec ['acre_fnc_setupRadios',0]",-1,_newDisplay,_ctrlGroup]call menus_fnc_addButton;
	_button1 ctrlSetTooltip "Restore all radio settings for everyone";

	_dropList = [
		"Reset Player",
		[0.5,4,10,1],
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
		{remoteExec ["acre_fnc_setupRadios",_this]},
		true,
		-1,
		_newDisplay,
		_ctrlGroup
	] call menus_fnc_dropList;
	_dropList ctrlSetTooltip "Reset settings for a player";
	};
}] call Ares_fnc_RegisterCustomModule;