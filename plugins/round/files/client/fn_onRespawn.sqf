/* ----------------------------------------------------------------------------
Function: round_fnc_onRespawn

Description:
	shit to run on player when he respawns

Parameters:
0:	_unit	- unit that will respawn
Returns:
	nothing
Examples:
	_unit call round_fnc_onRespawn;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_unit"];

// find player side
private _side = _unit call round_fnc_findPlayerSide;

// get variables from side
private _sideName = _side getVariable ['round_sideName',''];
private _sideLoc = _side getVariable ['round_sideLoc',objNull];
private _sideLocNR = _side getVariable ['round_sideLocNR',99];
private _sideUnits = _side getVariable ['round_sideUnits',[]];
private _sideNr = _side getVariable ['round_sideNr',99];

if (_sideName isEqualTo '') exitWith {};

// AO code
private _aoName = missionNamespace getVariable ['mission_round_aoName',''];
private _aoCodeFile = format ["plugins\round\code\%1.sqf",_aoName];

private _onRespawnCodeAO = {};
if (_aoCodeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _aoCodeFile;
	_unit call _onRespawnCodeAO;
};


// location code
private _locCodeFile = format ["plugins\round\code\loc_%1.sqf",_sideLocNR];

private _onRespawnCodeLoc = {};
if (_locCodeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _locCodeFile;
	_unit call _onRespawnCodeLoc;
};


// side code
_sideName = toLower _sideName;

private _codeFile = format ["plugins\round\code\%1.sqf",_sideName];

private _onRespawnCodeSide = {};
if (_codeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _codeFile;
	_unit call _onRespawnCodeSide;
};


// client code
private _clientCodeFile = "plugins\round\code\client.sqf";

private _onRespawnCode = {};
if (_clientCodeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _clientCodeFile;
	_unit call _onRespawnCode;
};
