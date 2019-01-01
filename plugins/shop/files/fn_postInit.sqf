/* ----------------------------------------------------------------------------
Function: shop_fnc_postInit

Description:
	post init script for shop plugin

Parameters:
	none
Returns:
	nothing
Examples:
	Runs in postInit (from functions.cpp)

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Script begins

//if !(isServer) exitWith {};

// Use spawn so a loop can be used
[] spawn {
	// wait until mission display exists
	waitUntil {!((findDisplay 46) isEqualTo displayNull)};

	(findDisplay 46) displayAddEventHandler ['KeyDown',{if ((_this select 1) isEqualTo 0x3B) then {[false] call shop_fnc_buyMenu;true}}];
	player addAction ["Open Shop", {[false] call shop_fnc_buyMenu;},nil,1.5,true,true,'SelectGroupUnit1','(missionNamespace getVariable ["mission_shop_open",false])'];
};