[] spawn {
	while {isNil "mission_AI_controller_name"} do {uiSleep 1;};
	if !(mission_ai_controller) exitWith { };
	BRM_insurgency_spawned_files = [];
	BRM_insurgency_base_markers = [];
	#include "includes\bases.sqf"
	aiMaster_spawnedInf = 0;
	_baseData = selectRandom baseDatas;
	_base = _baseData call BIS_fnc_ObjectsMapper;
	base = _basedata select 0;
	publicVariable "base";
	BRM_insurgency_toMark pushBackUnique ["base",base,100,250,10,20,0.7];
	_basePos = _baseData select 0;
	[(_basePos),(1000),(1000),[east,1],[true,"SAFE","LIMITED",false],false,true,[3,3],[true,false],0.8,[true,50]] call BRM_aiMaster_fnc_aiSpawnVeh;
	[(_basePos),(200),(200),[east,5],[true,"SAFE","LIMITED",false],false,true,[1,1],[false,false],0.8,[true,50]] call BRM_aiMaster_fnc_aiSpawnVeh;
	[(_basePos),(500),(500),[east,8],[false,"SAFE","LIMITED",false],false,false,[1,1],[true,false],0.8,[true,50]] call BRM_aiMaster_fnc_aiSpawnVeh;

	[(_basePos),(500),(500),[east,1],[false,"SAFE","LIMITED"],true,[2,2],[true,false],0.8,[true,50,false,false]] call BRM_aiMaster_fnc_aiSpawnInf;
	[(_basePos),(500),(500),[east,3],[false,"SAFE","LIMITED"],false,[4,4],[true,true],0.8,[true,50,false,false]] call BRM_aiMaster_fnc_aiSpawnInf;
	[(_basePos),(100),(300),[east,3],[false,"SAFE","LIMITED"],false,[4,4],[false,false],0.8,[true,50,false,false]] call BRM_aiMaster_fnc_aiSpawnInf;
	[(_basePos),(100),(300),[east,1],[false,"SAFE","LIMITED"],false,[1,1],[false,false],0.8,[true,50,false,false]] call BRM_aiMaster_fnc_aiSpawnInf;

	[(_basePos),(100),(200),[east,2],[true,"SAFE","LIMITED"],true,[1,1],[false,false],0.8,[true,50,false,false]] call BRM_aiMaster_fnc_aiSpawnInf;
	[(_basePos),(100),(200),[east,3],[true,"SAFE","LIMITED"],false,[4,4],[false,true],0.8,[true,50,false,false]] call BRM_aiMaster_fnc_aiSpawnInf;
	[(_basePos),(100),(200),[east,4],[true,"SAFE","LIMITED"],false,[5,5],[false,true],0.8,[true,50,false,false]] call BRM_aiMaster_fnc_aiSpawnInf;
	waitUntil {uiSleep 0.1;!isNil "aiMaster_groups"};
	over4 = 0;
	over6 = 0;
	over2 = 0;
	T72U = 0;
	T72 = 0;
	bmp2 = 0;
	zsu = 0;
	gaz_zsu = 0;
	btr60 = 0;
	trans = 0;
	uaz = 0;
	infcqb1 = 0;
	infcqb2 = 0;
	inf1 = 0;
	inf2 = 0;
	inf3 = 0;
	inf3b = 0;
	inf4 = 0;
	inf5 = 0;
	inf6 = 0;
	inf6b = 0;
	inf7 = 0;
	inf8 = 0;
	copyToClipboard format ["T72U - %1 | T72 - %2 | bmp2 - %3 | zsu - %4 | gaz_zsu - %5 | btr60 - %6 | trans - %7 | uaz - %8 | infcqb1 - %9 | infcqb2 - %10 | inf1 - %11 | inf2 - %12 | inf3 - %13 | inf3b - %14 | inf4 - %15 | inf5 - %16 | inf6 - %17 | inf6b - %18 | inf7 - %19 | inf8 - %20",
	T72U,T72,bmp2,zsu,gaz_zsu,btr60,trans,uaz,infcqb1,infcqb2,inf1,inf2,inf3,inf3b,inf4,inf5,inf6,inf6b,inf7,inf8];
	private ["_spawnMarkers","_spawnedcqb1"];
	_spawnMarkers = BRM_insurgency_gridmarkers;
	_spawnMarkers = ([_spawnMarkers,10] call BRM_insurgency_fnc_arrayShufflePlus);
	{
		while {count allGroups > 140} do {uiSleep 0.1};
		_spawnedcqb1 = false;
		if (random 1 >= 0.5) then {
			_spawnedcqb1 = true;
			_markerPos = getMarkerPos _x;
			_markerAlpha = ceil(markerAlpha _x)*10;

			_spawnDist = 30;
			_patrolDist = 60;
			[_markerPos,east,_markerAlpha] call ai_ins_fnc_spawn;
			/*[(_markerPos),(call compile str _spawnDist),(call compile str _patrolDist),[east,4],[true,"SAFE","LIMITED"],false,[1,1],[false,false],0.8,[true,50,false,false,[600,800]]] call BRM_aiMaster_fnc_aiSpawnInf;*/
			diag_log "infcqb1";
			infcqb1 = infcqb1 + 1;
		};
		if (random 1 >= 0.6 && !_spawnedcqb1) then {
			_markerPos = getMarkerPos _x;
			_spawnDist = 30;
			_patrolDist = 60;
			[(_markerPos),(call compile str _spawnDist),(call compile str _patrolDist),[east,3],[false,"SAFE","LIMITED"],false,[1,1],[true,false],0.8,[true,50,false,false,[600,800]]] call BRM_aiMaster_fnc_aiSpawnInf;
			diag_log "infcqb2";
			infcqb2 = infcqb2 + 1;
		};
	} count _spawnMarkers;
	_spawnMarkers = ([_spawnMarkers,100] call BRM_insurgency_fnc_arrayShufflePlus);
	while {count _spawnMarkers > 0} do {
		if (count allgroups < 100) then {
			private ["_closeGrids","_spawnDist","_patrolDist","_spawnStrength","_marker","_markerPos","_spawnDist1","_spawnDist2","_spawnDist3","_spawnDist4","_spawnDist5"];
			_marker = _spawnMarkers select 0;
			_markerPos = getMarkerPos _marker;
			_spawnStrength = markerAlpha _marker;
			_closeGrids = [];
			_spawnDist = 40;
			_patrolDist = 70;
			_spawnDist1 = false;
			_spawnDist2 = false;
			_spawnDist3 = false;
			_spawnDist4 = false;
			_spawnDist5 = false;
			{
				if !(_x isEqualTo _marker) then {
					_dist = ((getMarkerPos _x) distance (getMarkerPos _marker));
					if(_dist <= 101 && _dist > 60) then {
						_closeGrids pushBackUnique _x;
						_spawnDist1 = true;
						_spawnMarkers = _spawnMarkers - [_x];
					};
					if(_dist <= 151 && _dist > 110) then {
						_closeGrids pushBackUnique _x;
						_spawnDist2 = true;
						_spawnMarkers = _spawnMarkers - [_x];
					};
					if(_dist <= 201 && _dist > 160) then {
						_closeGrids pushBackUnique _x;
						_spawnDist3 = true;
						_spawnMarkers = _spawnMarkers - [_x];
					};
					if(_dist <= 226 && _dist > 210) then {
						_closeGrids pushBackUnique _x;
						_spawnDist4 = true;
						_spawnMarkers = _spawnMarkers - [_x];
					};
					if(_dist <= 286 && _dist > 230) then {
						_closeGrids pushBackUnique _x;
						_spawnDist5 = true;
						_spawnMarkers = _spawnMarkers - [_x];
					};
				};
			}count _spawnMarkers;

			if (_spawnDist1) then {_spawnDist = 70;	_patrolDist = 150;};
			if (_spawnDist2) then {_spawnDist = 100;_patrolDist = 215;};
			if (_spawnDist3) then {_spawnDist = 150;_patrolDist = 250;};
			if (_spawnDist4) then {_spawnDist = 226;_patrolDist = 300;};
			if (_spawnDist5) then {_spawnDist = 286;_patrolDist = 350;};
			_mynewMarker = ["local", _markerPos, "ELLIPSE", "Solid", "ColorRed", [_patrolDist,_patrolDist], 0, 0.25] call BRM_FMK_fnc_newMarkerArea;
			{_spawnStrength = _spawnStrength + (markerAlpha _x)}count _closeGrids;
			if (_spawnStrength >= 6) then {over6 = over6 + 1;};
			if (_spawnStrength >= 4) then {over4 = over4 + 1;};
			if (_spawnStrength >= 2) then {over2 = over2 + 1;};
			while {_spawnStrength > 0} do {
			_spawnStrength = [_spawnStrength,_markerPos,_spawnDist] call {
					private ["_spawnStrength","_markerPos","_spawnDist"];
					params ["_spawnStrength","_markerPos","_spawnDist"];
					if (_spawnStrength >= 6 && random 1 >= 0.85) exitWith {
						[(_markerPos),(call compile str _spawnDist),(call compile str _patrolDist),[east,8],[false,"SAFE","LIMITED",false],false,false,[1,1],[true,false],0.8,[true,50]] call BRM_aiMaster_fnc_aiSpawnVeh;
						_spawnStrength = _spawnStrength - 6;
						diag_log "T72U";
						T72U = T72U + 1;
						_mynewMarker = ["local", (_markerPos), "hd_warning", "ColorRed", "Enemy T72U", [0.5,0.5], 0, 0.7] call BRM_FMK_fnc_newMarkerIcon;
						_spawnStrength
					};
					if (_spawnStrength >= 6 && random 1 >= 0.8) exitWith {
						[(_markerPos),(call compile str _spawnDist),(call compile str _patrolDist),[east,7],[false,"SAFE","LIMITED",false],false,false,[1,1],[true,false],0.8,[true,50]] call BRM_aiMaster_fnc_aiSpawnVeh;
						_spawnStrength = _spawnStrength - 6;
						diag_log "T72";
						T72 = T72 + 1;
						_mynewMarker = ["local", (_markerPos), "hd_warning", "ColorRed", "Enemy T72", [0.5,0.5], 0, 0.7] call BRM_FMK_fnc_newMarkerIcon;
						_spawnStrength
					};
					if (_spawnStrength >= 5 && random 1 >= 0.8) exitWith {
						[(_markerPos),(call compile str _spawnDist),(call compile str _patrolDist),[east,6],[false,"SAFE","LIMITED",false],false,false,[1,1],[true,false],0.8,[true,50]] call BRM_aiMaster_fnc_aiSpawnVeh;
						_spawnStrength = _spawnStrength - 5;
						diag_log "zsu";
						zsu = zsu + 1;
						_mynewMarker = ["local", (_markerPos), "hd_warning", "ColorRed", "Enemy ZSU", [0.5,0.5], 0, 0.7] call BRM_FMK_fnc_newMarkerIcon;
						_spawnStrength
					};
					if (_spawnStrength >= 4 && random 1 >= 0.85) exitWith {
						[(_markerPos),(call compile str _spawnDist),(call compile str _patrolDist),[east,4],[false,"SAFE","LIMITED",false],false,false,[1,1],[true,false],0.8,[true,50]] call BRM_aiMaster_fnc_aiSpawnVeh;
						_spawnStrength = _spawnStrength - 4;
						diag_log "bmp2";
						bmp2 = bmp2 + 1;
						_mynewMarker = ["local", (_markerPos), "hd_warning", "ColorRed", "Enemy BMP2", [0.5,0.5], 0, 0.7] call BRM_FMK_fnc_newMarkerIcon;
						_spawnStrength
					};
					if (_spawnStrength >= 3 && random 1 >= 0.85) exitWith {
						[(_markerPos),(call compile str _spawnDist),(call compile str _patrolDist),[east,5],[true,"SAFE","LIMITED",false],false,true,[1,1],[true,false],0.8,[true,50]] call BRM_aiMaster_fnc_aiSpawnVeh;
						_spawnStrength = _spawnStrength - 3;
						diag_log "gaz_zsu";
						gaz_zsu = gaz_zsu + 1;
						_spawnStrength
					};
					if (_spawnStrength >= 3 && random 1 >= 0.75) exitWith {
						[(_markerPos),(call compile str _spawnDist),(call compile str _patrolDist),[east,3],[true,"SAFE","LIMITED",false],false,true,[1,1],[true,false],0.8,[true,50]] call BRM_aiMaster_fnc_aiSpawnVeh;
						_spawnStrength = _spawnStrength - 3;
						diag_log "btr60";
						btr60 = btr60 + 1;
						_spawnStrength
					};
					if (_spawnStrength >= 1.5 && random 1 >= 0.75) exitWith {
						[(_markerPos),(call compile str _spawnDist),(call compile str _patrolDist),[east,2],[true,"SAFE","LIMITED",false],false,true,[1,1],[true,false],0.8,[true,50]] call BRM_aiMaster_fnc_aiSpawnVeh;
						_spawnStrength = _spawnStrength - 1.5;
						diag_log "trans";
						trans = trans + 1;
						_spawnStrength
					};
					if (_spawnStrength >= 1 && random 1 >= 0.75) exitWith {
						[(_markerPos),(call compile str _spawnDist),(call compile str _patrolDist),[east,1],[true,"SAFE","LIMITED",false],false,true,[1,1],[true,false],0.8,[true,50]] call BRM_aiMaster_fnc_aiSpawnVeh;
						_spawnStrength = _spawnStrength - 1;
						diag_log "uaz";
						uaz = uaz + 1;
						_spawnStrength
					};
					if (_spawnStrength >= 2 && random 1 >= 0.7) exitWith {
						[(_markerPos),(call compile str _spawnDist),(call compile str _patrolDist),[east,5],[false,"SAFE","LIMITED"],false,[1,1],[true,true],0.8,[true,50,false,false]] call BRM_aiMaster_fnc_aiSpawnInf;
						_spawnStrength = _spawnStrength - 1;
						diag_log "inf1";
						inf1 = inf1 + 1;
						_spawnStrength
					};
					if (_spawnStrength >= 2 && random 1 >= 0.6) exitWith {
						[(_markerPos),(call compile str _spawnDist),(call compile str _patrolDist),[east,1],[false,"SAFE","LIMITED"],false,[2,2],[true,true],0.8,[true,50,false,false]] call BRM_aiMaster_fnc_aiSpawnInf;
						_spawnStrength = _spawnStrength - 2;
						diag_log "inf2";
						inf2 = inf2 + 1;
						_spawnStrength
					};
					if (_spawnStrength >= 1 && random 1 >= 0.7) exitWith {
						[(_markerPos),(call compile str _spawnDist),(call compile str _patrolDist),[east,1],[false,"SAFE","LIMITED"],false,[1,1],[true,true],0.8,[true,50,false,false]] call BRM_aiMaster_fnc_aiSpawnInf;
						_spawnStrength = _spawnStrength - 1;
						diag_log "inf3";
						inf3 = inf3 + 1;
						_spawnStrength
					};
					if (_spawnStrength >= 0.5 && random 1 >= 0.8) exitWith {
						[(_markerPos),(call compile str _spawnDist),(call compile str _patrolDist),[east,2],[false,"SAFE","LIMITED"],false,[1,1],[true,true],0.8,[true,50,false,false]] call BRM_aiMaster_fnc_aiSpawnInf;
						_spawnStrength = _spawnStrength - 0.5;
						diag_log "inf3b";
						inf3b = inf3b + 1;
						_spawnStrength
					};
					if (_spawnStrength >= 2.5 && random 1 >= 0.3) exitWith {
						[(_markerPos),(call compile str _spawnDist)*1.5,((call compile str _patrolDist)*2),[east,2],[true,"SAFE","LIMITED"],false,[3,3],[false,false],0.8,[true,50,false,false]] call BRM_aiMaster_fnc_aiSpawnInf;
						_spawnStrength = _spawnStrength - 1.5;
						diag_log "inf4";
						inf4 = inf4 + 1;
						_spawnStrength
					};
					if (_spawnStrength >= 1 && random 1 >= 0.7) exitWith {
						[(_markerPos),(call compile str _spawnDist)*1.5,((call compile str _patrolDist)*1.5),[east,2],[true,"SAFE","LIMITED"],false,[1,1],[false,false],0.8,[true,50,false,false]] call BRM_aiMaster_fnc_aiSpawnInf;
						_spawnStrength = _spawnStrength - 0.5;
						diag_log "inf5";
						inf5 = inf5 + 1;
						_spawnStrength
					};
					if (_spawnStrength >= 0.5 && random 1 >= 0.8) exitWith {
						[(_markerPos),(call compile str _spawnDist)*0.5,(call compile str _patrolDist)*1.5,[east,3],[false,"SAFE","LIMITED"],false,[1,1],[true,true],0.8,[true,50,false,false]] call BRM_aiMaster_fnc_aiSpawnInf;
						_spawnStrength = _spawnStrength - 0.5;
						diag_log "inf6";
						inf6 = inf6 + 1;
						_spawnStrength
					};
					if (_spawnStrength < 0.4 && random 1 >= 0.8) exitWith {
						[(_markerPos),(call compile str _spawnDist)*0.5,(call compile str _patrolDist)*1.5,[east,3],[false,"SAFE","LIMITED"],false,[1,1],[true,true],0.8,[true,50,false,false]] call BRM_aiMaster_fnc_aiSpawnInf;
						_spawnStrength = _spawnStrength - 0.2;
						diag_log "inf6b";
						inf6b = inf6b + 1;
						_spawnStrength
					};
					if (_spawnStrength >= 0 && random 1 >= 0.99) exitWith {
						_spawnStrength = _spawnStrength / 2;
						_spawnStrength = _spawnStrength - 0.1;
						diag_log "inf7";
						inf7 = inf7 + 1;
						_spawnStrength
					};
					_spawnStrength = _spawnStrength - 0.1;
					_spawnStrength
				};
			};
			_spawnMarkers = _spawnMarkers - [_marker];
			{_spawnMarkers = _spawnMarkers - [_x]}count _closeGrids;
		} else {uiSleep 0.1;};
	};
};
