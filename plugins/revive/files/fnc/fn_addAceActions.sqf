/* ----------------------------------------------------------------------------
Function: revive_fnc_addAceActions

Description:
	Adds ace actions

Parameters:
	none

Returns:
	nothing
Examples:
	call revive_fnc_addAceActions;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins


_revive = [
	"revive_action",
	"Revive Player",
	"",
	{
		[
			3,
			[_target],
			{
				_target = ((_this param [0]) param [0,objNull]);

				// call revive script
				_target call revive_fnc_revive;
			},
			{},
			"Reviving Player", {
				_target = ((_this param [0]) param [0,objNull]);
				(_target inArea [player,5,5,0,false])
			}
		] call ace_common_fnc_progressBar;

		[player, 'AinvPknlMstpSlayWnonDnon_medic'] call ace_common_fnc_doAnimation;
	},
	{
		private _canBeRevived = _target getVariable ['unit_revive_canBeRevived',false];
		_canBeRevived && (isNull (objectParent _target))
	}
] call ace_interact_menu_fnc_createAction;
["CAManBase", 0, ["ACE_MainActions"], _revive, true] call ace_interact_menu_fnc_addActionToClass;
["ACE_bodyBagObject", 0, ["ACE_MainActions"], _revive, true] call ace_interact_menu_fnc_addActionToClass;