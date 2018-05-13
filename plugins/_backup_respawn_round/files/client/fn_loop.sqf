/* ----------------------------------------------------------------------------
Function: respawn_round_fnc_loop

Description:
	The loop for client

Parameters:
	none
Returns:
	nothing
Examples:
	call respawn_round_fnc_loop;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

// Code begins
if !(hasInterface) exitWith {};
[] spawn {

	// create hud
	disableSerialization;
	private _layerT = "rscLayer_respawn_round_hud" cutFadeOut 0;
	"rscLayer_respawn_round_hud" cutRsc ["respawn_round_rsc_hud", "PLAIN"];

	private _display = uiNamespace getVariable 'respawn_round_rsc_hud';
	private _ctrlBg = _display displayCtrl 9001;
	private _ctrlText = _display displayctrl 9002;
	private _ctrlNr = _display displayctrl 9003;
	private _ctrlMsg = _display displayctrl 9004;
	private _ctrlScore = _display displayctrl 9005;
	private _ctrlTime = _display displayctrl 9007;
	_ctrlText ctrlSetStructuredText parseText "";

	private _lastUpdate = time;
	private _lastUpdateNr = time;
	private _lastNr = -1;
	private _lastBg = -100;
	private _bgState = 'hidden';
	private _lastV = 0;

	private _lastTime = -1;
	private _lastTimeStr = '';
	private _roundTimeStr = '--:--';

	private _lastScores = [];

	// loop until loop gets disabled
	waitUntil {
		private _changeBg = false;
		private _text = '';
		private _nr = -1;
		call {
			private _stage = missionNamespace getVariable 'mission_respawn_round_stage';
			if (isNil '_stage') exitWith {};
			if (_stage isEqualTo 'end') exitWith {};
			if (_stage isEqualTo 'preStart') exitWith {
				_text = 'Time until game start:';
				_nr = missionNamespace getVariable ['mission_respawn_round_toStart',-1];
			};
			if (_stage isEqualTo 'preRoundSwitch') exitWith {
				_text = 'Switching Sides:';
				_nr = missionNamespace getVariable ['mission_respawn_round_toStart',-1];
			};
			if (_stage isEqualTo 'prep') exitWith {
				_changeBg = true;
				_text = 'Time until round start:';
				_nr = missionNamespace getVariable ['mission_respawn_round_toPrep',-1];
			};
			if (_stage isEqualTo 'live') then {

				if !(isNil 'respawn_round_bg_fader') then {
					terminate respawn_round_bg_fader;
					_ctrlBg ctrlSetBackgroundColor [0,0,0,0];
				};

				private _roundTime = missionNamespace getVariable ['mission_respawn_round_toRoundEnd',-1];

				if (_roundTime isEqualTo _lastTime) exitWith {};
				_lastTime = _roundTime;
				_roundTimeStr = _roundTime call {

					private _minStr = "";
					private _secStr = "";

					// Total minutes
					private _totalMinutes = floor(_roundTime / 60);
					if (_totalMinutes < 10) then {
						_minStr = _minStr + "0";
					};
					_minStr = _minStr + str _totalMinutes;

					// Total seconds
					private _totalSeconds = (_roundTime mod 60);
					if (_totalSeconds < 10) then {
						_secStr = _secStr + "0";
					};
					_secStr = _secStr + str _totalSeconds;

					if (_totalMinutes < 1) then {
						_minStr = "00";
					};
					if (_totalSeconds < 1) then {
						_secStr = "00";
					};
					format ['%1<t color="#aaffaa">:</t>%2',_minStr,_secStr]
				};
			};
		};

		if !(_roundTimeStr isEqualTo _lastTimeStr) then {
			_lastTimeStr = _roundTimeStr;
			_ctrlTime ctrlSetStructuredText (parseText _roundTimeStr);
		};

		if !(_text isEqualTo '') then {
			_ctrlText ctrlSetStructuredText (parseText _text);
			_lastUpdate = time;
		};

		if (_nr > 0 && !(_lastNr isEqualTo _nr)) then {
			_ctrlNr ctrlSetStructuredText (parseText str _nr);
			_lastUpdateNr = time;
		};
		if (_nr < 1) then {
			_lastUpdateNr = 0;
		};

		if ((time - _lastUpdateNr) > 1) then {
			_ctrlNr ctrlSetStructuredText (parseText '');
			_ctrlText ctrlSetStructuredText (parseText '');
		};

		call {
			if !(_changeBg) exitWith {};
			if (_nr >= 5 && ((time - _lastBg) > 1) && _bgState isEqualTo 'hidden') then {

				if !(isNil 'respawn_round_bg_fader') exitWith {};
				_lastBg = time;
				_bgState = 'shown';
				respawn_round_bg_fader = [_ctrlBg] spawn {
					disableSerialization;
					params ['_ctrlBg'];
					private _v = 0;
					waitUntil {
						_ctrlBg ctrlSetBackgroundColor [0,0,0,_v];
						_v = _v + 0.05;
						_v >= 0.7
					};
					waitUntil {
						_ctrlBg ctrlSetBackgroundColor [0,0,0,_v];
						_v = _v - 0.025;
						_v < 0.7
					};
					respawn_round_bg_fader = nil;
				};
			};

			if (_nr <= 1 && ((time - _lastBg) > 1) && _bgState isEqualTo 'shown') then {

				if !(isNil 'respawn_round_bg_fader') then {
					terminate respawn_round_bg_fader;
				};
				_lastBg = time;
				_bgState = 'hidden';
				respawn_round_bg_fader = [_ctrlBg] spawn {
					disableSerialization;
					params ['_ctrlBg'];
					private _v = 0.7;
					waitUntil {
						_ctrlBg ctrlSetBackgroundColor [0,0,0,_v];
						_v = _v - 0.01;
						_v <= 0.0
					};
					respawn_round_bg_fader = nil;
				};
			};
		};

		call {
			if !(isNil 'respawn_round_msg_fader') exitWith {};
			private _mission = true;
			_msg = missionNamespace getVariable ['mission_respawn_round_msg',''];
			if (_msg isEqualTo '') then {
				private _msg = player getVariable ['unit_respawn_round_msg',''];
				_mission = false;
			};

			if (_msg isEqualTo '') exitWith {};

			if (_mission) then {
				missionNamespace setVariable ['mission_respawn_round_msg',''];
			} else {
				player setVariable ['unit_respawn_round_msg',''];
			};
			_ctrlMsg ctrlSetStructuredText parseText _msg;
			respawn_round_msg_fader = [_ctrlMsg] spawn {
				disableSerialization;
				params ['_ctrlMsg'];
				sleep 3;
				_ctrlMsg ctrlSetStructuredText (parseText '');
				respawn_round_msg_fader = nil;
			};

		};

		// scores
		call {


			// make sure scores exist
			private _scores =+ (missionNamespace getVariable ['mission_respawn_round_sides_active',[]]);
			if (_scores isEqualTo _lastScores) exitWith {};
			_lastScores =+ _scores;

			// get player side
			private _side = player getVariable ['unit_respawn_round_side',''];
			_sidePlayer = toLower _side;

			// if player has no side, exit
			if (_sidePlayer isEqualTo '') exitWith {};
			private _playerSide = [];

			// top 3 sides
			private _topSides = [
				['',-1],
				['',-1],
				['',-1]
			];

			// locked sides
			private _lockedSide = missionNamespace getVariable ['mission_respawn_round_sidesLocked',RESPAWN_ROUND_SETTING_SIDELOCKED];
			private _lockedNames = [];

			// check for locked
			private _nil = {
				private _name = _x param [0,''];
				private _hide = _x param [3,false];
				if (_hide) then {
					_lockedNames pushBackUnique (toLower _name);
				};
				false
			} count _lockedSide;

			// loop through all scores/sides
			while {!(_scores isEqualTo [])} do {
				call {

					// get params from current side
					_side = _scores deleteAt 0;

					// make sure side is not empty
					if (_side isEqualTo []) exitWith {};

					// get side params
					_side params [['_sideName',''],['_sideUnits',[]],['_sideData',[]]];
					_sideData params [['_sideNr',0],['_sideWins',0]];

					// check if sidename in lockednames
					if ((toLower _sideName) in _lockedNames) exitWith {};

					// if name is same as player side name, save it as player side
					if ((toLower _sideName) isEqualTo _sidePlayer) then {
						_playerSide = [_sideName,_sideWins];
					};

					// loop through the top 3 sides
					{
						_x params [['_bestSide',''],['_bestWins',0]];

						// if the best side is empty or current side has more wins, replace it with current side
						if (_bestSide isEqualTo '' || _sideWins > _bestWins) exitWith {

							// add the score we are replacing back to the check array (so if it was 1st it can be rechecked for 2nd/3rd)
							if !(_bestSide isEqualTo '') then {
								_scores pushBackUnique [_bestSide,[],[nil,_bestWins]];
							};

							// using set to edit original array
							_topSides set [_forEachIndex,[_sideName,_sideWins]];
						};
					} forEach _topSides;
				};
			};


			// if playerside is not in the top sides, add player side to the list of sides
			if !(_playerSide in _topSides) then {
				_topSides pushBackUnique _playerSide;
			};

			// Beginning part of scoreText
			_scoreText = "<t align='left' color='#aaffaa'><t underline='true'>SCORES:</t><br/>";

			// array of strings used in front of every line
			//private _strArr = ['1st','2nd','3rd','You'];

			// loop through top sides
			{
				_x params [['_bestSide',''],'_bestWins'];

				// get the starting str from str array
				//private _startStr = _strArr deleteAt 0;

				// make sure the side is not empty
				if !(_bestSide isEqualTo '') then {

					private _color = "#aa5a00";
					if ((toLower _bestSide) isEqualTo _sidePlayer) then {
						_color = "#005aaa";
					};

					// combine the elements of the sides
					_scoreText = _scoreText + (format ['<t color="#f6b300">%1</t> - <t color=%3>%2</t><br/>',_bestWins,_bestSide, (str _color)]);
				};
			} forEach _topSides;
			_scoreText = _scoreText + "</t>";
			_ctrlScore ctrlSetStructuredText parseText _scoreText;
		};

		// check if good to exit
		(missionNamespace getVariable ['disable_round_loop',false])
	};

};