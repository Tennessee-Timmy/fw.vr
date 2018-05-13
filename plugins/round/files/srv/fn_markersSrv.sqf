/* ----------------------------------------------------------------------------
Function: round_fnc_markersSrv

Description:
	Creates custom ao markers based on the AOs
	if only 1 ao, the whole map will be covered!

Parameters:
0:	_AOs				- array of AOs to mark

Returns:
	nothing
Examples:
	// name - array - marker
	['de_dust',[],'ao'] call round_fnc_markersSrv;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// only run on server
if !(isServer) exitWith {};

_AOs = _this;

if (isNil '_AOs' || {_AOs isEqualTo []}) exitWith {systemChat "round: markersSrv no markers given";};

private _markerSize = 10000;
private _borderMarkerSize = 50;

if (count _AOs > 1) then {
	_markerSize = 50;
	_borderMarkerSize = 25;
};


private _oldMarkers = missionNamespace getVariable ['FW_map_cover',[]];

_nil = {
	deleteMarker _x;
	false
} count _oldMarkers;

FW_map_cover = [];

{
	_x params ['_name','_locs','_marker'];

	private _markerName = ('round_ao_'+_name+'_');

	_marker setMarkerAlpha 0;
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
		private _w = 2*_markerSize+_sy;
		private _bw = _sy + _borderMarkerSize;
		if !((_a > 0 && _a <= 90) || (_a >180 && _a <=270)) then {
			_s = _sy;
			_w = _sx + 2*_borderMarkerSize;
			_bw = _sx + _borderMarkerSize;
		};
		_pos_x = _px + (sin _a) * (_markerSize + _s + _borderMarkerSize);
		_pos_y = _py + (cos _a) * (_markerSize + _s + _borderMarkerSize);

		{
			_x params ["_color"];

			private _marker = createMarker [_markerName+"ao_" + str _i + str _forEachIndex, [_pos_x, _pos_y]];
			FW_map_cover pushBack _marker;

			_marker setMarkerSize [_w,_markerSize];
			_marker setMarkerDir _a;
			_marker setMarkerShape "rectangle";
			_marker setMarkerBrush "solid";
			_marker setMarkerColor _color;

			if (_forEachIndex == 5) then {
				_marker setMarkerBrush "grid";
			};

		} forEach _colors;


		_pos_x = _px + (sin _a) * (_borderMarkerSize/2 + _s);
		_pos_y = _py + (cos _a) * (_borderMarkerSize/2 + _s);

		for "_m" from 0 to 7 do {
			_marker = createMarker [_markerName+"ao_w_" + str _i + str _m,[_pos_x, _pos_y]];
			FW_map_cover pushBack _marker;

			_marker setMarkerSize [_bw, _borderMarkerSize/2];
			_marker setMarkerDir _a;
			_marker setMarkerShape "rectangle";
			_marker setMarkerBrush "solid";
			_marker setMarkerColor "colorwhite";
		};


	} forEach [_a, _a+90, _a+180, _a+270];


	_marker = createMarker [_markerName+"ao_b_1", [_px, _py]];
	FW_map_cover pushBack _marker;

	_marker setMarkerSize [_sxo, _syo];
	_marker setMarkerDir _a;
	_marker setMarkerShape "rectangle";
	_marker setMarkerBrush "border";
	_marker setMarkerColor "colorBlack";

	_marker = createMarker [_markerName+"ao_b_2", [_px, _py]];
	FW_map_cover pushBack _marker;

	_marker setMarkerSize [_sxo+_borderMarkerSize, _syo+_borderMarkerSize];
	_marker setMarkerDir _a;
	_marker setMarkerShape "rectangle";
	_marker setMarkerBrush "border";
	_marker setMarkerColor "colorBlack";



	// create name marker
	private _nameMarker = createMarker [_markerName+"ao_" + _name,([(_px),(_py+_sy+35)])];
	FW_map_cover pushBack _nameMarker;

	_nameMarker setMarkerSize [1,1];
	_nameMarker setMarkerDir 0;
	_nameMarker setMarkerShape "icon";
	_nameMarker setMarkerColor 'ColorBlack';


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

	_nameMarker setMarkerText _aoTitleText;
	_nameMarker setMarkerType 'mil_flag';

	false
} forEach _AOs;