/* ----------------------------------------------------------------------------
Function: respawn_round_fnc_updateSideData

Description:
	updates the side data

Parameters:
0:	_side		- side to update
1:	_name		- what to update
2:	_value		- What value to give to update

Returns:
	nothing
Examples:
	['BLUFOR','wins',1] call respawn_round_fnc_updateSideData;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
if !(isServer) exitWith {};

params ['_side','_name','_value'];
// Update variables every round

private _sidesActive = missionNamespace getVariable "mission_respawn_round_sides_active";
if (isNil '_sidesActive') exitWith {};
private _foundSide = [];

{
	private _sideName =  _x param [0,''];
	if (_sideName isEqualTo _side) exitWith {
		_foundSide = _sidesActive deleteAt _forEachIndex;
	};
} forEach _sidesActive;

if (_foundSide isEqualTo []) exitWith {};

_foundSide params ['_sideName',['_sideUnits',[]],['_sideData',[]]];
_sideData params [['_sideNum',99],['_sideWins',0],['_sideLocNr',99]];

call {
	if (_name isEqualTo 'wins') exitWith {
		_sideWins = _sideWins + _value;
		_sideData set [1,_sideWins];
	};
};

private _updatedSide = [_sideName,_sideUnits,_sideData];
_sidesActive pushBack _updatedSide;
missionNamespace setVariable ["mission_respawn_round_sides_active",_sidesActive];