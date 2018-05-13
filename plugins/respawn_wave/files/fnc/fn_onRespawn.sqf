/* ----------------------------------------------------------------------------
Function: respawn_wave_fnc_onRespawn

Description:
	Request respawn timer on the server
	Respawns unit if respawn timer currently in the respawn window
	Spawns respawn_fnc_wave_playerTimer
Parameters:
0:	_unit	- unit that will respawn
Returns:
	nothing
Examples:
	_unit call respawn_wave_fnc_onRespawn;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_unit"];

// Get/set unit side
private _unitSide = _unit call respawn_fnc_getSetUnitSide;

// choose player side based on settings
_unitSide = call {
	if (_unitSide isEqualTo west) then {
		missionNamespace getVariable ['mission_respawn_wave_side_west',RESPAWN_WAVE_SETTING_SIDE_WEST];
	};
	if (_unitSide isEqualTo east) then {
		missionNamespace getVariable ['mission_respawn_wave_side_east',RESPAWN_WAVE_SETTING_SIDE_EAST];
	};
	if (_unitSide isEqualTo resistance) then {
		missionNamespace getVariable ['mission_respawn_wave_side_guer',RESPAWN_WAVE_SETTING_SIDE_GUER];
	};
	if (_unitSide isEqualTo civilian) then {
		missionNamespace getVariable ['mission_respawn_wave_side_civi',RESPAWN_WAVE_SETTING_SIDE_CIVI];
	};

	// default to west
	west
};

// get individual side and override
_unitSide = _unit getVariable ['unit_respawn_wave_side',_unitSide];


// Check if respawn wave has already been requested for _unitSide
private _requestedVar = format ["respawn_wave_requested_%1",_unitSide];
private _requested = missionNamespace getVariable [_requestedVar,false];

// If wave is already requested, check if it's done yet
if !(_requested) then {

	// wave has not been requested, request it!
	missionNamespace setVariable [_requestedVar,true,true];
};

// Show time 'til respawn
if (_unit getVariable ["unit_respawn_dead",true]) then {
	_unit spawn respawn_wave_fnc_playerTimer;
};