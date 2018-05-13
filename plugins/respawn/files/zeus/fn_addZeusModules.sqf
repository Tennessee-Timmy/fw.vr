/* ----------------------------------------------------------------------------
Function: respawn_fnc_addZeusMod

Description:
	Adds respawn zeus modules to the mission

Parameters:
0:	_text		- String, name that will be displayed on the button
1:	_pos		- Postion and size of the button
2:	_code		- String of code to run when button is pressed
3:	_idc		- integer, idc to use for this control
Returns:
	_control 	- control of the button
Examples:
	call respawn_fnc_addZeusModules;

Author:
	nigel
---------------------------------------------------------------------------- */
// Leave if achilles is not loaded
if !(isClass (configFile >> "CfgPatches" >> "achilles_modules_f_achilles")) exitWith {};	// remove not isNull getAssignedCuratorLogic player and
["* Mission Respawn", "Respawn Players",
{
	[] spawn {

		disableSerialization;
	    private _newDisplay = (findDisplay 312) call menus_fnc_addDisplay;
		private _ctrlGroup = [[15,3,15,15],-1,_newDisplay] call menus_fnc_addGroup;
		private _background = [[0.2,0.2,0.2,1],[0,0,11.5,3],-1,_newDisplay,_ctrlGroup] call menus_fnc_addBackground;
		private _title = ["Respawn Players",[0,0,11.5,1.2],true,-1,_newDisplay,_ctrlGroup]call menus_fnc_addTitle;
		private _closeButton = ["x",[10.5,0,1,1],"(ctrlParent (_this select 0)) closeDisplay 1;",-1,_newDisplay,_ctrlGroup] call menus_fnc_addButton;
		_closeButton ctrlSetTooltip "Close";

		private _dropList = [
			"Respawn Player",
			[0.5,1.5,5,1],
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
			{[_this] call respawn_fnc_respawn},
			true,
			-1,
			_newDisplay,
			_ctrlGroup

		] call menus_fnc_dropList;
		_dropList ctrlSetTooltip "Respawn Player";
		_dropList = [
			"Respawn Side",
			[6,1.5,5,1],
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
			false,
			-1,
			_newDisplay,
			_ctrlGroup
		] call menus_fnc_dropList;
		_dropList ctrlSetTooltip "Respawn Side";
	};

}] call Ares_fnc_RegisterCustomModule;

// Respawn location
["* Mission Respawn", "Set respawn location",
{

	hint 'TIP: This module can be placed on objects to inherit object position as well';

    private _module_position = param [0,[0,0,0],[[]]];
    private _selected_object = param [1,ObjNull,[ObjNull]];

	private _dialog_result = ["Side to change.",
	[
	    ["Side Control", "SIDE", 2]
	]] call Ares_fnc_showChooseDialog;
	if (count _dialog_result == 0) exitWith {};
	private _side = (_dialog_result select 0);
	private _code = {};
	private _position = _module_position;

	if !(_selected_object isEqualTo objNull) then {
		_position = getPosATL _selected_object;
	};


	if (mission_respawn_location isEqualTo {call respawn_fnc_base_respawn}) then {
		call {
			if (_side isEqualTo 1) exitWith {
				mission_respawn_base_location_east setPosATL _position;
			};
			if (_side isEqualTo 2) exitWith {
				mission_respawn_base_location_west setPosATL _position;
			};
			if (_side isEqualTo 3) exitWith {
				mission_respawn_base_location_resistance setPosATL _position;
			};
			mission_respawn_base_location_civilian setPosATL _position;
		};
	};
	if (mission_respawn_location isEqualTo {call respawn_fnc_default_respawn}) then {
		call {
			if (_side isEqualTo 1) exitWith {
				"respawn_east" setMarkerPos _position;
			};
			if (_side isEqualTo 2) exitWith {
				"respawn_west" setMarkerPos _position;
			};
			if (_side isEqualTo 3) exitWith {
				"respawn_resistance" setMarkerPos _position;
			};
			"respawn_civilian" setMarkerPos _position;
		};
	};


}] call Ares_fnc_RegisterCustomModule;