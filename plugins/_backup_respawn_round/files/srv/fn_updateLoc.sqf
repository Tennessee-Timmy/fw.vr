/* ----------------------------------------------------------------------------
Function: respawn_round_fnc_updateLoc

Description:
	updates the sides

Parameters:
	none
Returns:
	_activeseids		- array of sides that are active
Examples:
	call respawn_round_fnc_updateLoc;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
if !(isServer) exitWith {};

// get variables
private _playedRounds = missionNamespace getVariable ["mission_respawn_rounds_played",0];
private _sidesActive = missionNamespace getVariable ["mission_respawn_round_sides_active",[]];
private _sidesCount = count _sidesActive;
private _loc = missionNamespace getVariable ["mission_respawn_round_loc",RESPAWN_ROUND_SETTING_LOC];
private _locCount = (count _loc);
private _locSwitch = missionNamespace getVariable ["mission_respawn_round_locSwitch",RESPAWN_ROUND_SETTING_LOCSWITCH];

// locked sides
private _lockedSide = missionNamespace getVariable ['mission_respawn_round_sidesLocked',RESPAWN_ROUND_SETTING_SIDELOCKED];

// exit if sides active empty
if (_sidesActive isEqualTo []) exitWith {};

// loop through the sides
for '_i' from 1 to _sidesCount do {
	private _side = _sidesActive select (_i-1);

	// get variables
	private _sideName = toLower(_side param [0,'']);
	private _sideData = _side param [2];
	private _sideNR = _sideData param [0,0];
	private _sideUnits = _side param [1,[]];
	private '_locNR';
	private '_sideLoc';

	// check for locked
	private _nil = {
		_x params ['_lockedName','_lockedLoc',['_lockedNr',99]];
		if ((toLower _lockedName) isEqualTo _sideName && ((!isNil '_lockedLoc'))) then {
			_locNR = _lockedNr;
			_sideLoc = _lockedLoc;
		};
		false
	} count _lockedSide;

	if (isNil '_locNR') then {
		// locnr is sidenr + played rounds mod location count
		_locNR = ((_sideNR + (_playedRounds/_locSwitch)) mod (_locCount));
		_sideLoc = (_loc param [_locNR]);
	};

	_sideData set [2,_locNR];

	private _nil = {
		private _unit = _x;
		_unit setVariable ['unit_respawn_round_loc',_sideLoc,true];
		_unit setVariable ['unit_respawn_round_locnr',_locNR,true];
		false
	} count _sideUnits;
	false
};