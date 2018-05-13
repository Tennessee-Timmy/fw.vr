/* ----------------------------------------------------------------------------
Function: respawn_timer_fnc_onRespawn

Description:
	Checks if player has lives remaining and calculates respawn time
	Runs respawn_fnc_playerTimer
Parameters:
0:	_unit	- unit that will respawn
Returns:
	nothing
Examples:
	_unit call respawn_timer_fnc_onRespawn;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_unit"];

// Get respawn deafult lives from missionNamespace if it's not defined, use the settings time
private _defaultLives = missionNamespace getVariable ["respawn_timer_lives",RESPAWN_TIMER_PARAM_LIVES];

// Get player lives from seed
// todo add tickets / remove tickets / check tickets
private _lives = ["unit_respawn_timer_lives",_defaultLives] call seed_fnc_getVars;

// Init text for respawn tickets
private _text = format ["You have %1 respawn tickets",_lives];

// text if no lives remaining
if (_lives isEqualTo 0) then {

	// change text
	_text = "You are out of respawn tickets";
};

// Display remaining respawn tickets text in middle
[_text,true,5] spawn respawn_fnc_deadText;


// Get default respawn time
private _time = missionNamespace getVariable ["unit_respawn_timer",10];

// Get extra time [PERM,TEMP];
// todo fnc to add / remove / reset
private _extraTime = ["unit_respawn_timerExtra",[0,0]] call seed_fnc_getVars;

// Calculate total time
private _totalTime = (_time)+(_extraTime select 0)+(_extraTime select 1);

// Update variables for time and extra
player setVariable ["unit_respawn_timer",_totalTime,true];
[["unit_respawn_timerExtra",[_extraTime select 0,0],true]] call seed_fnc_setVars;

// Run the respawn timer
if (_unit getVariable ["unit_respawn_dead",true]) then {
	_unit spawn respawn_timer_fnc_playerTimer;
};