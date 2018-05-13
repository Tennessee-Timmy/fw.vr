/* ----------------------------------------------------------------------------
Function: respawn_round_fnc_startRound

Description:
	Start the round for client

Parameters:
	none
Returns:
	nothing
Examples:
	call respawn_round_fnc_startRound;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

// Code begins
if !(hasInterface) exitWith {};

private _unit = player;

// side code
private _side = _unit getVariable ['unit_respawn_round_side',''];
_side = toLower _side;

private _codeFile = format ["plugins\respawn_round\code\%1.sqf",_side];

private _onRoundStartCodeSide = {};
if (_codeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _codeFile;
	_unit call _onRoundStartCodeSide;
};


// location code
private _locnr = _unit getVariable ['unit_respawn_round_locnr',99];
private _locCodeFile = format ["plugins\respawn_round\code\loc_%1.sqf",_locnr];

private _onRoundStartCodeLoc = {};
if (_locCodeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _locCodeFile;
	_unit call _onRoundStartCodeLoc;
};

// client code
private _clientCodeFile = "plugins\respawn_round\code\client.sqf";

private _onRoundStartCode = {};
if (_clientCodeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _clientCodeFile;
	_unit call _onRoundStartCode;
};