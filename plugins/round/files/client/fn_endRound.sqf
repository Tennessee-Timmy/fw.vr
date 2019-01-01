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

private _onRoundEndCodeAO = {};
if (_aoCodeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _aoCodeFile;
	_unit call _onRoundEndCodeAO;
};

// location code
private _locCodeFile = format ["plugins\round\code\loc_%1.sqf",_sideLocNR];

private _onRoundEndCodeLoc = {};
if (_locCodeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _locCodeFile;
	_unit call _onRoundEndCodeLoc;
};


// side code
_sideName = toLower _sideName;

private _codeFile = format ["plugins\round\code\%1.sqf",_sideName];

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

_sideName spawn {
	private _sideName = param [0,''];
	private '_winner';
	private _i = 0;
	waitUntil {
		_winner = missionNamespace getVariable 'mission_round_roundWinner';
		_i = _i + 1;
		(!isNil '_winner' || _i > 3000)
	};
	if (_winner isEqualTo 'tie') exitWith {
		missionNamespace setVariable ['mission_round_msg',("It's a tie! Everyone loses!")];
	};

	private _color = "#aa5a00";
	if ((toLower _winner) isEqualTo (toLower _sideName)) then {
		_color = "#005aaa";
	};
	missionNamespace setVariable ['mission_round_msg',(format ['<t color=%2>%1</t> wins the round!',_winner, (str _color)])];
};