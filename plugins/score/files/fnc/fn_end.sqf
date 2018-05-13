/* ----------------------------------------------------------------------------
Function: score_fnc_End

Description:
	Runs on end for clients. Changes ending screen text

Parameters:
	none
Returns:
	nothing
Examples:
	call score_fnc_End;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

if !(hasInterface) exitWith {};


// personal end screen
private _playerUID = getPlayerUID player;
private _name = name player;
private _scores = missionNamespace getVariable ["mission_score_list",[]];

// Find player score and get the score from it
private _playerScore = (_scores select {(_x param [0,""]) isEqualTo _playerUID})param [0,[]];
private _score = _playerScore param [3,[0,0,0,0]];
_score params [["_kills",0],["_teamKills",0],["_civKills",0],["_deaths",0]];

// texts
private _nameText = format ["
NAME: %1<br/>",_name];
private _killsText = format ["
KILLS: %1<br/>",_kills];
private _tkillsText = format ["
TEAM KILLS: %1<br/>",_teamKills];
private _ckillsText = format ["
CIVILIAN KILLS: %1<br/>",_civKills];
private _deathsText = format ["
DEATHS: %1<br/>",_deaths];
score_text_personal = _nameText + _killsText + _tkillsText + _ckillsText + _deathsText;

// lots of variables that we need in this scope
private _scoreText = "";
private _allScores = [];

private _bestScore = "";
private _bestKills = 0;
private _bestDeaths = 0;

private _worstScore = "";
private _worstTKills = 1;
private _worstDeaths = 0;

private _murderScore = "";
private _murderCKills = 1;
private _murderKills = 0;

private _nul = {
	private _loopside = _x;
	private _sideKills = 0;
	private _sideDeaths = 0;
	private _sideScore = _scores select {
		if ((_x param [2,""]) isEqualTo _loopside) then {
			_x params ["_uid","_name","_side","_score"];
			_score params ["_kills","_teamKills","_civKills","_deaths"];

			_sideKills = _sideKills + _kills;
			_sideDeaths = _sideDeaths + _deaths;

			if (_kills >= _bestKills) then {
				if (_kills > _bestKills || {(_deaths < _bestDeaths)}) then {
					_bestScore = _name;
					_bestKills = _kills;
					_bestDeaths = _deaths;
				};
			};
			if (_teamKills >= _worstTKills && {_teamKills > _worstTKills || _deaths > _worstDeaths}) then {
				_worstScore = _name;
				_worstTKills = _teamKills;
				_worstDeaths = _deaths;
			};
			if (_civKills >= _murderCKills && {_civKills > _murderCKills || _kills > _murderKills}) then {
				_murderScore = _name;
				_murderCKills = _civKills;
				_murderKills = _kills;
			};
			true
		} else {
			false
		};
	};
	private _currentSide = call {
		if (_loopside isEqualTo west) exitWith {
			"<br/>BLUFOR"
		};
		if (_loopside isEqualTo east) exitWith {
			"<br/>OPFOR"
		};
		if (_loopside isEqualTo resistance) exitWith {
			"<br/>INDFOR"
		};
		if (_loopside isEqualTo civilian) exitWith {
			"<br/>CIVILIAN"
		};
	};
	if !(_sideScore isEqualTo []) then {
		private _sideText = format [" - kills: %1 casualties: %2",_sideKills,_sideDeaths];
		_scoreText = _currentSide + _sideText;
	};

	false
} count [west,east,resistance,civilian];

private _bestText = "";
private _worstText = "";
private _murderText = "";

if !(_bestScore isEqualTo "") then {
	_bestText = format ["Most kills: %1 - %2 kills<br/>",_bestScore,_bestKills];
};
if !(_worstScore isEqualTo "") then {
	_worstText = format ["Most TKs: %1 - %2 TKs<br/>",_worstScore,_worstTKills];
};
if !(_murderScore isEqualTo "") then {
	_murderText = format ["Most civilian kills: %1 - %2<br/>",_murderScore,_murderCKills];
};
score_text = _bestText + _worstText + _murderText + _scoreText;