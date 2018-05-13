/* ----------------------------------------------------------------------------
Function: safe_fnc_srvLoop

Description:
	Loop on the server, which will make sure that time is correctly updated for clients

Parameters:
	none
Returns:
	nothing
Examples:
	call safe_fnc_srvLoop;
Author:
	nigel
	help from commy2
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

if (!isServer) exitWith {};

// spawn a loop
[] spawn {
	waitUntil {
		call {

			// check if we are on pause
			private _pause = missionNamespace getVariable ['mission_safe_pause',false];
			if (_pause) exitWith {

			};

			// get variables
			private _on = missionNamespace getVariable ['mission_safe_timeOn',false];
			private _time = missionNamespace getVariable ['mission_safe_time',0];

			// if time has ran out, exit the loop
			if (_time < 1) exitWith {

				// if timeOn is set as true, set it as false
				if (_on) then {
					missionNamespace setVariable ['mission_safe_timeOn',false,true];
				};
			};

			// if timeOn is set false, set it as true
			if (!_on) then {
				missionNamespace setVariable ['mission_safe_timeOn',true,true];
			};

			missionNamespace setVariable ['mission_safe_time',(_time - 1)];
		};
		call {

			// check if we are on pause
			private _pause = missionNamespace getVariable ['mission_safe_restrict_pause',false];
			if (_pause) exitWith {

			};

			// get variables
			private _on = missionNamespace getVariable ['mission_safe_restrict_timeOn',false];
			private _time = missionNamespace getVariable ['mission_safe_restrict_time',0];

			// if time has ran out, exit the loop
			if (_time < 1) exitWith {

				// if timeOn is set as true, set it as false
				if (_on) then {
					missionNamespace setVariable ['mission_safe_restrict_timeOn',false,true];
				};
			};

			// if timeOn is set false, set it as true
			if (!_on) then {
				missionNamespace setVariable ['mission_safe_restrict_timeOn',true,true];
			};

			missionNamespace setVariable ['mission_safe_restrict_time',(_time - 1)];
		};
		sleep 1;
		(missionNamespace getVariable ['mission_safe_stop',false])
	};
};
