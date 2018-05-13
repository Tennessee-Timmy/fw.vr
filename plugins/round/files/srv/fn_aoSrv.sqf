/* ----------------------------------------------------------------------------
Function: round_fnc_aoSrv

Description:
	Server AO choosing script
	also waits aoWait time

Parameters:
0:	_disableVoting		<bool>		- true to choose a random AO instead of voting for one

Returns:
	nothing

Examples:
	call round_fnc_aoSrv;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
if !(isServer) exitWith {};

params [['_disableVoting',false]];

// override for disabling voting for this mission
private _disableVotingMission = missionNamespace getVariable ['mission_round_disableVoting',false];

// change parameter based on mission variable
if (_disableVotingMission) then {
	 _disableVoting = true;
};

// set stage
missionNamespace setVariable ['mission_round_stage','aoVote',true];

// get variables
private _playedRounds = missionNamespace getVariable ["mission_rounds_played",0];
private _sidesActive = missionNamespace getVariable ["mission_round_sides_active",[]];
private _sidesCount = count _sidesActive;
private _ao = missionNamespace getVariable ["mission_round_aoList",ROUND_SETTING_AOLIST];

_ao call round_fnc_markersSrv;

private _aoCount = (count _ao);
private _aoWait = missionNamespace getVariable ['mission_round_aoWait',ROUND_SETTING_AOWAIT];
private _chosenAO = '';

call {
	if (_aoCount <= 1 || _disableVoting) exitWith {};

	remoteExec ['round_fnc_vote'];

	// loop for ao wait time
	for '_i' from _aoWait to 0 step -1 do {
		sleep 1;
		missionNamespace setVariable ['mission_round_toAO',_i,true];


		// check for forced ao (by admin)
		private _forcedAO = missionNamespace getVariable ['mission_round_aoForced',''];
		if !(_forcedAO isEqualTo '') exitWith {
			_chosenAO = _forcedAO;
		};

		// add more voters
		remoteExec ['round_fnc_vote'];
	};


	// get the chosenAO
	_chosenAO = call {

		// if chosenAO is not empty, it was forced, so exit.
		if !(_chosenAO isEqualTo '') exitWith {_chosenAO};


		// create votes array - ['name',0(votes)]
		private _votes = _ao apply {
			[(_x param [0,'']),0]
		};


		// loop through playerlist
		private _nil = {
			private _vote = _x getVariable ['unit_round_aoVote',''];

			// loop through all the votes
			{
				_x params ['_aoName','_aoVotes'];

				// compare the player vote to the vote in votes array, add 1 if matched
				if (_aoName isEqualTo _vote) exitWith {
					_votes set [_forEachIndex,[_aoName,(_aoVotes + 1)]];
				};
			} forEach _votes;

			false
		} count PLAYERLIST;


		// select random winner (in case we have no votes)
		private _top = ((selectRandom _votes)select 0);
		private _topVotes = 0;

		// loop through all votes and decide which one has most votes
		private _nil = {
			_x params ['_aoName','_aoVotes'];
			if (_aoVotes > _topVotes) then {
				_top = _aoName;
				_topVotes = _aoVotes;
			};
			false
		} count _votes;

		// return the top aka. winner
		_top
	};
};

// get full chosen array
private _currentAO = (_ao select {_x param [0,''] isEqualTo _chosenAO})param [0,[]];

// make sure currentAO was selected correctly
if (!(_currentAO isEqualType []) || {_currentAO isEqualTo []}) then {

	// if ao was incorrect, select a random one instead
	_currentAO = selectRandom _ao;
};

private _currentName = _currentAO select 0;
private _currentLoc = _currentAO select 1;
private _currentMarker = _currentAO select 2;

// AO name
private _aoName = _currentName;
private _aoCodeFile = format ["plugins\round\code\%1.sqf",_aoName];

private _aoTitleText = '';
if (_aoCodeFile call mission_fnc_checkFile) then {
	// load the file
	call compile preprocessFileLineNumbers _aoCodeFile;
};
if (_aoTitleText isEqualTo '') then {
	_aoTitleText = _aoName;
};

missionNamespace setVariable ['mission_round_msg',(format ['%1 wins the vote!',_aoTitleText])];

missionNamespace setVariable ['mission_round_aoName',_currentName,true];
missionNamespace setVariable ['mission_round_aoMarker',_currentMarker,true];
missionNamespace setVariable ['mission_round_loc',_currentLoc,true];
missionNamespace setVariable ['mission_round_aoArr',_currentAO,true];

[_currentAO] call round_fnc_markersSrv;

// todo this should probably be manually done by mission maker in the proper places
/*
private _zones = missionNamespace getVariable ['mission_safe_restrict_zones_west',[]];
_zones append _currentLoc;
missionNamespace setVariable ['mission_safe_restrict_zones_west',_zones,true];
missionNamespace setVariable ['mission_safe_restrict_zones_east',_zones,true];
missionNamespace setVariable ['mission_safe_restrict_zones_guer',_zones,true];
missionNamespace setVariable ['mission_safe_restrict_zones_civi',_zones,true];*/