/* ----------------------------------------------------------------------------
Function: round_fnc_loop

Description:
	The loop for client

Parameters:
	none
Returns:
	nothing
Examples:
	call round_fnc_loop;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

// Code begins
if !(hasInterface) exitWith {};
[] spawn {

	// create hud
	disableSerialization;
	private _layerT = "rscLayer_round_hud" cutFadeOut 0;
	"rscLayer_round_hud" cutRsc ["round_rsc_hud", "PLAIN"];

	private _display = uiNamespace getVariable 'round_rsc_hud';
	private _ctrlBg = _display displayCtrl 9001;
	private _ctrlText = _display displayctrl 9002;
	private _ctrlText1 = _display displayctrl 9002;
	private _ctrlText2 = _display displayctrl 9022;
	private _ctrlNr = _display displayctrl 9003;
	private _ctrlNr1 = _display displayctrl 9003;
	private _ctrlNr2 = _display displayctrl 9023;
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


	// loop until loop gets disabled
	waitUntil {
		private _changeBg = false;
		private _text = '';
		private _nr = -1;
		call {
			_ctrlNr = _ctrlNr1;
			_ctrlText = _ctrlText1;
			_roundTimeStr = '<t align="right">--:--</t>';
			private _stage = missionNamespace getVariable 'mission_round_stage';
			if (isNil '_stage') exitWith {};
			if (_stage isEqualTo 'end') exitWith {};
			if (_stage isEqualTo 'aoVote') exitWith {
				_text = 'Time to vote:';
				_nr = missionNamespace getVariable ['mission_round_toAO',-1];

				_ctrlNr = _ctrlNr2;
				_ctrlText = _ctrlText2;
			};
			if (_stage isEqualTo 'preStart') exitWith {
				_text = 'Time until game start:';
				_nr = missionNamespace getVariable ['mission_round_toStart',-1];
			};
			if (_stage isEqualTo 'preRoundSwitch') exitWith {
				_text = 'Switching Sides:';
				_nr = missionNamespace getVariable ['mission_round_toStart',-1];
			};
			if (_stage isEqualTo 'prep') then {
				_changeBg = true;
				_text = 'Time until round start:';
				_nr = missionNamespace getVariable ['mission_round_toPrep',-1];
			};


			// live stage / timer
			if (_stage isEqualTo 'live' || (_stage isEqualTo 'prep' && _nr > 15)) then {

				// added prep to be shown on top of the screen
				private _isPrep = false;
				private _extraText = '';

				// disable prep timer from middle of screen
				if (_stage isEqualTo 'prep') then {
					_isPrep = true;
				};

				if !(isNil 'round_bg_fader') then {
					terminate round_bg_fader;
					round_bg_fader = nil;
					_ctrlBg ctrlSetBackgroundColor [0,0,0,0];
					_bgState = 'hidden';
				};

				private _roundTime = [(missionNamespace getVariable ['mission_round_toRoundEnd',-1]),_nr] select _isPrep;

				if (_isPrep) then {
					_extraText = _text;
					_nr = -1;
					_text = '';
				};

				if (_roundTime isEqualTo _lastTime) exitWith {_roundTimeStr = _lastTimeStr;};
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
					format ['<t align="right"><t color="#e6b300">%3</t> %1<t color="#aaffaa">:</t>%2</t>',_minStr,_secStr,_extraText]
				};
			};
		};

		//--- Text and number
		call {
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
				_ctrlNr2 ctrlSetStructuredText (parseText '');
				_ctrlText2 ctrlSetStructuredText (parseText '');
			};
		};


		//--- dark background fader
		call {
			if !(_changeBg) exitWith {};
			if ((_nr < 10 && _nr > -1) && ((time - _lastBg) > 5) && _bgState isEqualTo 'hidden') then {

				if !(isNil 'round_bg_fader') exitWith {};
				_lastBg = time;
				_bgState = 'shown';
				round_bg_fader = [_ctrlBg] spawn {
					disableSerialization;
					params ['_ctrlBg'];
					private _v = 0.7;
					_ctrlBg ctrlSetBackgroundColor [0,0,0,_v];
					waitUntil {
						_ctrlBg ctrlSetBackgroundColor [0,0,0,_v];
						_v = _v - 0.0001;
						_v >= 0.5
					};
					sleep 2;
					waitUntil {
						_ctrlBg ctrlSetBackgroundColor [0,0,0,_v];
						_v = _v - 0.025;
						_v < 0.5
					};
					round_bg_fader = nil;
				};
			};

			if ((_nr <= 1 || _nr >= 10) && ((time - _lastBg) > 3) && _bgState isEqualTo 'shown') then {

				if !(isNil 'round_bg_fader') then {
					terminate round_bg_fader;
					round_bg_fader = nil;
				};
				_lastBg = time;
				_bgState = 'hidden';
				round_bg_fader = [_ctrlBg] spawn {
					disableSerialization;
					params ['_ctrlBg'];
					private _v = 0.5;
					waitUntil {
						_ctrlBg ctrlSetBackgroundColor [0,0,0,_v];
						_v = _v - 0.025;
						_v <= 0.0
					};
					round_bg_fader = nil;
				};
			};
		};


		//--- Message
		call {
			if !(isNil 'round_msg_fader') exitWith {};
			private _mission = true;
			_msg = missionNamespace getVariable ['mission_round_msg',''];
			if (_msg isEqualTo '') then {
				_msg = player getVariable ['unit_round_msg',''];
				_mission = false;
			};

			if (_msg isEqualTo '') exitWith {};

			if !(isNil 'round_msg_fader') then {
				terminate round_msg_fader;
				_ctrlMsg ctrlSetStructuredText (parseText '');
			};

			if (_mission) then {
				missionNamespace setVariable ['mission_round_msg',''];
			} else {
				player setVariable ['unit_round_msg',''];
			};
			_ctrlMsg ctrlSetStructuredText parseText _msg;
			round_msg_fader = [_ctrlMsg] spawn {
				disableSerialization;
				params ['_ctrlMsg'];
				sleep 1;
				[_ctrlMsg] spawn {
					disableSerialization;
					sleep 3;
					private _ctrlMsg = param [0];
					if !(isNil 'round_msg_fader') exitWith {};
					_ctrlMsg ctrlSetStructuredText (parseText '');
					round_msg_fader = nil;
				};
				round_msg_fader = nil;
			};

		};

		// scores
		call {


			// make sure scores exist
			private _scores =+ (missionNamespace getVariable ['mission_round_sides_active',[]]);

			// get player side
			private _side = player getVariable ['unit_round_side',''];
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
			private _lockedSide = missionNamespace getVariable ['mission_round_sidesLocked',ROUND_SETTING_SIDELOCKED];
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
					if (_side isEqualTo objNull) exitWith {};

					// get side params
					private _sideName = _side getVariable ['round_sideName',''];
					private _sideUnits = _side getVariable ['round_sideUnits',[]];
					private _sideWins = _side getVariable ['round_sideWins',0];
					private _sideNr = _side getVariable ['round_sideNr',99];

					// check if sidename in lockednames
					if ((toLower _sideName) in _lockedNames) exitWith {};

					// if name is same as player side name, save it as player side
					if ((toLower _sideName) isEqualTo _sidePlayer) then {
						_playerSide = [_sideName,_sideWins,_side];
					};

					// loop through the top 3 sides
					{
						_x params [['_bestSideName',''],['_bestWins',0],['_bestSide',objNull]];

						// if the best side is empty or current side has more wins, replace it with current side
						if (_bestSideName isEqualTo '' || _sideWins > _bestWins) exitWith {

							// if we are replacing a side, side name won't be empty
							// add the score we are replacing back to the check array (so if it was 1st it can be rechecked for 2nd/3rd)
							if !(_bestSideName isEqualTo '') then {
								_scores pushBackUnique _bestSide;
							};


							// using set to edit original array
							_topSides set [_forEachIndex,[_sideName,_sideWins,_side]];
						};
					} forEach _topSides;
				};
			};



			// if playerside is not in the top sides, add player side to the list of sides
			if !(_playerSide in _topSides) then {
				_topSides pushBackUnique _playerSide;
			};

			// Beginning part of scoreText
			_scoreText = "<t align='left' color='#aaffaa'>";	//<t underline='true'>SCORES:</t><br/>

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