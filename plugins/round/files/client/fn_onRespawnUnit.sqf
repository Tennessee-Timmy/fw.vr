/* ----------------------------------------------------------------------------
Function: round_fnc_onRespawnUnit

Description:
	Runs stuff when unit comes out of spectator

Parameters:
0:	_unit	- unit which respawns (local)
Returns:
	nothing
Examples:
	_unit call round_fnc_onRespawnUnit;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_unit"];

//--- move unit to location
private _loc = _unit getVariable ['unit_round_loc',(ROUND_SETTING_AOLIST select 0 select 1)];

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
	//_unit setDamage 1;
	systemChat 'No position found for respawn';
};

_unit setVelocity [0,0,0];


// AO code
private _aoName = missionNamespace getVariable ['mission_round_aoName',''];
private _aoCodeFile = format ["plugins\round\code\%1.sqf",_aoName];

private _onRespawnUnitCodeAO = {};
if (_aoCodeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _aoCodeFile;
	_unit call _onRespawnUnitCodeAO;
};


// location code
private _locnr = _unit getVariable ['unit_round_locnr',99];
private _locCodeFile = format ["plugins\round\code\loc_%1.sqf",_locnr];

private _onRespawnUnitCodeLoc = {};
if (_locCodeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _locCodeFile;
	_unit call _onRespawnUnitCodeLoc;
};


// on respawn unit code from code file
private _side = _unit getVariable ['unit_round_side',''];
_side = toLower _side;

private _codeFile = format ["plugins\round\code\%1.sqf",_side];

private _onRespawnUnitCodeSide = {};
if (_codeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _codeFile;
	_unit call _onRespawnUnitCodeSide;
};



// client code
private _clientCodeFile = "plugins\round\code\client.sqf";

private _onRespawnUnitCode = {};
if (_clientCodeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _clientCodeFile;
	_unit call _onRespawnUnitCode;
};