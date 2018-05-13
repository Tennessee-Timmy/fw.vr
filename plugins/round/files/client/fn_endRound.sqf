/* ----------------------------------------------------------------------------
Function: round_fnc_endRound

Description:
	End the round for client

Parameters:
	none
Returns:
	nothing
Examples:
	call round_fnc_endRound;
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

private _onRoundEndCodeAO = {};
if (_aoCodeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _aoCodeFile;
	_unit call _onRoundEndCodeAO;
};

// location code
private _locnr = _unit getVariable ['unit_round_locnr',99];
private _locCodeFile = format ["plugins\round\code\loc_%1.sqf",_locnr];

private _onRoundEndCodeLoc = {};
if (_locCodeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _locCodeFile;
	_unit call _onRoundEndCodeLoc;
};


// side code
private _side = _unit getVariable ['unit_round_side',''];
_side = toLower _side;

private _codeFile = format ["plugins\round\code\%1.sqf",_side];

private _onRoundEndCodeSide = {};
if (_codeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _codeFile;
	_unit call _onRoundEndCodeSide;
};


// client code
private _clientCodeFile = "plugins\round\code\client.sqf";

private _onRoundEndCode = {};
if (_clientCodeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _clientCodeFile;
	_unit call _onRoundEndCode;
};

[] spawn {
	private '_winner';
	waitUntil {
		_winner = missionNamespace getVariable 'mission_round_roundWinner';
		!isNil '_winner'
	};
	if (_winner isEqualTo 'tie') exitWith {
		missionNamespace setVariable ['mission_round_msg',("It's a tie! Everyone loses!")];
	};

	private _sidePlayer = player getVariable ['unit_round_side',''];
	private _color = "#aa5a00";
	if ((toLower _winner) isEqualTo (toLower _sidePlayer)) then {
		_color = "#005aaa";
	};
	missionNamespace setVariable ['mission_round_msg',(format ['<t color=%2>%1</t> wins the round!',_winner, (str _color)])];
};