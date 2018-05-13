/* ----------------------------------------------------------------------------
Function: respawn_timer_fnc_playerTimer

Description:
	runs the timer for player
	respawns players and removes a life
	resets the extra time
TODO:
	Save the lives and time somewhere in server profile or player profile
	Custom dialog for timer
Parameters:
0:	_unit	- unit that will get the respawn timer
Returns:
	nothing
Examples:
	_unit call respawn_timer_fnc_playerTimer;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_unit"];

// init variables
private _noTicketsShown = false;
private _exitWith = false;

// WaitUntil it's time to respawn or the unit is not dead anymore
waitUntil {

	// If we have been told to exit somewhere, exit
	if (_exitWith) exitWith {true};

	// Check if player has respawned already, if so, exit
	if (!(_unit getVariable ["unit_respawn_dead",true])) exitWith {
		_exitWith = true;
		true
	};

	// Check how long the unit has waited
	// todo add nulling of this to respawn Event
	private _waited = ["unit_respawn_timer_waited",0] call seed_fnc_getVars;

	// Get respawn timer time from missionNamespace (new time) if it's not defined, use the settings time
	private _timerTime = missionNamespace getVariable ["respawn_timer_time",RESPAWN_TIMER_PARAM_TIME];

	// Check how long the player has left to wait
	private _timeLeft = _timerTime - _waited;

	// update the time waited
	["unit_respawn_timer_waited",(_waited + 1)] call seed_fnc_setVars;

	// If we have some time left show it
	if (_timeLeft > 0) then {
		private _readableTime = _timeLeft call respawn_fnc_readableTime;
		private _text = format ["<t align='center'>Time until respawn: <br />%1</t>",_readableTime];
		[_text,false,1] call respawn_fnc_deadText;
	} else {
		// Get respawn deafult lives from missionNamespace if it's not defined, use the settings time
		private _defaultLives = missionNamespace getVariable ["respawn_timer_lives",RESPAWN_TIMER_PARAM_LIVES];

		// Check how many lives we have left
		private _timerLives = ["unit_respawn_timer_lives",_defaultLives] call seed_fnc_getVars;

		//if there are no lives, notify and wait 5 seconds
		if (_timerLives <= 0) then {
			if (!_noTicketsShown) then {
				["You are out of respawn tickets!",false,5] call respawn_fnc_deadText;
				_noTicketsShown = true;
			};
		};

		// If we have lives, exitWith a respawn!
		if (_timerLives > 0) exitWith {

			// todo add remove lives to respawn event
			_unit spawn respawn_fnc_respawnUnit;
			_exitWith = true;
			true
		};
	};

	// Wait 1 second(s)
	sleep 1;

	// Stop if player is not dead anymore
	(!(_unit getVariable ["unit_respawn_dead",true]) || _exitWith)
};