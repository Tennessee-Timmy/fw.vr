/* ----------------------------------------------------------------------------
Function: safe_fnc_clientLoop

Description:
	Loop on the client that will check the conditions and enable safe weapons or turn them off

Parameters:
	none
Returns:
	nothing
Examples:
	call safe_fnc_clientLoop;
Author:
	nigel
	help from commy2
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins
disableSerialization;

if (!hasInterface) exitWith {};

[{!(player getVariable ['unit_safe_enabled',false])}] call ace_explosives_fnc_addDetonateHandler;
player setVariable ['unit_safe_stop',false];

if !(isNil 'unit_safe_loop') then {
	terminate unit_safe_loop;
};
unit_safe_loop = [] spawn {
	disableSerialization;

	// local functions

	private _fnc_hudOn = {
		params [['_on',false],['_restrict',false]];

		private _icons = [
			[
				'plugins\safe\files\dialogs\safe_off.paa',
				'plugins\safe\files\dialogs\safe_on.paa'
			],[
				'plugins\safe\files\dialogs\restrict_off.paa',
				'plugins\safe\files\dialogs\restrict_on.paa'
			]
		];

		if !(isNil 'safe_rsc_hud_closer') then {
			terminate safe_rsc_hud_closer;
			safe_rsc_hud_closer = nil;
		};

		private _last = + (missionNamespace getVariable ['safe_hud_last',[]]);
		private _lastTime = _last param [2,0];
		_last resize 2;

		if (!(_last isEqualTo [_on,_restrict]) || (time > _lastTime)) then {
			private _layer = "rscLayer_safe_hud" cutFadeOut 0;
			"rscLayer_safe_hud" cutRsc ["safe_rsc_hud", "PLAIN"];
			missionNamespace setVariable ['safe_hud_last',[_on,_restrict,(time + ([6,3]select _restrict))]];
			private _display = uiNamespace getVariable "safe_rsc_hud";
			private _controlIcon = (_display displayCtrl 5002);

			private _icon = ((_icons select _restrict) select _on);
			_controlIcon ctrlSetText _icon;

		};
		safe_rsc_hud_closer = [] spawn {

			if (time < 5) then {
				sleep 5;
			};

			sleep 3;
			"rscLayer_safe_hud" cutFadeOut 1;
			safe_rsc_hud_closer = nil;
		};
	};
	// todo ace nades and bombs
	// todo vehicles
	// enable safety
	private _fnc_enable = {

		// get current state
		private _enabled = player getVariable ['unit_safe_enabled',false];

		// if currently not enabled.. enable
		if (!_enabled) then {
			player setVariable ['unit_safe_enabled',true];
			ace_advanced_throwing_enabled = false;

			// show hud
			[true] call _fnc_hudOn;

			// message
			player groupChat "I can no longer use my weapons.";

			// check if damage is enabled in safe zones
			private _dd = missionNamespace getVariable ['mission_safe_disableDamage',SAFE_SETTING_DISABLEDAMAGE];
			if (_dd) then {
				player allowDamage false;
			};
		};
	};

	// disable safety
	private _fnc_disable = {

		// get current state
		private _enabled = player getVariable ['unit_safe_enabled',false];

		// if currently enabled.. disable
		if (_enabled) then {
			player setVariable ['unit_safe_enabled',false];
			ace_advanced_throwing_enabled = true;

			// show hud
			[false] call _fnc_hudOn;

			// message
			player groupChat "I can use my weapons again.";

			// check if damage is enabled in safe zones
			private _dd = missionNamespace getVariable ['mission_safe_disableDamage',SAFE_SETTING_DISABLEDAMAGE];
			if (_dd) then {
				player allowDamage true;
			};
		};

	};

	waitUntil {
		call {
			// check if we are on pause
			private _pause = missionNamespace getVariable ['mission_safe_pause',false];

			// check and make sure player is alive and well
			if (isNull player || {!alive player} || _pause || {(player call respawn_fnc_deadCheck)}) exitWith {
				call _fnc_disable;
			};

			// check if it's time to be turned on (originates from server[due to server time and custom times to be enabled])
			private _time = missionNamespace getVariable ['mission_safe_timeOn',false];

			// if it's not time to be enabled, exit
			if (!_time) exitWith {
				call _fnc_disable;
			};

			// Get zones
			private _zones = missionNamespace getVariable ['mission_safe_zones',[]];

			// check the zones to see if the are proper
			_zones = _zones select {
				!(isNil '_x') && {
					(_x isEqualType "" && {!((getMarkerColor _x) isEqualTo "")}) ||
					(_x isEqualType objNull && {!(isNull _x)}) ||
					(_x isEqualType [] && {!(_x isEqualTo [])}) ||
					(_x isEqualType true)
				}
			};

			// if no zones exit
			if (_zones isEqualTo []) exitWith {
				call _fnc_disable;
			};

			private _found = false;

			// loop through all the areas and set found true if player in one of the areas
			{
				if (_x isEqualType true && {_x}) exitWith {
					_found = true;
				};
				if (!(_x isEqualType true) && {player inArea _x}) exitWith {
					_found = true;
				};
			} forEach _zones;

			// if player was found on one of the safe areas, enable, otherwise disable
			if (_found) then {
				call _fnc_enable;
			} else {
				call _fnc_disable;
			};

			// see if hud warning required
			private _needWarning = missionNamespace getVariable ['unit_safe_needWarning',false];
			if (_needWarning) then {
				[true] call _fnc_hudOn;
			};
		};
		call {


			// check instant fail conditions
			private _pause = missionNamespace getVariable ['mission_safe_restrict_pause',false];
			private _sides = missionNamespace getVariable ['mission_safe_restrict_sides',SAFE_SETTING_RESTRICT_SIDES];
			private _unitSide = player call respawn_fnc_getSetUnitSide;

			// check if it's time to be turned on (originates from server[due to server time and custom times to be enabled])
			private _time = missionNamespace getVariable ['mission_safe_restrict_timeOn',false];

			// exit if paused or player side not in restrict sides
			if (_pause || !(_unitSide in _sides) || !_time || (isNull player || {!alive player} || _pause || {(player call respawn_fnc_deadCheck)})) exitWith {
				private _out = missionNamespace getVariable 'unit_safe_restrict_outTime';
				if !(isNil '_out') then {
					player setVariable ['unit_safe_restrict_outTime',nil];
				};
			};

			// get zones for player side
			private _zones = call {
				if (_unitSide isEqualTo west) exitWith {
					missionNamespace getVariable ['mission_safe_restrict_zones_west',SAFE_SETTING_RESTRICT_ZONES_WEST];
				};
				if (_unitSide isEqualTo east) exitWith {
					missionNamespace getVariable ['mission_safe_restrict_zones_east',SAFE_SETTING_RESTRICT_ZONES_EAST];
				};
				if (_unitSide isEqualTo resistance) exitWith {
					missionNamespace getVariable ['mission_safe_restrict_zones_guer',SAFE_SETTING_RESTRICT_ZONES_GUER];
				};
				missionNamespace getVariable ['mission_safe_restrict_zones_civi',SAFE_SETTING_RESTRICT_ZONES_CIVI];
			};

			// check the zones to see if the are proper
			_zones = _zones select {
				!(isNil '_x') && {
					(_x isEqualType "" && {!((getMarkerColor _x) isEqualTo "")}) ||
					(_x isEqualType objNull && {!(isNull _x)}) ||
					(_x isEqualType [] && {!(_x isEqualTo [])})
				}
			};

			// exit if no zones found
			if (_zones isEqualTo []) exitWith {};

			// get last found and setup found in this scope
			private _found = false;
			private _lastFound = player getVariable ['mission_safe_restrict_last',(_zones param [0,objNull])];

			// loop through all the areas and set found true if player in one of the areas
			{
				if (player inArea _x) exitWith {
					_found = true;
					_lastFound = _x;
				};
			} forEach _zones;

			// exit if found is true (this means player is in at least 1 restriction zone)
			if (_found) exitWith {
				player setVariable ['mission_safe_restrict_last',_lastFound];
				player setVariable ['unit_safe_restrict_outTime',nil];
			};

			// get the position of last found area
			private _lastFoundPos = [];

			// if last found area is a array, get the pos from first element
			if (_lastFound isEqualType []) then {
				_lastFoundPos = _lastFound param [0];
			};

			// if last found is a string, get marker pos
			if (_lastFound isEqualType "")  then {
				_lastFoundPos = getMarkerPos _lastFound;
			};

			// if last found is a object, get object pos
			if (_lastFound isEqualType objNull) then {
				_lastFoundPos = getPos _lastFound;
			};

			// exit if no position found or position 000
			if (_lastFoundPos isEqualTo [0,0,0] || _lastFoundPos isEqualTo []) exitWith {};

			// see how long player has been out of the zone for
			private _out = player getVariable 'unit_safe_restrict_outTime';
			if (isNil '_out') then {
				player setVariable ['unit_safe_restrict_outTime',(time)];
				_out = time;
			};

			private _timeOut = (time - _out)-5;

			// get player vehicle
			private _vehicle = (vehicle player);

			// get direction of the vehicle towards the middle of the zone
			private _dir = (_vehicle getDir _lastFoundPos);

			call {

				// if vehicle is the player (infantry)
				if (_vehicle isEqualTo player) then {

					// get orig velocity
					private _velocity = velocityModelSpace player;

					// set player direction toward last found position
					_vehicle setDir _dir;

					// return to original velocity
					player setVelocityModelSpace _velocity;
				};

				// get velocity to increase it towards teh zone
				private _velocity = velocity _vehicle;

				_velocity = [
					(((_velocity select 0)/100) + (sin _dir * (10 + _timeOut))),
					(((_velocity select 1)/100) + (cos _dir * (10 + _timeOut))),
					((_velocity select 2)+0.1)
				];

				// rand the vehicle towards the zone (restore velocity)
				_vehicle setVelocity _velocity;
			};


			hint "You can't go there! Turn around!";

			// show hud
			[true,true] call _fnc_hudOn;
			// todo warning
			// todo punshiment?
			// todo blackscreen?
		};
		(player getVariable ['unit_safe_stop',false])
	};
	call _fnc_disable;
};