/* ----------------------------------------------------------------------------
Function: revive_fnc_deadLoop

Description:
	Runs the loop for a dead player


	"mission_revive_wave_next" - CBA_Missiontime of the next respawn

Parameters:
	none

Returns:
	nothing
Examples:
	call revive_fnc_deadLoop;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

private _revive_deadHandle = missionNamespace getVariable ['mission_revive_deadHandle',scriptNull];

// exit if it's already running
if !(isNull _revive_deadHandle) exitWith {};

_revive_deadHandle = [] spawn {
	waitUntil {

		if !(player getVariable ["unit_respawn_dead",true]) exitWith {true};


		private _display = (findDisplay 60492);
		private _isSpectatorOpen = !(_display isEqualTo displayNull);
		if (_isSpectatorOpen) then {
			private _keyDownHandle = _display getVariable ['display_revive_keyDownHandle',nil];

			// exit if the display already has the key down event
			if !(isNil '_keyDownHandle') exitWith {};

			_keyDownHandle = _display displayAddEventHandler ["KeyDown", {
				params ["_ctrl", "_dikCode", "_shift", "_ctrlKey", "_alt"];

				// if ctrl + J is pressed
				private _keys = [0x24];
				if (_ctrlKey && {(_dikCode in _keys)}) then {

					// If menu exists, open it, if it does not, close it!
					if (findDisplay 304000 isEqualTo displayNull) then {
						call menus_fnc_menusOpen;
					} else {
						[304000] call menus_fnc_displayCloser;
					};
				};
			}];
			_display setVariable ['display_revive_keyDownHandle',_keyDownHandle];
		};

		private _next = missionNamespace getVariable ['mission_revive_wave_next',(CBA_Missiontime - 30)];
		private _toWaveComplete = (_next - CBA_Missiontime);

		private _readableTime = [_toWaveComplete] call respawn_fnc_readableTime;
		private _text = ('You are waiting for a revive. You can respawn in ' + _readableTime);
		private _nextTextTime = missionNamespace getVariable ['mission_revive_nextTextTime',CBA_Missiontime];
		private _nextTextTimeWait = 30;
		private _duration = 5;

		// if time until next wave is 0, allow respawning
		if (_toWaveComplete <= 0) then {

			player setVariable ['unit_revive_canRespawn',true];

			private _toWaveEnd = (30 - (abs _toWaveComplete));
			_readableTime = [_toWaveEnd] call respawn_fnc_readableTime;
			_text = ('You can respawn now! Press CTRL + J and use the revive menu to respawn. You have ' + _readableTime + '. left to respawn.');
			_duration = 1;
			_nextTextTimeWait = 1;

			// if next text time is bigger than 1, set it to 0 (this way player gets the respawn message)
			private _timeUntilNextTextTime = _nextTextTime - CBA_Missiontime;
			if (_timeUntilNextTextTime > 1) then {
				_nextTextTime = 0;
			};

			//[player] call respawn_fnc_respawn;
		} else {
			player setVariable ['unit_revive_canRespawn',false];
		};

		if (CBA_Missiontime >= _nextTextTime) then {
			[_text,false,_duration] call respawn_fnc_deadText;
			missionNamespace setVariable ['mission_revive_nextTextTime',(CBA_Missiontime + _nextTextTimeWait)];
		};

		(false)
	};
};
missionNamespace setVariable ['mission_revive_deadHandle',_revive_deadHandle];