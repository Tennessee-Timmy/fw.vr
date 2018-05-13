/* ----------------------------------------------------------------------------
Function: ace_spec_fnc_onRespawn

Description:
	onRespawn script for respawn system
	starts spectator

Parameters:
	none
Returns:
	nothing
Examples:
	call ace_spec_fnc_onRespawn;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// Update spec modes
private _modes = missionNamespace getVariable ["mission_ace_spec_modes",ACE_SPEC_SETTING_MODES];
[_modes, [0,1,2]] call ace_spectator_fnc_updateCameraModes;

// Update spectator sides
private _sides = missionNamespace getVariable ["mission_ace_spec_sides",ACE_SPEC_SETTING_SIDES];
private _sidesPlayer = player getVariable ["unit_ace_spec_sides",_sides];
[[], [west,east,resistance,civilian]] call ace_spectator_fnc_updateSpectatableSides;
[_sides, []] call ace_spectator_fnc_updateSpectatableSides;

// update blacklist every second
ace_spec_updateLoop = [] spawn {
	private _sides = missionNamespace getVariable ["mission_ace_spec_sides",ACE_SPEC_SETTING_SIDES];
	private _sidesPlayer = player getVariable ["unit_ace_spec_sides",_sides];
	waitUntil {
		private _units = allPlayers;
		private _show = [];
		private _hide = [];
		private _nil = {
			if (((_x call respawn_fnc_getSetUnitSide) in _sidesPlayer) && {!(_x call respawn_fnc_deadCheck)}) then {
				_show pushBack _x;
			} else {
				_hide pushBack _x;
			};
			sleep 0.01;
			false
		} count _units;
		[_show,_hide] call ace_spectator_fnc_updateUnits;
		sleep 0.01;
		!(player call respawn_fnc_deadCheck)
	};
};

// enable spectator
[true] call ace_spectator_fnc_setSpectator;
