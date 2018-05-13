/* ----------------------------------------------------------------------------
Function: headless_fnc_addZeusMod

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
	call headless_fnc_addZeusModules;

Author:
	nigel
---------------------------------------------------------------------------- */
// Leave if achilles is not loaded
if !(isClass (configFile >> "CfgPatches" >> "achilles_modules_f_achilles")) exitWith {};	// remove not isNull getAssignedCuratorLogic player and

["* Mission Headless", "Load To HC",
{
	[] spawn {

		disableSerialization;
	    private _newDisplay = (findDisplay 312) call menus_fnc_addDisplay;
		private _ctrlGroup = [[12.5,3,20,10],-1,_newDisplay] call menus_fnc_addGroup;
		private _background = [[0.2,0.2,0.2,1],[0,0,15,3],-1,_newDisplay,_ctrlGroup] call menus_fnc_addBackground;
		private _title = ["Transfer future units to HC aswell?",[0,0,15,1.2],true,-1,_newDisplay,_ctrlGroup]call menus_fnc_addTitle;
		private _closeButton = ["x",[14,0,1,1],"(ctrlParent (_this select 0)) closeDisplay 1;",-1,_newDisplay,_ctrlGroup] call menus_fnc_addButton;
		_closeButton ctrlSetTooltip "Close";
		private _yesButton = ["Yes",[1.5,1.5,5,1],"
			(ctrlParent (_this select 0)) closeDisplay 1;
			call zeus_fnc_onAdd;
			systemChat 'All newly placed units will now be moved to HC/Server automatically';
		",-1,_newDisplay,_ctrlGroup] call menus_fnc_addButton;
		_yesButton ctrlSetTooltip "All newly placed units will be moved to HC/Server automatically";
		private _noButton = ["No",[8.5,1.5,5,1],"(ctrlParent (_this select 0)) closeDisplay 1;",-1,_newDisplay,_ctrlGroup] call menus_fnc_addButton;
		_noButton ctrlSetTooltip "Only all currently existing units will be moved to HC/Server";
	};

	player remoteExec ['headless_fnc_moveAll',2];
	systemChat 'All Units that already existed will now be moved to HC/Server'
}] call Ares_fnc_RegisterCustomModule;
