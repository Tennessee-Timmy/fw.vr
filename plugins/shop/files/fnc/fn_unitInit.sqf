/* ----------------------------------------------------------------------------
Function: shop_fnc_unitInit

Description:
	Function that runs on unit init

Parameters:
	none
Returns:
	nothing
Examples:
	Runs in postInit eh

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_unit"];
if (!local _unit) exitWith {};

_unit setVariable ["unit_shop_side",(side (group _unit)),true];
_unit setVariable ['unit_shop_uid',(getPlayerUID _unit),true];
_unit addEventHandler ['killed',{_this call shop_fnc_onKilled}];

if !(isPlayer _unit) exitWith {};
_unit setVariable ["unit_shop_isPlayer",true,true];