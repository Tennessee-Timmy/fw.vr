/* ----------------------------------------------------------------------------
Function: respawn_wave_fnc_serverTimer

Description:
	Curates the wave respawn timers for all sides
	Inside the mission_wave_respawn_timer_script loop
	Only runs on the server
	Runs respawn_wave_fnc_updateSideTime
Parameters:
	none
Returns:
	nothing
Examples:
	call respawn_wave_fnc_serverTimer;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// Only run on the server
if !(isServer) exitWith {};

// Grab saved wave counts and save them on mission
{
	private _wavesVar = format ["respawn_wave_count_%1",_x];
	private _defaultWaves = missionNamespace getVariable ["respawn_wave_count",RESPAWN_WAVE_PARAM_COUNT];
	private _availableWaves = [_wavesVar,_defaultWaves] call seed_fnc_getVars;
	missionNamespace setVariable [_wavesVar,_availableWaves,true];
} count [west,east,resistance,civilian];

// Spawn the timer
// Setup a termination
mission_wave_respawn_timer_script = [] spawn {

	// Loop using waitUntil
	waitUntil {

		// Update times for all sides
		private _nul = {
			_x call respawn_wave_fnc_updateSideTime;
			true
		} count [west,east,resistance,civilian];

		// Sleep 1 seconds and check if the respawn type has changed
		sleep 1;
		!(mission_respawn_type isEqualTo {call respawn_wave_fnc_onRespawn})
	};

	// Terminate this script
	terminate mission_wave_respawn_timer_script;
};