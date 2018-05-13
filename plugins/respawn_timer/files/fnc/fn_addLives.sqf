/* ----------------------------------------------------------------------------
Function: respawn_timer_fnc_addLives

Description:
	Adds lives to player
Parameters:
0:	_unit	- unit that will get the lives
1:	_addLives	- how many lives to add
Returns:
	nothing
Examples:
	[_unit,1] call respawn_timer_fnc_addLives;
	// to add lives on remote client
	[_unit,1] remoteExec ["respawn_timer_fnc_addLives", _unit];
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_unit",["_addLives",1]];


// Get respawn deafult lives from missionNamespace if it's not defined, use the settings time
private _defaultLives = missionNamespace getVariable ["respawn_timer_lives",RESPAWN_TIMER_PARAM_LIVES];

// Check how many lives we have left
private _timerLives = ["unit_respawn_timer_lives",_defaultLives] call seed_fnc_getVars;

// update the lives
["unit_respawn_timer_lives",(_timerLives + _addLives)] call seed_fnc_setVars;
