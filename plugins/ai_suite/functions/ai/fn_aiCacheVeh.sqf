params ["_group","_patrol","_cached","_fight","_wave","_cachedActive","_cUnits","_customLimit","_speaker","_side","_vehicle","_alert","_transport"];
//_transort = [_transType,_transArray];
_transport params ["_transType","_transArray"];


private _array = _this;
private _val = _cached;
if ( isNil "_val" ) then {
	_array set [2,[true,15,false,false]];
	_val = [false,15,false,false];
};
_val params ["_start","_max",["_no",false],["_active",false],["_cacheDist",[1200,1400]]];

if (_no) exitWith {
	if !(_group in aiMaster_activeGroupsVeh) then {
		aiMaster_activeGroupsVeh pushBack _array;
	};
};

_cacheDist params ["_distClose","_distFar"];

/*
_activeGroups = (count aiMaster_activeGroupsVeh + count aiMaster_fightingGroupsVeh);

if (_activeGroups > 10) then {
	_distClose = _distClose/1.5;
	_distFar = _distFar/1.25;
};
if (_activeGroups > 20) then {
	_distClose = _distClose/1.75;
	_distFar = _distFar/1.5;
};*/

_distTooClose = (_distClose/4);

_cachedActive params ["_cachedLead","_cachedUnits"];

private _leaderPos = [0,0,0];
if (isNil "_group") then {
	_leaderPos = ((_cUnits select 0) select 1);
} else {
	if (isNull _group) then {
		_leaderPos = ((_cUnits select 0) select 1);
	}else {
		_leaderPos = getPos leader _group;
	};
};

_patrol params ["_loc","_dist"];
/*
if (((_leaderPos distance _loc) > (_dist + _dist / 2)) && !_active) then {
	_distClose = _distClose*2;
	_distFar = _distFar*2;
};
*/

if (!isNil "_wave") then {
	_wave = call compile _wave;
};

private _useCustomLimit = false;
private _customLimitNR = 0;
if (!isNil "_customLimit") then {
	_useCustomLimit = true;
	_customLimitNR = call compile _customLimit;
};

if (!isNil "_wave") then {
	if (!_wave) exitWith {
		if (_array in aiMaster_activeGroupsVeh) then {
			_array set [2,[false,_max,_no,_active,_cacheDist]];
			call aiMaster_fnc_cacheVeh;
			[aiMaster_activeGroupsVeh,_array] call aiMaster_fnc_depend;
			aiMaster_cachedGroupsVeh pushBack _array;
		};
		if (!(_array in aiMaster_activeGroupsVeh) && !(_array in aiMaster_cachedGroupsVeh) && !(_array in aiMaster_fightingGroupsVeh)) then {
			_array set [2,[false,_max,_no,_active,_cacheDist]];
			call aiMaster_fnc_cacheVeh;
			aiMaster_cachedGroupsVeh pushBack _array;
		};
	};
	if (_useCustomLimit && _customLimitNR >= _max) exitWith {};
	if (_wave) then {
		_array set [4,nil];
		_wave = nil;
	};
	/*
	if (!_active) then {
		_distClose = _distClose + ( _distClose / 2 );
		_distFar = _distFar + ( _distFar / 2 );
	};
	*/
};

if (_start) exitWith {
	_array set [2,[false,_max,_no,_active,_cacheDist]];
	if (!(_array in aiMaster_activeGroupsVeh) && !(_array in aiMaster_cachedGroupsVeh) && !(_array in aiMaster_fightingGroupsVeh)) then {
		call aiMaster_fnc_cacheVeh;
		aiMaster_cachedGroupsVeh pushBack _array;
	} else {
		if (_array in aiMaster_activeGroupsVeh) then {
			call aiMaster_fnc_cacheVeh;
			[aiMaster_activeGroupsVeh,_array] call aiMaster_fnc_depend;
			aiMaster_cachedGroupsVeh pushBack _array;
		};
	};
};


_players = aiMasterPlayers;
private _cacheMod = missionNamespace getVariable ['aiMaster_cacheMod',1];
if !(_cacheMod isEqualTo 1) then {
	_distClose = _distClose * _cacheMod;
	_distFar = _distFar * _cacheMod;
};
private _close = false;

if (_array in aiMaster_activeGroupsVeh) then {
	{
		if (_x inArea [_leaderPos,_distFar,_distFar,0,false]) exitWith { _close = true; };
	} count _players;
	if !(_close) exitWith {
		call aiMaster_fnc_cacheVeh;
		[aiMaster_activeGroupsVeh,_array] call aiMaster_fnc_depend;
		aiMaster_cachedGroupsVeh pushBack _array;
	};
};


if (isNil "_wave") then {_wave = true;};
if (!_wave) exitWith {};
private _close = false;

if (_array in aiMaster_cachedGroupsVeh) then {
	if (count aiMaster_activeGroupsVeh >= _max && !_useCustomLimit) exitWith {};
	if (_useCustomLimit && _customLimitNR >= _max) exitWith {};
	{
		_dist = _x inArea [_leaderPos,(_distClose),(_distClose),0,false];
		if (_dist) then {if (((getPosVisual _x) select 2) < (1000 / floor(((speed _x) max 50) / 25))) exitWith {_close = true;};};
	} count _players;
	if (_close) exitWith {
		private _tooClose = false;
		{
			_dist = _x inArea [_leaderPos,(_distTooClose),(_distTooClose),0,false];
			if (_dist) exitWith {_tooClose = true;};
		} count _players;
		if (_tooClose) exitWith {};
		call aiMaster_fnc_unCacheVeh;
		aiMaster_activeGroupsVeh pushBack _array;
		[aiMaster_cachedGroupsVeh,_array] call aiMaster_fnc_depend;
	};
};
true


/*

_modDist = _distClose;
_modDist = (((_modDist - (((((((getPosVisual (vehicle _x))select 2) * 1 / 100) max 1) * (speed (vehicle _x) * 10)) / 100 * 25))) min _modDist) max (_modDist / 5));

terminate ten_loop;
ten_loop =[] spawn {
while {isNil 'ten_stop'} do {
cDist = 1000;

h = ((getPosVisual (vehicle player))select 2);
s = speed (vehicle player);

cDist = (((cdist - (((((h * 1 / 100) max 1) * (s * 10)) / 100 * 25))) min cDist) max (cDist / 5));

systemChat ('Speed: ' + (str s));
systemChat ('Altitude: ' + (str h));
systemChat ('Dist: ' + (str cDist));

sleep 0.1;
};//while
};//spawn

*/