/* ----------------------------------------------------------------------------
Function: round_fnc_checkGameWin

Description:
	Ran through loopSrv
	Check to see if there is already a winner

Parameters:
	none

Returns:
	_isOver				- is the game over
Examples:
	call round_fnc_checkGameWin;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

//
// loop through sides to see if we have a side that's won yet or if only 1 side left
private _nil = {
	private _sideName = _x getVariable 'round_sideName';
	private _sideUnits = _x getVariable ['round_sideUnits',[]];
	call {

		// filter sideunits
		_sideUnits = _sideUnits select {
			!isNil '_x' && !isNull _x
		};

		// add to valid sides if the unit array is not empty
		if !(_sideUnits isEqualTo []) then {
			_validSides pushBack _x;
		};

		// get side data to check wins
		private _sideWins = _x getVariable ['round_sideWins',0];

		// compare sidewins to current leader score
		if (_sideWins >= _leadScore) then {

			// get the amount of alive players for side
			private _sideAlive = _sideUnits - _deadArr;
			private _sideAliveCount = count _sideAlive;

			// if this side has more alive than previous leaders
			if (_sideAliveCount >= _leadAlive) then {

				// delete other leadersides
				if (_sideAliveCount > _leadAlive) then {
					_leadSides = [];
					_leadUnits = [];
					_leadAlive = _sideAliveCount;
				};

				// add this side to leaders, update lead units and update lead score
				_leadSides pushBack _x;
				_leadUnits append _sideUnits;
				_leadScore = _sideWins;
			};
		};
	};
	false
} count _activeSides;


// Check if leader score is higher or equal then required win count OR we played roundcount number of rounds
if (((_leadScore >= _roundCountWin) || (_playedRounds isEqualTo _roundCount) || ((count _validSides) <= 1)) && true) exitWith {

	// update winner list
	missionNamespace setVariable ['mission_tasks_winPlayers',_leadUnits,true];

	// end mission
	// todo check fake end
	if (true) then {
		//remoteExec ['round_fnc_fakeEnd'];
	} else {
		//call tasks_fnc_endSrv;
	};

	missionNamespace setVariable ['mission_round_stage','end',true];

	true
};

false