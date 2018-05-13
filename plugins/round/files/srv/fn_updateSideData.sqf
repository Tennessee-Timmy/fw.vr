/* ----------------------------------------------------------------------------
Function: round_fnc_updateSideData

Description:
	updates the side data

Parameters:
0:	_side		- side to update
1:	_name		- what to update
2:	_value		- What value to give to update

Returns:
	nothing
Examples:
	// options for non direct variable:
	'wins'			- add _value amount of wins
	'unitsAdd'		- add _value (array) of units
	'unitsRem'		- remove _value (array) of units
	'units'			- replace _value (array) for units

	// add 1 win
	['BLUFOR','wins',1] call round_fnc_updateSideData;

	// set to 2 wins
	['BLUFOR','round_sideWins',2] call round_fnc_updateSideData;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
if !(isServer) exitWith {};

params ['_side','_name','_value'];

private _sidesActive = missionNamespace getVariable "mission_round_sides_active";
if (isNil '_sidesActive') exitWith {};
private _foundSide = [];

{
	private _sideName =  _x param [0,''];
	if (_sideName isEqualTo _side) exitWith {
		_foundSide = _sidesActive select _forEachIndex;
	};
} forEach _sidesActive;

if (_foundSide isEqualTo []) exitWith {};

private _sideName = _foundSide getVariable 'round_sideName';
private _sideUnits = _foundSide getVariable ['round_sideUnits',[]];
private _sideWins = _foundSide getVariable ['round_sideWins',0];
private _sideNr = _foundSide getVariable ['round_sideNr',99];
private _sideLocNr = _foundSide getVariable ['unit_round_locnr',99];


call {
	if (_name isEqualTo 'wins') exitWith {

		_sideWins = _sideWins + _value;
		_sideData set [1,_sideWins];
	};
	if (_name isEqualTo 'unitsAdd') exitWith {

		_sideUnits append _value;
		_foundSide setVariable ['round_sideUnits',_sideUnits,true];
	};
	if (_name isEqualTo 'unitsRem') exitWith {

		_sideUnits = _sideUnits - _value;
		_foundSide setVariable ['round_sideUnits',_sideUnits,true];
	};
	if (_name isEqualTo 'units') exitWith {

		_sideUnits = _value;
		_foundSide setVariable ['round_sideUnits',_sideUnits,true];
	};
	_foundSide setVariable [_name,_value,true];
};

private _updatedSide = [_sideName,_sideUnits,_sideData];
_sidesActive pushBack _updatedSide;
missionNamespace setVariable ["mission_round_sides_active",_sidesActive];