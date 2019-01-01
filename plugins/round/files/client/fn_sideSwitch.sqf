/* ----------------------------------------------------------------------------
Function: round_fnc_sideSwitch

Description:
	Runs on side switch

Parameters:
	none
Returns:
	nothing
Examples:
	call round_fnc_sideSwitch;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"


// Code begins
if !(hasInterface) exitWith {};

// find player side
private _side = player call round_fnc_findPlayerSide;

// get variables from side
private _sideName = _side getVariable ['round_sideName',''];
private _sideLoc = _side getVariable ['round_sideLoc',objNull];
private _sideLocNR = _side getVariable ['round_sideLocNR',99];
private _sideUnits = _side getVariable ['round_sideUnits',[]];
private _sideNr = _side getVariable ['round_sideNr',99];
private _sideLoadout = _side getVariable ['round_sideLoadout',''];

if (_sideName isEqualTo '') exitWith {player setDamage 1;};

private _unit = player;

// AO code
private _aoName = missionNamespace getVariable ['mission_round_aoName',''];
private _aoCodeFile = format ["plugins\round\code\%1.sqf",_aoName];

private _onSideSwitchCodeAO = {};
if (_aoCodeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _aoCodeFile;
	_unit call _onSideSwitchCodeAO;
};


// location code
private _locCodeFile = format ["plugins\round\code\loc_%1.sqf",_sideLocNR];

private _onSideSwitchCodeLoc = {};
if (_locCodeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _locCodeFile;
	[_unit,_sideLocNR] call _onSideSwitchCodeLoc;
};


// side code
_sideName = toLower _sideName;

private _codeFile = format ["plugins\round\code\%1.sqf",_sideName];

private _onSideSwitchCodeSide = {};
if (_codeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _codeFile;
	_unit call _onSideSwitchCodeSide;
};

// client code
private _clientCodeFile = "plugins\round\code\client.sqf";

private _onSideSwitchCode = {};
if (_clientCodeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _clientCodeFile;
	_unit call _onSideSwitchCode;
};
