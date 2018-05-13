/* ----------------------------------------------------------------------------
Function: ao_fnc_postInit

Description:
	creates the ao area / covers map

Parameters:
	none
Returns:
	nothing
Examples:
	call ao_fnc_postInit;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

private _marker = "ao";
if (getMarkerColor _marker == "") exitWith {systemChat "ao: marker not found. please make a marker named: ao";};

if (hasInterface) then {

	// Check if warning is enabled
	private _warn = missionNamespace getVariable ["mission_ao_warn",AO_SETTING_WARN];
	private _warnPlayer = player getVariable ["unit_ao_warn",_warn];
	if !(_warnPlayer) exitWith {};

	_marker spawn {

		sleep 10;
		private _marker = _this;
		while {missionNamespace getVariable ["mission_ao_warn",AO_SETTING_WARN]} do {
			waitUntil {!(player inArea _marker) && !(player call respawn_fnc_deadCheck)};

			// exit if warn is disabled for player
			private _warnPlayer = player getVariable ["unit_ao_warn",true];
			if !(_warnPlayer) exitWith {};

			hintSilent 'Please return to the area of operations!';

			// Check if force jam is on
			private _jam = missionNamespace getVariable ["mission_ao_jam",AO_SETTING_JAM];
			if (_jam) then {

				// get old jam value
				private _customJam = missionNamespace getVariable ["rgd_overheating_customJam",0];
				private _playerJam = player getVariable ["rgd_overheating_customJam",_customJam];

				// Force player to jam
				player setVariable ["rgd_overheating_customJam",10];
				sleep 1;

				// return old jam value and back to loop
				player setVariable ["rgd_overheating_customJam",_playerJam];
			} else {
				sleep 1;
			};
		};
	};
};

// only run on server
if !(isServer) exitWith {};


#define S 10000
#define BS 50

_marker setMarkerAlpha 0;

private _oldMarkers = missionNamespace getVariable ['FW_map_cover',[]];

_nil = {
	deleteMarker _x;
	false
} count _oldMarkers;

FW_map_cover = [];

private _sx = (getMarkerSize _marker) select 0;
private _sy = (getMarkerSize _marker) select 1;
private _px = (getMarkerPos _marker) select 0;
private _py = (getMarkerPos _marker) select 1;
private _a = markerDir _marker;

private _sxo = _sx;
private _syo = _sy;


if ((_a > 0 && _a <= 90) || (_a >180 && _a <=270)) then {
	private _temp = _sx;
	_sx = _sy;
	_sy = _temp;
};

private _colorForest = "colorKhaki";
private _colors = ["colorBlack","colorBlack",_colorForest,"colorGreen",_colorForest,/**/"colorBlack"/**/,_colorForest,_colorForest];

{
	_x params ["_a"];
	private _i = _forEachIndex;

	_a = _a mod 360;
	if (_a < 0) then {_a = _a + 360};

	private _s = _sx;
	private _w = 2*S+_sy;
	private _bw = _sy + BS;
	if !((_a > 0 && _a <= 90) || (_a >180 && _a <=270)) then {
		_s = _sy;
		_w = _sx + 2*BS;
		_bw = _sx + BS;
	};
	_pos_x = _px + (sin _a) * (S + _s + BS);
	_pos_y = _py + (cos _a) * (S + _s + BS);

	{
		_x params ["_color"];

		private _marker = createMarker ["ao_" + str _i + str _forEachIndex, [_pos_x, _pos_y]];
		FW_map_cover pushBack _marker;

		_marker setMarkerSize [_w,S];
		_marker setMarkerDir _a;
		_marker setMarkerShape "rectangle";
		_marker setMarkerBrush "solid";
		_marker setMarkerColor _color;

		if (_forEachIndex == 5) then {
			_marker setMarkerBrush "grid";
		};

	} forEach _colors;


	_pos_x = _px + (sin _a) * (BS/2 + _s);
	_pos_y = _py + (cos _a) * (BS/2 + _s);

	for "_m" from 0 to 7 do {
		_marker = createMarker ["ao_w_" + str _i + str _m,[_pos_x, _pos_y]];
		FW_map_cover pushBack _marker;

		_marker setMarkerSize [_bw, BS/2];
		_marker setMarkerDir _a;
		_marker setMarkerShape "rectangle";
		_marker setMarkerBrush "solid";
		_marker setMarkerColor "colorwhite";
	};


} forEach [_a, _a+90, _a+180, _a+270];


_marker = createMarker ["ao_b_1", [_px, _py]];
FW_map_cover pushBack _marker;

_marker setMarkerSize [_sxo, _syo];
_marker setMarkerDir _a;
_marker setMarkerShape "rectangle";
_marker setMarkerBrush "border";
_marker setMarkerColor "colorBlack";

_marker = createMarker ["ao_b_2", [_px, _py]];
FW_map_cover pushBack _marker;

_marker setMarkerSize [_sxo+BS, _syo+BS];
_marker setMarkerDir _a;
_marker setMarkerShape "rectangle";
_marker setMarkerBrush "border";
_marker setMarkerColor "colorBlack";