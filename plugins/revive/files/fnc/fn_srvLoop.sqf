/* ----------------------------------------------------------------------------
Function: revive_fnc_srvLoop;

Description:
	Runs the server loop for revive (works for the waves)


	"mission_revive_wave_next" - CBA_Missiontime of the next respawn
	"mission_revive_wave_delay" - Delay between waves

Parameters:
	none

Returns:
	nothing
Examples:
	call revive_fnc_srvLoop;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

private _revive_srvHandle = missionNamespace getVariable ['mission_revive_srvHandle',scriptNull];

// exit if it's already running
if !(isNull _revive_srvHandle) exitWith {};

_revive_srvHandle = [] spawn {
	waitUntil {
		private _next = missionNamespace getVariable ['mission_revive_wave_next',(CBA_Missiontime - 30)];
		private _toWaveComplete = (_next - CBA_Missiontime);

		// if it's been more than 30 seconds over the wave time, start a new wave timer
		if (_toWaveComplete <= -30) then {

			// delay until next wave (default delay 15 minutes aka. 4 times a hour)
			private _delay = missionNamespace getVariable ['mission_revive_wave_delay',900];
			missionNamespace setVariable ['mission_revive_wave_next',(CBA_Missiontime + _delay),true];
		};



		(false)
	};
};
missionNamespace setVariable ['mission_revive_srvHandle',_revive_srvHandle];