/* ----------------------------------------------------------------------------
Function: round_fnc_prepRound

Description:
	Prepares the round for client
	heals, moves to location and runs prep codes

Parameters:
	none
Returns:
	nothing
Examples:
	call round_fnc_prepRound;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

// Code begins
if !(hasInterface) exitWith {};

// find player side
private _side = player call round_fnc_findPlayerSide;

// get variables from side
private _sideName = _side getVariable ['round_sideName',''];
private _sideLoc = _side getVariable ['round_sideLoc',objNull];
private _sideLocNR = _side getVariable ['round_sideLocNR',99];
private _sideUnits = _side getVariable ['round_sideUnits',[]];
private _sideNr = _side getVariable ['round_sideNr',99];
private _sideLoadout = _side getVariable ['round_sideLoadout',''];

if (_sideName isEqualTo '') exitWith {player setDamage 1;};

private _unit = player;

// disable simulation to avoid weird bugs
_unit enableSimulation false;

// update player varaibles
//player setVariable ['unit_round_side',_sideName,true];

private _waited = 0;
// wait for respawn
waitUntil {
	_waited = _waited + 1;
	if (_waited > 200) exitWith {true};
	!(player call respawn_fnc_deadCheck)
};

// exit if waited 2k frames (200/30fps = ~6 seconds)
if (_waited > 200) exitWith {player setdamage 1;};

_unit setVelocity [0,0,0];

_unit allowDamage false;

// heal unit
if (!isNil 'ACE_medical_fnc_treatmentAdvanced_fullHeal') then {
	[_unit, _unit] call ACE_medical_fnc_treatmentAdvanced_fullHeal;
};
_unit setDamage 0;

// loadout
// From side loadout, otherwise just initialize unit
if !(_sideLoadout isEqualTo '') then {
	//[_unit,_sideLoadout] call loadout_fnc_unit;
	_unit setVariable ["unit_loadout_faction",_sideLoadout,true];
} else {
	//[_unit] call loadout_fnc_unit;
};

// disable simulation to avoid weird bugs
_unit enableSimulation false;

//--- move unit to location
private _i = 0;
waitUntil {
	_i = _i + 1;
	if (_i > 10) exitWith {
		true
	};
	call {

		// if location is array
		if (_sideLoc isEqualType []) exitWith {

			// if array has 3 elements, it's a ASL pos
			if ((count _sideLoc) isEqualTo 3) exitWith {
				_unit setPosASL _sideLoc;
				true
			};
			if ((count _sideLoc) isEqualTo 2) then {
				_sideLoc = _sideLoc select 0;
			};

			// it's an marker array or a inArea array
			_unit setPos (_sideLoc call CBA_fnc_randPosArea);
			true
		};

		// if it's a marker
		if (_sideLoc isEqualType '') exitWith {
			_unit setPos (getMarkerPos _sideLoc);
			true
		};

		// if it's a object
		if (_sideLoc isEqualType objNull) exitWith {

			// if it has not trigger area, it's a normal object
			if ((triggerArea _sideLoc) isEqualTo []) exitWith {
				_unit setPosASL (getposASL _sideLoc);
				true
			};

			// there msut be a area, so it's a trigger, call randposArea
			private _height = (getposASL _sideLoc)select 2;
			private _pos = (_sideLoc call CBA_fnc_randPosArea);
			_pos set [2,_height];
			_unit setPosASL _pos;
			true
		};

		// if it's a location call randpos area
		if (_sideLoc isEqualType locationNull) exitWith {
			private _height = (getposASL _sideLoc)select 2;
			private _pos = (_sideLoc call CBA_fnc_randPosArea);
			_pos set [2,_height];
			_unit setPosASL _pos;
			true
		};

		// if no position found, kill player
		systemChat 'No position found for respawn';
		false
	};
};

// if player didn't get a position in 10 tries, kill him.
if (_i > 10) exitWith {
	_unit setDamage 1;
};

_unit setVelocity [0,0,0];
_unit allowDamage true;

// enable simulation to avoid weird bugs
_unit enableSimulation true;

// AO code
private _aoName = missionNamespace getVariable ['mission_round_aoName',''];
private _aoCodeFile = format ["plugins\round\code\%1.sqf",_aoName];

private _onRoundPrepCodeAO = {};
if (_aoCodeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _aoCodeFile;
	_unit call _onRoundPrepCodeAO;
};


// location code
private _locCodeFile = format ["plugins\round\code\loc_%1.sqf",_sideLocNR];

private _onRoundPrepCodeLoc = {};
if (_locCodeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _locCodeFile;
	[_unit,_sideLocNR] call _onRoundPrepCodeLoc;
};


// side code
_sideName = toLower _sideName;

private _codeFile = format ["plugins\round\code\%1.sqf",_sideName];

private _onRoundPrepCodeSide = {};
if (_codeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _codeFile;
	_unit call _onRoundPrepCodeSide;
};

// client code
private _clientCodeFile = "plugins\round\code\client.sqf";

private _onRoundPrepCode = {};
if (_clientCodeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _clientCodeFile;
	_unit call _onRoundPrepCode;
};

//--- save forced friendlies (for score)
player setVariable ['unit_score_forcedFriends',_sideUnits,true];