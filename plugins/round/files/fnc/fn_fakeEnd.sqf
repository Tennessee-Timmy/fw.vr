/* ----------------------------------------------------------------------------
Function: round_fnc_fakeEnd

Description:
	Fake ending

Parameters:
	none
Returns:
	nothing
Examples:
	call round_fnc_fakeEnd;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

if !(hasInterface) exitWith {};
private _close = param [0,false];
if (_close) exitWith {
	private _spawn = player getVariable 'unit_round_fakeEnd';

	if (isNil '_spawn') exitWith {};
	player setVariable ['unit_round_fakeEnd',nil];

	if (!isNull _spawn) then {
		terminate _spawn;
	};
	_layerNoise = "BIS_fnc_endMission_noise" call bis_fnc_rscLayer;
	_layerInterlacing = "BIS_fnc_endMission_interlacing" call bis_fnc_rscLayer;
	_layerStatic = "BIS_fnc_endMission_static" call bis_fnc_rscLayer;
	_layerEnd = "BIS_fnc_endMission_end" call bis_fnc_rscLayer;
	{_x cuttext ["","plain"]} foreach [_layerNoise,_layerInterlacing,_layerStatic,_layerEnd];
};
_this = [];

private ["_var","_spawn"];
_var = _fnc_scriptName + str floor random 99999;
_spawn = [_var,_this] spawn {
	scriptname "BIS_fnc_endMission";
	_fnc_scriptName = "BIS_fnc_endMission";

	if ((!isNil {BIS_fnc_dbg_reminder_value}) && {!isNil {BIS_fnc_dbg_reminder}}) then {
		[] call BIS_fnc_dbg_reminder;
	};

	private ["_end","_win","_fade","_winPrevious","_playmusic","_completeTasks"];
	_var = _this select 0;
	_this = _this select 1;
	_end = _this param [0,"end1",["",[]]];
	_win = _this param [1,true,[true]];
	_fade = _this param [2,true,[true,0]];
	_playmusic = _this param [3,true,[true]];
	_completeTasks = _this param [4,false,[false]];

	_winPrevious = missionnamespace getvariable ["BIS_fnc_missionHandlers_win",_win];
	if (!_winPrevious && _win) exitwith {};

	if !(isnil {BIS_fnc_endMission_effects}) then {terminate BIS_fnc_endMission_effects;};
	BIS_fnc_endMission_effects = missionnamespace getvariable [_var,[] spawn {}];
	missionnamespace setvariable [_var,nil];

	if (typename _end == typename []) then {
		_endName = _end param [0,"end",[""]];
		_endID = _end param [1,1,[0]];
		_end = _endName + "_" + str _endID;
	};
	if (_end == "") then {_end = "end1"};

	if (typename _fade == typename true) then {
		_fade = [0,-1] select _fade;
	};
	enablesaving [false,false];

	missionnamespace setvariable ["BIS_fnc_missionHandlers_win",_win]; //--- ToDo: Detect win type in engine
	missionnamespace setvariable ["BIS_fnc_missionHandlers_end",_end]; //--- ToDo: Detect end type in engine

	if (_fade < 0) then {

		_layerNoise = "BIS_fnc_endMission_noise" call bis_fnc_rscLayer;
		_layerInterlacing = "BIS_fnc_endMission_interlacing" call bis_fnc_rscLayer;
		_layerStatic = "BIS_fnc_endMission_static" call bis_fnc_rscLayer;
		_layerEnd = "BIS_fnc_endMission_end" call bis_fnc_rscLayer;
		{_x cuttext ["","plain"]} foreach [_layerNoise,_layerInterlacing,_layerStatic,_layerEnd];

		if (_playmusic) then {
			_musicvolume = musicvolume;
			0.2 fademusic 0;
			sleep 0.2;
			_musicList = if (isnull curatorcamera) then {["EventTrack02_F_Curator","EventTrack01_F_Curator"]} else {["EventTrack02_F_Curator","EventTrack03_F_Curator"]};
			playmusic (_musicList select _win);
			0 fademusic _musicvolume;
			sleep 0.4;
		};

		setacctime 1;
		_layerStatic cutrsc ["RscStatic","plain"];

		sleep 0.3;


		showhud false;
		RscMissionEnd_end = _end;
		RscMissionEnd_win = _win;
		_layerEnd cutrsc ["RscMissionEnd","plain"];

		sleep 9;


		RscNoise_color = [1,1,1,0];
		_layerNoise cutrsc ["RscNoise","black"];
		_layerStatic cutrsc ["RscStatic","plain"];

		sleep 0.5;


		RscNoise_color = [1,1,1,1];
		_layerInterlacing cutrsc ["RscInterlacing","plain"];

		2.5 fadesound 0;
		2.5 fademusic 0;

		sleep 2.5;


		RscDisplayDebriefing_noise = true;
	} else {
		if (_fade > 0) then {
			cuttext ["","black out",_fade];
			sleep _fade;
		};
	};


	if ((missionNamespace getVariable ["BIS_fnc_endMission_checkAliveState",true]) && !ismultiplayer && !alive player) exitwith {
		if (_fade >= 0) then {cuttext ["","plain"];};
	};
};
missionnamespace setvariable [_var,_spawn];
player setVariable ['unit_round_fakeEnd',_spawn];
true