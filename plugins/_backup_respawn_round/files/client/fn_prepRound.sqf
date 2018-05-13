/* ----------------------------------------------------------------------------
Function: respawn_round_fnc_prepRound

Description:
	Prepares the round for client
	heals, moves to location and runs prep codes

Parameters:
	none
Returns:
	nothing
Examples:
	call respawn_round_fnc_prepRound;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

// Code begins
if !(hasInterface) exitWith {};

private _waited = 0;
// wait for respawn
waitUntil {
	_waited = _waited + 1;
	if (_waited > 100) exitWith {true};
	!(player call respawn_fnc_deadCheck)
};

// exit if waited 1k frames (100/30fps = ~3 seconds)
if (_waited > 100) exitWith {};

private _unit = player;

_unit allowDamage false;

// heal unit
if (!isNil 'ACE_medical_fnc_treatmentAdvanced_fullHeal') then {
	[_unit, _unit] call ACE_medical_fnc_treatmentAdvanced_fullHeal;
};
_unit setDamage 0;

// loadout
[_unit] call loadout_fnc_unit;

//--- move unit to location
private _loc = _unit getVariable ['unit_respawn_round_loc',(RESPAWN_ROUND_SETTING_LOC param [0])];

call {

	// if location is array
	if (_loc isEqualType []) exitWith {

		// if array has 3 elements, it's a ASL pos
		if ((count _loc) isEqualTo 3) exitWith {
			_unit setPosASL _loc;
		};
		if ((count _loc) isEqualTo 2) then {
			_loc = _loc select 0;
		};

		// it's an marker array or a inArea array
		_unit setPos (_loc call CBA_fnc_randPosArea);
	};

	// if it's a marker
	if (_loc isEqualType '') exitWith {
		_unit setPos (getMarkerPos _loc);
	};

	// if it's a object
	if (_loc isEqualType objNull) exitWith {

		// if it has not trigger area, it's a normal object
		if ((triggerArea _loc) isEqualTo []) exitWith {
			_unit setPosASL (getposASL _loc);
		};

		// there msut be a area, so it's a trigger, call randposArea
		private _height = (getposASL _loc)select 2;
		private _pos = (_loc call CBA_fnc_randPosArea);
		_pos set [2,_height];
		_unit setPosASL _pos;
	};

	// if it's a location call randpos area
	if (_loc isEqualType locationNull) exitWith {
		private _height = (getposASL _loc)select 2;
		private _pos = (_loc call CBA_fnc_randPosArea);
		_pos set [2,_height];
		_unit setPosASL _pos;
	};

	// if no position found, kill player
	_unit setDamage 1;
	systemChat 'No position found for respawn';
};

//--- save forced friendlies (for score)
call {

	// get current active sides
	private _sides = (missionNamespace getVariable ['mission_respawn_round_sides_active',[]]);

	// get player side
	private _side = player getVariable ['unit_respawn_round_side',''];
	_sidePlayer = toLower _side;

	// loop through sides
	private _nil = {
		private _side = _x;
		_side params [['_sideName',''],'_sideUnits',['_sideData',[0,0]]];

		// if side name is same as player side name, update forcedfriends for player
		if ((toLower _sideName) isEqualTo _sidePlayer) exitWith {
			player setVariable ['unit_score_forcedFriends',_sideUnits,true];
		};
		false
	} count _sides;
};

_unit allowDamage true;

// location code
private _locnr = _unit getVariable ['unit_respawn_round_locnr',99];
private _locCodeFile = format ["plugins\respawn_round\code\loc_%1.sqf",_locnr];

private _onPrepCodeLoc = {};
if (_locCodeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _locCodeFile;
	_unit call _onPrepCodeLoc;
};


// side code
private _side = _unit getVariable ['unit_respawn_round_side',''];
_side = toLower _side;

private _codeFile = format ["plugins\respawn_round\code\%1.sqf",_side];

private _onPrepCodeSide = {};
if (_codeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _codeFile;
	_unit call _onPrepCodeSide;
};

// client code
private _clientCodeFile = "plugins\respawn_round\code\client.sqf";

private _onPrepCode = {};
if (_clientCodeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _clientCodeFile;
	_unit call _onPrepCode;
};