/* ----------------------------------------------------------------------------
Function: round_fnc_vote

Description:
	Start the vote for client

Parameters:
	none
Returns:
	nothing
Examples:
	call round_fnc_vote;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
disableSerialization;

// Code begins
if !(hasInterface) exitWith {};

// make sure current stage is voting stage
private _stage = missionNamespace getVariable ['mission_round_stage',''];
if !(_stage isEqualTo 'aoVote') exitWith {};

if (player getVariable ['unit_round_voting',false]) exitWith {};
player setVariable ['unit_round_voting',true];

private _unit = player;
private _aoList = missionNamespace getVariable ["mission_round_aoList",ROUND_SETTING_AOLIST];

// Create fake UAV
round_cam = "Camera" camCreate [10,10,10];
round_cam cameraEffect ["INTERNAL", "BACK"];
cameraEffectEnableHUD true;
showCinemaBorder false;

// init camera
private _first = _aoList select 0;
_unit setVariable ['unit_round_cam_nr',0];

private _tgt = (getMarkerPos (_first param [2,'']));
private _txt = _first param [0,''];
private _alt = 100;
private _rad = 200;
private _ang = random 360;
private _dir = round random 1;

private _pos = _tgt;
private _coords = [_pos, _rad, _ang] call BIS_fnc_relPos;
_coords set [2, _alt];

round_cam camPrepareTarget _tgt;
round_cam camPreparePos _coords;
round_cam camPrepareFOV 0.500;
round_cam camCommitPrepared 0;

// Timeout the preload after 3 seconds
round_cam camPreload 3;

// Move camera in a circle
private _camLoop = [_pos, _alt, _rad, _ang, _dir] spawn {

	params ["_pos", "_alt", "_rad", "_ang", "_dir"];

	while {player getVariable ['unit_round_voting',true]} do {
		_pos = player getVariable ['unit_round_cam_pos',_pos];
		_alt = player getVariable ['unit_round_cam_alt',_alt];
		_rad = player getVariable ['unit_round_cam_rad',_rad];
		private _spd = player getVariable ['unit_round_cam_spd',3];

		private ["_coords"];
		_coords = [_pos, _rad, _ang] call BIS_fnc_relPos;
		_coords set [2, _alt];

		round_cam camPreparePos _coords;
		round_cam camCommitPrepared 0.3;

		waitUntil {camCommitted round_cam || !(player getVariable ['unit_round_voting',true])};

		round_cam camPreparePos _coords;
		round_cam camCommitPrepared 0;

		_ang = if (_dir == 0) then {_ang - _spd} else {_ang + _spd};
	};
};

// key eh
round_fnc_vote_keyDown = {
	disableSerialization;
	params ["_display", "_dikCode", "_shift", "_ctrl", "_alt"];
	if (_dikCode in [0x1E,0x20]) then {
		private _aoList = missionNamespace getVariable ["mission_round_aoList",ROUND_SETTING_AOLIST];
		private _aoCount = count _aoList;
		private _nr = player getVariable ['unit_round_cam_nr',0];

		private _next = true;
		_nr = _nr + 1;
		if (_dikCode isEqualTo 0x1E) then {
			_next = false;
			_nr = _nr - 2;
		};
		if (_nr < 0) then {
			_nr = (_aoCount + _nr);
		};

		_nr = abs(_nr mod _aoCount);


		private _ao = _aoList select _nr;

		player setVariable ['unit_round_cam_current',_ao];

		private _markerPos = getMarkerPos(_ao select 2);
		private _name = (_ao select 0);

		private _extra = _ao param [3,[]];
		_extra params [['_pos',_markerPos],'_alt','_rad'];

		if (!isNil '_alt') then {
			player setVariable ['unit_round_cam_alt',_alt];
		};
		if (!isNil '_rad') then {
			player setVariable ['unit_round_cam_rad',_rad];
		};

		player setVariable ['unit_round_cam_nr',_nr];
		player setVariable ['unit_round_cam_pos',_pos];
		round_cam camPrepareTarget _pos;
	};
	if (_dikCode isEqualTo 0x21) then {
		private _aoList = missionNamespace getVariable ["mission_round_aoList",ROUND_SETTING_AOLIST];
		private _nr = player getVariable ['unit_round_cam_nr',0];
		private _name = (_aoList select _nr) select 0;
		player setVariable ['unit_round_aoVote',_name,true];


		// AO name
		private _aoName = _name;
		private _aoCodeFile = format ["plugins\round\code\%1.sqf",_aoName];

		private _aoTitleText = '';
		if (_aoCodeFile call mission_fnc_checkFile) then {
			// load the file
			call compile preprocessFileLineNumbers _aoCodeFile;
		};
		if (_aoTitleText isEqualTo '') then {
			_aoTitleText = _aoName;
		};

		if ((call menus_fnc_isAdmin) && _ctrl) then {
			missionNamespace setVariable ['mission_round_aoForced',_name,true];
			missionNamespace setVariable ['mission_round_msg',(format ['%1 has forced the vote for %2',(name player),_aoTitleText]),true];
		} else {
			player setVariable ['unit_round_msg',(format ['You voted for %1',_aoTitleText])];
		};
		playSound ['click', true];
	};

};
_keyDownEH = (findDisplay 46) displayAddEventHandler ["KeyDown",{call round_fnc_vote_keyDown}];

// create hud
disableSerialization;
private _layerT = "rscLayer_round_vote_hud" cutFadeOut 0;
"rscLayer_round_vote_hud" cutRsc ["round_rsc_vote_hud", "PLAIN"];

private _display = uiNamespace getVariable 'round_rsc_vote_hud';
private _ctrlBg = _display displayCtrl 9001;
private _ctrlTitle = _display displayctrl 9002;
private _ctrlText = _display displayctrl 9003;
private _ctrlVotes = _display displayctrl 9004;
private _ctrlHelp = _display displayctrl 9005;

_ctrlHelp ctrlSetStructuredText (parseText "A/D - Prev/Next <br/>F - Vote");
_ctrlBg ctrlSetBackgroundColor [0,0,0,0];

private _lastNr = 0;
private _votes = _aoList apply {
	private _aoName = (_x param [0,'']);
	private _aoCodeFile = format ["plugins\round\code\%1.sqf",_aoName];
	private _aoTitleText = '';
	if (_aoCodeFile call mission_fnc_checkFile) then {
		call compile preprocessFileLineNumbers _aoCodeFile;
	};
	if (_aoTitleText isEqualTo '') then {
		_aoTitleText = _aoName;
	};
	([(_aoTitleText),0,_aoName])
};
private _lastVotes = '';

// wait for stage to change
waitUntil {

	//--- hud stuff
	call {
		// title/text
		private _hide = call {
			private _nr = player getVariable ['unit_round_cam_nr',999];
			if (_nr isEqualTo _lastNr) exitWith {false};
			_lastNr = _nr;

			private _ao = player getVariable ['unit_round_cam_current',_first];
			if (_ao isEqualTo []) exitWith {true};
			_ao params ['_name'];

			// AO name
			private _aoName = _name;
			private _aoCodeFile = format ["plugins\round\code\%1.sqf",_aoName];

			private _aoTitleText = '';
			private _aoDescText = '';
			if (_aoCodeFile call mission_fnc_checkFile) then {
				// load the file
				call compile preprocessFileLineNumbers _aoCodeFile;
			};
			if (_aoTitleText isEqualTo '') then {
				_aoTitleText = _aoName;
			};

			_aoDescText = "<t align='left'>" + _aoDescText + '</t>';

			if (_aoTitleText isEqualTo '') exitWith {true};
			_ctrlTitle ctrlSetStructuredText (parseText _aoTitleText);
			_ctrlText ctrlSetStructuredText (parseText _aoDescText);
			_ctrlBg ctrlSetBackgroundColor [0.2,0.2,0.2,0.5];
			false
		};
		if (_hide isEqualTo true) then {
			_ctrlBg ctrlSetBackgroundColor [0,0,0,0];
			_ctrlTitle ctrlSetStructuredText (parseText '');
			_ctrlText ctrlSetStructuredText (parseText '');
		};

		//--- votes
		call {
			private _votesTmp = + _votes;

			// loop through playerlist
			private _nil = {
				private _vote = _x getVariable ['unit_round_aoVote',''];

				// loop through all the votes
				{
					_x params ['_aoName','_aoVotes','_aoID'];
					// compare the player vote to the vote in votes array, add 1 if matched
					if (_aoID isEqualTo _vote) exitWith {
						_votesTmp set [_forEachIndex,[_aoName,(_aoVotes + 1),_aoID]];
					};
				} forEach _votesTmp;
				false
			} count PLAYERLIST;

			private _votesText = "<t align='right'>Votes:<br/>";
			private _nil = {
				_x params ['_aoName','_aoVotes'];
				_votesText = (_votesText + format ['<t color="#f6b300">%1</t> - <t color="#aaffaa">%2</t><br/>',(_aoName),(str _aoVotes)]);
				false
			} count _votesTmp;
			_votesText = (_votesText + '</t>');


			if (_lastVotes isEqualTo _votesText) exitWith {};
			_lastVotes = _votesText;

			_ctrlVotes ctrlSetStructuredText (parseText _votesText);
		};
	};
	private _stage = missionNamespace getVariable ['mission_round_stage',''];

	!(_stage isEqualTo 'aoVote')
};

// turn off
private _layerT = "rscLayer_round_vote_hud" cutFadeOut 0;
round_cam cameraEffect ["TERMINATE", "BACK"];
camDestroy round_cam;
player setVariable ['unit_round_voting',false];
player setVariable ['unit_round_aoVote',nil,true];
terminate _camLoop;
(findDisplay 46) displayRemoveEventHandler ['KeyDown',_keyDownEH];