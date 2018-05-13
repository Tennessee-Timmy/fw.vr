/* ----------------------------------------------------------------------------
Function: round_fnc_saveAO

Description:
	Saves the ao buildings and stuff

Parameters:
	none
Returns:
	nothing
Examples:
	call round_fnc_saveAO;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

if !(isServer) exitWith {};

private _ao = missionNamespace getVariable ["mission_round_aoList",ROUND_SETTING_AOLIST];

private _nil = {
	private _marker = _x param [2,'ao'];
	private _aoName = _x param [0,''];

	// save current ao objects
	private _stuff = ((((allMissionObjects "" + nearestTerrainObjects[(getMarkerPos _marker),['CHURCH','CHAPEL','BUNKER','FORTRESS','VIEW-TOWER','LIGHTHOUSE','FUELSTATION','HOSPITAL','FENCE','WALL','BUSSTOP','TRANSMITTER','TOURISM','WATERTOWER','POWERSOLAR','POWERWIND','building','house'],5000,false]) inAreaArray _marker) - allUnits - allDead)select {(((toLower(typeOf _x)) find 'emptydet') isEqualTo -1 && !(typeOf _x isEqualTo ''))}) apply {
		[
			_x,
			vehicleVarName _x,
			typeOf _x,
			(getPosASL _x),
			[
				(vectorDir _x),
				(vectorUp _x)
			],[
				(itemCargo _x),
				(weaponCargo _x),
				(magazineCargo _x),
				(backPackCargo _x)
			],[
				(isDamageAllowed _x),
				(simulationEnabled _x),
				(damage _x)
			]
		]
	};

	private _varName = format ['mission_round_savedAO_%1',_aoName];
	missionNamespace setVariable [_varName,_stuff];
	false
} count _ao;