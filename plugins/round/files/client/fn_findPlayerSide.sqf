/* ----------------------------------------------------------------------------
Function: round_fnc_findPlayerSide

Description:
	Find out what side the player is on

Parameters:
0:	_unit			- unit of which side to find
Returns:
	_side			- side namespace, objNull if no side found
Examples:
	player call round_fnc_findPlayerSide
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

params [['_unit',objNull]];

if (isNull _unit) exitWith {};

// get active sides
private _activeSides = missionNamespace getVariable ["mission_round_sides_active",[]];
if (_activeSides isEqualTo []) exitWith {objNull};

// loop through all sides and find the one the player is in
private _i = _activeSides findIf {
	private _sideUnits = _x getVariable ['round_sideUnits',[]];
	(_unit in _sideUnits)
};

// if no side found return objNull
if (_i isEqualTo -1) exitWith {objNull};

// return side
(_activeSides select _i)