/* ----------------------------------------------------------------------------
Function: cleaner_fnc_cleanUp

Description:
	Cleans dead vehicles and bodies

Parameters:
	none
Returns:
	nothing
Examples:
	call cleaner_fnc_cleanUp
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

private _bads = missionNamespace getVariable ["mission_cleaner_badsList",CLEANER_SETTINGS_BADS];
private _cleanUp_distanceToPlayerBad = missionNamespace getVariable ["mission_cleaner_distBad",1000];
private _players = PLAYERLIST;
private _missionBads = [];
private _allMissionObjects = entities "";
private _vehicles = vehicles;

{if (typeOf _x in _bads && !(_x getVariable ['unit_cleaner_disabled',false]))then {_missionBads pushBack _x;};true}count _allMissionObjects;
{if (typeOf _x in _bads && !(_x getVariable ['unit_cleaner_disabled',false]))then {_missionBads pushBack _x;};true}count _vehicles;

// Loop through all mission bad
private _nil = {
	private _badsDistance = _cleanUp_distanceToPlayerBad;
	if (count _missionBads > 300) then {_badsDistance = 10};
	if (count _missionBads > 100) then {_badsDistance = _badsDistance / 20};
	if (count _missionBads > 75) then {_badsDistance = _badsDistance / 10};
	if (count _missionBads > 50) then {_badsDistance = _badsDistance / 4};
	if (count _missionBads > 25) then {_badsDistance = _badsDistance / 2};
	_badBoy = _x;
	_close = false;
	{
		if (_badBoy distance _x < _badsDistance) exitWith {_close = true;};
	} count _players;
	if (!_close) then {
		deleteVehicle _badBoy;
		_missionBads = _missionBads - [_badBoy];
	};
}count _missionBads;