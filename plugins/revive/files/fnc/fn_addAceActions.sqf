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
		private _item = 'ACE_personalAidKit';

		// array of units to check for items
		private _unitArr = [_target,player];

		// find if a unit has the item
		private _itemFrom = _unitArr findIf {
			private _items = items _x;
			(_items findIf {_x isEqualTo _item}) != -1
		};

		_itemFrom = _unitArr param [_itemFrom,objNull];

		private _hasItems = !(isNull _itemFrom);

		// remove a kit
		_itemFrom removeItem _item;

		private _isMedic = player getUnitTrait 'Medic';

		// time based on item
		private _time = [5,20] select _hasItems;

		// half time if player is medic
		_time = _time * ([1,0.5] select _isMedic);

		// text based on item
		private _text = ['Reviving player without personal aid kit','Reviving player with personal aid kit'] select _hasItems;




		[
			_time,
			[_target,_itemFrom,_item],
			{
				_target = ((_this param [0]) param [0,objNull]);

				// call revive script
				_target call revive_fnc_revive;
			},
			{
				(_this#0) params ['_target','_itemFrom','_item'];
				if (!isNull _itemFrom) then {
					_itemFrom addItem _item;
				};
			},
			_text, {
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