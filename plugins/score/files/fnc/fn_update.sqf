/* ----------------------------------------------------------------------------
Function: score_fnc_update

Description:
	Updates the mission score on the server.

Parameters:
0:	_unit			- Unit of which score to change
1:	_newScore			- Array of differences to the score
	0:	_newKills		- Kills to add
	1:	_newTeamKills	- Teamkills to add
	2:	_newCivKills	- Civilian kills to add
	3:	_newDeaths		- Deaths to add
Returns:
	nothing
Examples:
	// Add 1 kill
	[player,[1]] call score_fnc_update;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

if (!isServer) exitWith {
	_this remoteExec ["score_fnc_update",2];
};

params ["_unit",["_newScore",[]]];

// exit if doesn't exist
if (isNil '_unit' || {isNull _unit}) exitWith {};

// check the player name and make sure it's not broken
private _name = name _unit;
if (_name isEqualTo "Error: No vehicle" || _name isEqualTo '') exitWith {};

_newScore params [["_newKills",0],["_newTeamKills",0],["_newCivKills",0],["_newDeaths",0]];

private _scoreList = ["mission_score_list",[]] call seed_fnc_getVars;
private _unitScore = [];
private _unitUID = (getPlayerUID _unit);

// Remove the current unit's score from scorelist
_scoreList = _scoreList select {
	private _uid = _x param [0,""];
	if (_uid isEqualTo _unitUID) then {
		_unitScore = _x;
		false
	} else {
		true
	};
};

// get values from unitscore with defaults defined
_unitScore params [
	["_uid",_unitUID],
	["_name",(name _unit)],
	["_side",(_unit getVariable ["unit_score_side",(side (group _unit))])],
	["_score",[0,0,0,0]]
];
_score params ["_kills","_teamKills","_civKills","_deaths"];

// Create the new unitscore by adding old ones.
_unitScore = [_uid,_name,_side,[
	(_kills + _newKills),
	(_teamKills + _newTeamKills),
	(_civKills + _newCivKills),
	(_deaths + _newDeaths)
]];

// Update the scoreList
_scoreList pushBack _unitScore;
["mission_score_list",_scoreList] call seed_fnc_setVars;
missionNamespace setVariable ["mission_score_list",_scoreList];