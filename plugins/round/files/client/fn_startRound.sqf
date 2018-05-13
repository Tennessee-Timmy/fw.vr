/* ----------------------------------------------------------------------------
Function: round_fnc_startRound

Description:
	Start the round for client

Parameters:
	none
Returns:
	nothing
Examples:
	call round_fnc_startRound;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

// Code begins
if !(hasInterface) exitWith {};

private _unit = player;


// AO code
private _aoName = missionNamespace getVariable ['mission_round_aoName',''];
private _aoCodeFile = format ["plugins\round\code\%1.sqf",_aoName];

private _onRoundStartCodeAO = {};
if (_aoCodeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _aoCodeFile;
	_unit call _onRoundStartCodeAO;
};

// location code
private _locnr = _unit getVariable ['unit_round_locnr',99];
private _locCodeFile = format ["plugins\round\code\loc_%1.sqf",_locnr];

private _onRoundStartCodeLoc = {};
if (_locCodeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _locCodeFile;
	_unit call _onRoundStartCodeLoc;
};

// side code
private _side = _unit getVariable ['unit_round_side',''];
_side = toLower _side;

private _codeFile = format ["plugins\round\code\%1.sqf",_side];

private _onRoundStartCodeSide = {};
if (_codeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _codeFile;
	_unit call _onRoundStartCodeSide;
};

// client code
private _clientCodeFile = "plugins\round\code\client.sqf";

private _onRoundStartCode = {};
if (_clientCodeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _clientCodeFile;
	_unit call _onRoundStartCode;
};