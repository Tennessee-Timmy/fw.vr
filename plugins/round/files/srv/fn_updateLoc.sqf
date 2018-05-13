/* ----------------------------------------------------------------------------
Function: round_fnc_updateLoc

Description:
	updates the sides

Parameters:
0:	_noAdd				- will just update current locations, won't add a new nr

Returns:
	_activeseids		- array of sides that are active
Examples:
	call round_fnc_updateLoc;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
if !(isServer) exitWith {};

params[['_noAdd',false]];

// get variables
private _playedRounds = missionNamespace getVariable ["mission_rounds_played",0];
private _sidesActive = missionNamespace getVariable ["mission_round_sides_active",[]];
private _sidesCount = count _sidesActive;
private _loc = missionNamespace getVariable ["mission_round_loc",(ROUND_SETTING_AOLIST select 0 select 1)];
private _locCount = (count _loc);
private _locSwitch = missionNamespace getVariable ["mission_round_locSwitch",ROUND_SETTING_LOCSWITCH];

// locked sides
private _lockedSide = missionNamespace getVariable ['mission_round_sidesLocked',ROUND_SETTING_SIDELOCKED];

// exit if sides active empty
if (_sidesActive isEqualTo []) exitWith {};

// loop through the sides
for '_i' from 1 to _sidesCount do {
	private _side = _sidesActive select (_i-1);

	// get variables
	private _sideName = _side getVariable 'round_sideName';
	private _sideUnits = _side getVariable ['round_sideUnits',[]];
	private _sideWins = _side getVariable ['round_sideWins',0];
	private _sideNr = _side getVariable ['round_sideNr',0];

	private '_locNR';
	private '_sideLoc';

	// check for locked
	private _nil = {
		_x params ['_lockedName','_lockedLoc',['_lockedNr',99]];
		if (isNil '_lockedLoc' || {_lockedLoc isEqualTo ''}) then {
			_lockedLoc = (_loc param [_lockedNr]);
		};
		if ((toLower _lockedName) isEqualTo _sideName && ((!isNil '_lockedLoc'))) then {
			_locNR = _lockedNr;
			_sideLoc = _lockedLoc;
		};
		false
	} count _lockedSide;

	if (isNil '_locNR') then {

		if (_noAdd) then {
			_locNR = _side getVariable ['round_sideLocNr',(_sideNr mod _locCount)];
		} else {
			// locnr is sidenr + played rounds mod location count
			_locNR = ((_sideNr + (_playedRounds/_locSwitch)) mod (_locCount));
		};
		_sideLoc = (_loc param [_locNR]);
	};

	_side setVariable ['round_sideLocNr',_locNR,true];

	// todo might not be needed because of ^
	private _nil = {
		private _unit = _x;
		_unit setVariable ['unit_round_loc',_sideLoc,true];
		_unit setVariable ['unit_round_locnr',_locNR,true];
		false
	} count _sideUnits;
	false
};