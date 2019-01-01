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

// find player side
private _side = _unit call round_fnc_findPlayerSide;

// heal
[_unit, _unit] call ACE_medical_fnc_treatmentAdvanced_fullHeal;

// get variables from side
private _sideName = _side getVariable ['round_sideName',''];
//private _sideLoc = _side getVariable ['round_sideLoc',stage];
private _sideLoc = stage;
private _sideLocNR = _side getVariable ['round_sideLocNR',99];
private _sideUnits = _side getVariable ['round_sideUnits',[]];
private _sideNr = _side getVariable ['round_sideNr',99];

//--- move unit to location

call {

	// if location is array
	if (_sideLoc isEqualType []) exitWith {

		// if array has 3 elements, it's a ASL pos
		if ((count _sideLoc) isEqualTo 3) exitWith {
			_unit setPosASL _sideLoc;
		};
		if ((count _sideLoc) isEqualTo 2) then {
			_sideLoc = _sideLoc select 0;
		};

		// it's an marker array or a inArea array
		_unit setPos (_sideLoc call CBA_fnc_randPosArea);
	};

	// if it's a marker
	if (_sideLoc isEqualType '') exitWith {
		_unit setPos (getMarkerPos _sideLoc);
	};

	// if it's a object
	if (_sideLoc isEqualType objNull) exitWith {

		// if it has not trigger area, it's a normal object
		if ((triggerArea _sideLoc) isEqualTo []) exitWith {
			_unit setPosASL (getposASL _sideLoc);
		};

		// there msut be a area, so it's a trigger, call randposArea
		private _height = (getposASL _sideLoc)select 2;
		private _pos = (_sideLoc call CBA_fnc_randPosArea);
		_pos set [2,_height];
		_unit setPosASL _pos;
	};

	// if it's a location call randpos area
	if (_sideLoc isEqualType locationNull) exitWith {
		private _height = (getposASL _sideLoc)select 2;
		private _pos = (_sideLoc call CBA_fnc_randPosArea);
		_pos set [2,_height];
		_unit setPosASL _pos;
	};

	// if no position found, kill player
	//_unit setDamage 1;
	systemChat 'No position found for respawn';
};


if (_sideName isEqualTo '') exitWith {};
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
private _locCodeFile = format ["plugins\round\code\loc_%1.sqf",_sideLocNR];

private _onRespawnUnitCodeLoc = {};
if (_locCodeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _locCodeFile;
	_unit call _onRespawnUnitCodeLoc;
};


// on respawn unit code from code file
_sideName = toLower _sideName;

private _codeFile = format ["plugins\round\code\%1.sqf",_sideName];

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


private _stage = missionNamespace getVariable ['mission_round_stage',''];
if (_stage in ['prep','live']) then {
	_unit call round_fnc_prepRound;

	if (_stage isEqualTo 'live') then {
		_unit call round_fnc_startRound;
	};
};