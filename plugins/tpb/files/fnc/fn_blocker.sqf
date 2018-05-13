/* ----------------------------------------------------------------------------
Function: tpb_fnc_blocker

Description:
	Runs the blocker loop
	Defaults to "mission_tpb_mode" if "unit_tpb_mode" is not set

	Possible modes:
	0		- Third person blocked 100%
	1		- Only drivers can use third person
	2		- Can use third person at all time

Parameters:
	none
Returns:
	nothing
Examples:
	call tpb_fnc_blocker;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
#define FIRSTPERSON		player switchCamera "INTERNAL";
// Code begins


// create the script in scheduled
[] spawn {
	private _blockCancel = nil;

	// loop for view blocking
	while {isNil "_blockCancel"} do {

		// Check for updates on third person allowance
		// Check which setting is enabled
		private _mode = missionNamespace getVariable ["mission_tpb_mode",TPB_PARAM_MODE];

		// Check if player has a special mode defined
		private _playerMode = player getVariable ["unit_tpb_mode",_mode];

		// wait until third person mode is used
		waitUntil {cameraView == "EXTERNAL" || cameraView == "GROUP"};

		// call so exitWith can be used
		call {

			// If third person is allowed, suspend this script for 10 seconds
			if (_playerMode isEqualTo 2) exitWith {
				sleep 10;
			};

			// if thirdperson is completly blocked, switch back to first person instantly
			if (_playerMode isEqualTo 0) exitWith {
				FIRSTPERSON
				systemChat "3rd person view is currently disabled.";
			};

			// if player is not in a vehicle
			if ((vehicle player) isEqualTo player) exitWith {

				// Check if being unarmed allows third person
				private _unarmed = missionNamespace getVariable ["mission_tpb_allow_unarmed",TPB_SETTING_ALLOW_UNARMED];

				// If unarmed is enabled, check if player is unarmed
				if (_unarmed) then {
					if !((currentWeapon player) isEqualTo '') then {
						FIRSTPERSON
						systemChat "Holster your weapon to use 3rd person view.";
					};
				} else {
					FIRSTPERSON
					systemChat "You are not allowed to use 3rd person view.";
				};
			};

			// Check if drivers should be concidered for 3rd person
			if (_playerMode isEqualTo 1) exitWith {

				// switch to first person if player is not the driver of their vehicle
				if (player != driver (vehicle player)) then {
					FIRSTPERSON
					systemChat "Only drivers/pilots can use 3rd person view.";
				};
			};

			// return to first person
			FIRSTPERSON
		};

		// Check if third person block is turned off yet
		private _missionBlockCancel = missionNamespace getVariable 'mission_disable_thirdPersonBlock';
		_blockCancel = player getVariable ["unit_disable_thirdPersonBlock",(if (isNil "_missionBlockCancel") then {nil} else {_missionBlockCancel})];
	};
};