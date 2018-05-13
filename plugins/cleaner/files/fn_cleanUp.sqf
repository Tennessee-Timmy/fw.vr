/* ----------------------------------------------------------------------------
Function: cleaner_fnc_cleanUp

Description:
	Cleans dead vehicles and bodies

Parameters:
	none
Returns:
	nothing
Examples:
	call cleaner_fnc_cleanUp
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

//define variables
private _tooClose = missionNamespace getVariable ["mission_cleaner_tooClose",CLEANER_SETTINGS_TOOCLOSE];
private _min = missionNamespace getVariable ["mission_cleaner_Min",CLEANER_SETTINGS_MIN];
private _distanceToPlayer = missionNamespace getVariable ["mission_cleaner_dist",CLEANER_SETTINGS_DIST];
private _distanceToPlayerVeh = missionNamespace getVariable ["mission_cleaner_distVeh",CLEANER_SETTINGS_DISTVEH];
private _distanceToPlayerLow = missionNamespace getVariable ["mission_cleaner_distLow",CLEANER_SETTINGS_DISTLOW];
private _minVeh = missionNamespace getVariable ["mission_cleaner_minVeh",CLEANER_SETTINGS_MINVEH];
private _maxVehicles = missionNamespace getVariable ["mission_cleaner_maxVeh",CLEANER_SETTINGS_MAXVEH];
private _immobile = missionNamespace getVariable ["mission_cleaner_immobile",CLEANER_SETTINGS_IMMOBILE];


private _array = allDeadMen;				//array of all dead men
private _players = PLAYERLIST;				//All players
private _deadVehicles = allDead - _array;	//array of dead vehicles
private _vehicles = vehicles;				//array of all the vehicles
private _deadMen = [];

// Delete units that have been hidden for 10 seconds
private _nil = {
	private _hidden = _x getVariable ['unit_cleaner_hidden',[false,0]];
	if ((vehicle _x) isEqualTo _x && !(_hidden select 0)) then {
		_deadMen pushBackUnique _x
	};
	if (_hidden select 0) then {
		private _passed = time - (_hidden select 1);
		if (_passed > 10) then {deleteVehicle _x};
	};
	true
}count _array;

// loop through all dead men
private _nil = {
	call {
		if (_x getVariable ["unit_cleaner_disabled",false]) exitWith {
			_deadMen = _deadMen - [_x];
		};

		// check if players too close
		if !((allPlayers inAreaArray [(getpos _x),_tooClose,_tooClose,0,false]) isEqualTo []) exitWith {
			_deadMen = _deadMen - [_x];
		};

		//Run dumb check
		private _dead = _x;
		private _close = false;
		private _distanceLow = _distanceToPlayerLow;
		private _deadCount = count _deadMen;

		// Check how many dead units there are
		// The more dead there are the smalle the distance for the dumb check will be
		if (_deadCount > 40) then {_distanceLow = _distanceLow / 8};
		if (_deadCount > 30) then {_distanceLow = _distanceLow / 4};
		if (_deadCount > 20) then {_distanceLow = _distanceLow / 3};
		if (_deadCount > 10) then {_distanceLow = _distanceLow / 2};
		if (_deadCount < 5) then {_distanceLow = _distanceLow * 1.5};

		// Check if there are any players in range
		{
			if (_dead distance _x < _distanceLow) exitWith {_close = true;};
		} count _players;

		// if no players, delete body
		if (!_close) exitWith {
			_dead setVariable ["unit_cleaner_hidden",[true,time]];
			_dead remoteExec ["hideBody", -2];
			_deadMen = _deadMen - [_dead];
		};

		// Run Smart Check
		private _cleanUp_min = _min;

		// Check unit priority
		// unit_cleaner_priority 5 would mean it is not going to be deleted as fast
		// negative values would delete the unit earlier instead
		private _unitCleanUp = _dead getVariable ["unit_cleaner_priority",0];
		_cleanUp_min = _min + _unitCleanUp;

		// reset close and init smart check variable
		_close = false;
		private _num = count _deadMen;
		private _distance = _distanceToPlayer;

		// if there are more deads then smart check limit, set the body as processed
		if (_num > _cleanUp_min) then {
			private _var = _x getVariable "unit_cleaner_dead";
			private _multiplier = 2;

			// check if body has been processed yet
			if (!isNil "_var") then {
				private _gotVar = _var select 0;
				_multiplier = _var select 1;
				//if _gotVar true then add 1 and quit.
				if (_gotVar) exitWith {
					_dead setVariable ["unit_cleaner_dead",[false,((_multiplier)+1)]];
				};
				//if _gotVar false then add 1 and continue
				if (!(_gotVar)) then {
					_distance = (_distance - ((_distance / 3) * _multiplier) min 0);
					_dead setVariable ["unit_cleaner_dead",[true,((_multiplier)+1)]];
				};
			};
			//if there are more than minimum*2 dead men, just delete this one.
			if (_num > (_min*2)) then {
				_dead setVariable ["unit_cleaner_hidden",[true,time]];
				_dead remoteExec ["hideBody", -2];
				_deadMen = _deadMen - [_dead];
			} else {

				// Check if there are players near, add multiplier to the distance for next check
				private _nil = {
					if (_dead distance _x < _distance) exitWith {
						_dead setVariable ["unit_cleaner_dead",[false,_multiplier]];
						_close = true;
					};
					false
				} count _players;

				// if there's no one close, hide the unit
				if (!_close) then {
					_dead setVariable ["unit_cleaner_hidden",[true,time]];
					_dead remoteExec ["hideBody", -2];
					_deadMen = _deadMen - [_dead];
				};
			};
		};
	};
	false
} count _deadMen;



//deadvehicles
{
	private _cleanUp_minVeh = _minVeh;
	private _dead = _x;
	// Check unit priority
	// unit_cleaner_priority 5 would mean it is not going to be deleted as fast
	// negative values would delete the unit earlier instead
	private _unitCleanUp = _x getVariable ["unit_cleaner_priority",0];
	private _cleanUp_minVeh = _cleanUp_minVeh + _unitCleanUp;

	private _close = false;
	private _num = count _deadVehicles;

	// check if there are more dead vehicles than limit
	if (_num > _cleanUp_minVeh) then {
		_var = _x getVariable "unit_cleaner_dead";

		// Check if vehicle has been processed yet
		if (!isNil "_var") then {
			if (_var) then {
				_dead setVariable [ "unit_cleaner_dead", false ];
			} else {
				deleteVehicle _dead;
				_deadVehicles = _deadVehicles - [_dead];
			};
		} else {

			// Vehicle is not processed, check if total dead vehicles exceeds double the amount of limt and delete
			if (_num > (_cleanUp_minVeh*2)) then {
				deleteVehicle _dead;
				_deadVehicles = _deadVehicles - [_dead];
			} else {

				// check if players are close
				{
					if (_dead distance _dead < 300) exitWith {
						_dead setVariable ["unit_cleaner_dead", true];
						_close = true;
					};
				} count _players;
				if (!_close) then {
					deleteVehicle _dead;
					_deadVehicles = _deadVehicles - [_dead];
				};
			};
		};
	} else {

		// if vehicle limit has not been reached and there are no players in 1000m, delete
		{
			if (_dead distance _x < _distanceToPlayerVeh) exitWith {_close = true;};
		} count _players;
		if (!_close) then {
			deleteVehicle _dead;
			_deadVehicles = _deadVehicles - [_dead];
		};
	};
} count _deadVehicles;

if !(_immobile) exitWith {};
//vehicles
if (count _vehicles > _maxVehicles)then {
	private _nil = {
		private _distanceVeh = _distanceToPlayerVeh;

		// Check if cleanup for this object is disabled
		private _vehCleanUpDisabled = _x getVariable ["unit_cleaner_disabled",false];
		if !(_vehCleanUpDisabled) then {

			// check if there's anyone in the vehicle or if they vehicle can move
			if (((count crew _x)isEqualTo 0 && !canmove _x))then{
				if ((_x getVariable["unit_cleaner_priority",0] )> 0) then {
					_distanceVeh = _distanceVeh / 2;
				};
				private _dead = _x;
				private _close = false;
				private _nil = {
					if (_dead distance _x < _distanceVeh) exitWith {_close = true;};
					false
				} count _players;

				// if there are no players around , delete
				if (!_close) then {
					deleteVehicle _dead;
					_vehicles = _vehicles - [_dead];
				};
			};
		};
		false
	} count _vehicles;
};