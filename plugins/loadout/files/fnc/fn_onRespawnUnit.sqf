/* ----------------------------------------------------------------------------
Function: loadout_fnc_onRespawnUnit

Description:
	onRespawnUnit script for respawn system

Parameters:
	none
Returns:
	nothing
Examples:
	call loadout_fnc_onRespawn;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// add loadout
if (LOADOUT_SETTING_AUTO_PLAYER) then {
	[player] call loadout_fnc_unit;
	[] spawn {
		sleep 3;
		if ((uniform player) isEqualTo '') then {
			[player] call loadout_fnc_unit;
		};
	};
};
