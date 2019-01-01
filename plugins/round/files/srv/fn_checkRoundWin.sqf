/* ----------------------------------------------------------------------------
Function: round_fnc_checkRoundWin

Description:
	Ran through loopSrv
	Check to see if there is already a winner for the current round

Parameters:
	none
Returns:
	nothing
Examples:
	call round_fnc_checkRoundWin;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

// wait until round ends
for '_i' from (_roundTime*60) to -6 step -1 do {
	missionNamespace setVariable ['mission_round_toRoundEnd',_i,true];
	private _toRoundEnd = _i;

	if (_roundSides isEqualTo []) exitWith {};

	// check conditions
	private _nil = {
		private _side = _x;
		private _sideName = _side getVariable 'round_sideName';
		private _sideUnits = _side getVariable ['round_sideUnits',[]];
		private _sideWins = _side getVariable ['round_sideWins',0];
		private _sideLocNr = _side getVariable ['round_sideLocNr',0];
		private _aoName = missionNamespace getVariable ['mission_round_aoName',''];


		// round condition code
		private _condCodeFile = "plugins\round\code\cond.sqf";

		private _roundWinCode = {};
		private _roundLoseCode = {};
		private _roundTimeOutCode = {};

		if (_condCodeFile call mission_fnc_checkFile) then {
			// load the file
			call compile preprocessFileLineNumbers _condCodeFile;
			if (_i <= 0 && (_timeOutCodeRan > 0)) then {

				// msg
				private _timeOutMsg = "Time's up!";

				// timeout code
				call _roundTimeOutCode;

				// send out timeout message
				missionNamespace setVariable ['mission_round_msg',_timeOutMsg,true];

				_timeOutCodeRan = _timeOutCodeRan - 1;
			};

			// call so I can use exitWith so it will only fail or only succeed
			call {
				// check lose code
				if ((call _roundLoseCode) isEqualTo true) exitWith {
					_roundSides deleteAt _forEachIndex;
					_roundLosers = _roundLosers + 1;
				};

				//check condition for winning and check the amount of losers (if all other teams lost, we win)
				if (((call _roundWinCode) isEqualTo true) || (_roundLosers isEqualTo (_activeCount - 1))) exitWith {
					missionNamespace setVariable ['mission_round_roundWinner',_sideName,true];
					[_sideName,'wins',1] call round_fnc_updateSideData;
					_side setVariable ['round_sideWins',(_sideWins + 1),true];
					_roundOver = true;
					_winner = _sideName;

					// save winner side
					missionNamespace setVariable ['mission_round_roundWinnerSide',_side,true];
				};
			};
		};
		if (_roundOver) exitWith {};
	} forEach _roundSides;
	if (_roundOver) exitWith {};
	sleep 1;

	private _addTime = missionNamespace getVariable 'mission_round_timeAdd';
	if (!isNil '_addTime') then {
		_i = _i + _addTime;
		missionNamespace setVariable ['mission_round_timeAdd',nil];
	};

	private _replaceTime = missionNamespace getVariable 'mission_round_timeReplace';
	if (!isNil '_replaceTime') then {
		_i = _replaceTime;
		missionNamespace setVariable ['mission_round_timeReplace',nil];
	};
};
