params ["_group","_patrol","_cached","_fight","_wave","_cachedActive","_cUnits","_customLimit","_speaker","_side","_buildingPatrol","_alert"];

private _transGiven = false;
private _transDone = false;
// quit if trans given but not done
if !(isNil "_group") then {
	if !(isNull _group) then {
		_transGiven = _group getVariable ['aiMaster_transGiven',false];
		_transDone = _group getVariable ['aiMaster_transDone',false];
	};
};
if(_transGiven && !_transDone) exitWith {};

private _array = _this;
private _val = _cached;
if (isNil "_val") then {
	_array set [2,[true,15,false,false]];
	_val = [false,15,false,false];
};
_val params ["_start","_max",["_no",false],["_active",false],["_cacheDist",[700,800]]];


if (_no) exitWith {
	if !(_array in aiMaster_activeGroups) then {
		aiMaster_activeGroups pushBack _array;
	};
};

_cacheDist params ["_distClose","_distFar"];
/*
_activeGroups = (count aiMaster_activeGroups + count aiMaster_fightingGroups);
if (_activeGroups > 15) then {
	_distClose = _distClose/1.25;
	_distFar = _distFar/1;
};
if (_activeGroups > 25) then {
	_distClose = _distClose/1.5;
	_distFar = _distFar/1.25;
};
if (_activeGroups > 35) then {
	_distClose = _distClose/1.75;
	_distFar = _distFar/1.5;
};*/
_distTooClose = (_distClose/4);


_patrol params ["_loc","_dist"];

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

private _cacheLead = false;
if (!isNil "_wave") then {
	if (!_wave) exitWith {
		if (_array in aiMaster_activeGroups) then {
			_array set [2,[false,_max,_no,_active,_cacheDist]];
			[_group,_cacheLead] call aiMaster_fnc_cacheInf;
			[aiMaster_activeGroups,_array] call aiMaster_fnc_depend;
			aiMaster_cachedGroups pushBack _array;
		};
		if (!(_array in aiMaster_activeGroups) && !(_array in aiMaster_cachedGroups) && !(_array in aiMaster_fightingGroups)) then {
			_array set [2,[false,_max,_no,_active,_cacheDist]];
			[_group,_cacheLead] call aiMaster_fnc_cacheInf;
			aiMaster_cachedGroups pushBack _array;
		};
	};
	if (_useCustomLimit && _customLimitNR >= _max) exitWith {};
	if (_wave) then {
		_array set [4,nil];
		_wave = nil;
	};/*
	if (!_active) then {
		_distClose = _distClose + ( _distClose / 2 );
		_distFar = _distFar + ( _distFar / 2 );
	};*/
};

if (_start) exitWith {
	_array set [2,[false,_max,_no,_active,_cacheDist]];
	if (!(_array in aiMaster_activeGroups) && !(_array in aiMaster_cachedGroups) && !(_array in aiMaster_fightingGroups)) then {
		[_group,_cacheLead] call aiMaster_fnc_cacheInf;
		aiMaster_cachedGroups pushBack _array;
	} else {
		if (_array in aiMaster_activeGroups) then {
			[_group,_cacheLead] call aiMaster_fnc_cacheInf;
			[aiMaster_activeGroups,_array] call aiMaster_fnc_depend;
			aiMaster_cachedGroups pushBack _array;
		};
	};
};


_players = aiMasterPlayers;
private _cacheMod = missionNamespace getVariable ['aiMaster_cacheMod',1];
if !(_cacheMod isEqualTo 1) then {
	_distClose = _distClose * _cacheMod;
	_distFar = _distFar * _cacheMod;
};

_onlyLead = false;

_cachedActive params ["_cachedLead","_cachedUnits"];

private _close = false;
if (_array in aiMaster_activeGroups) then {
	{
		if (_x inArea [_leaderPos,_distFar,_distFar,0,false]) exitWith { _close = true; };
	} count _players;
	if (_active) then {
		{
			if (_x inArea [_leaderPos,(_distFar * 2),(_distFar * 2),0,false]) exitWith { _cacheLead = true; };
		} count _players;
	};
	if ((_close && !_active) || (_close && _active && !_cacheLead)) exitWith { };
	[_group,_cacheLead] call aiMaster_fnc_cacheInf;
	if (_active) then {
		_cachedUnits = true;
		_cachedLead = true;
		_array set [5,[_cachedLead,true]];
	};
	if (_cacheLead || !_active) then {
		aiMaster_cachedGroups pushBack _array;
		[aiMaster_activeGroups,_array] call aiMaster_fnc_depend;
	};
};
if (isNil "_wave") then {_wave = true;};
if (!_wave) exitWith {};
_close = false;
if (_array in aiMaster_cachedGroups) then {
	if (count aiMaster_activeGroups >= _max && !_useCustomLimit) exitWith { };
	if (_useCustomLimit && _customLimitNR >= _max) exitWith {};
	if (_cachedLead && _active ) then {
		{
			private _modDist = _distClose;
			private _h = ((getPosVisual (vehicle _x))select 2);
			private _s = speed (vehicle _x);
			if (_h > 600 || _s > 350) then {
				_modDist = 0;
			} else {
				_modDist = (((_modDist - (((((_h * 1 / 100) max 1) * (_s * 10)) / 100 * 25))) min _modDist) max (_modDist / 5));
			};
			_dist = _x inArea [_leaderPos,(_modDist*2),(_modDist*2),0,false];
			if (_dist) exitWith { _close = true; };
		} count _players;
		if (_close) exitWith {
			private _tooClose = false;
			{
				private _modDist = _distTooClose;
				private _h = ((getPosVisual (vehicle _x))select 2);
		private _s = speed (vehicle _x);
				_modDist = (((_modDist - (((((_h * 1 / 100) max 1) * (_s * 10)) / 100 * 25))) min _modDist) max (_modDist / 5));
				_dist = _x inArea [_leaderPos,(_modDist),(_modDist),0,false];
				if (_dist) exitWith {_tooClose = true;};
			} count _players;
			if ( _tooClose ) exitWith { };
			_onlyLead = true;
			[nil,_onlyLead] call aiMaster_fnc_unCacheInf;
			aiMaster_activeGroups pushBack _array;
			[aiMaster_cachedGroups,_array] call aiMaster_fnc_depend;
		};
	};
	_onlyLead = false;
	{
		private _modDist = _distClose;
		private _h = ((getPosVisual (vehicle _x))select 2);
		private _s = speed (vehicle _x);
			if (_h > 600 || _s > 350) then {
			_modDist = 0;
		} else {
			_modDist = (((_modDist - (((((_h * 1 / 100) max 1) * (_s * 10)) / 100 * 25))) min _modDist) max (_modDist / 5));
		};
		_dist = _x inArea [_leaderPos,(_modDist),(_modDist),0,false];
		if (_dist) exitWith {_close = true};
		//if (_dist) then {if (((getPosVisual _x) select 2) < (10 / (floor(((speed _x)) / 50)) * 25)) exitWith {_close = true;};};
	} count _players;
	if (_close) exitWith {
		private _tooClose = false;
		{
			private _modDist = _distTooClose;
			private _h = ((getPosVisual (vehicle _x))select 2);
			private _s = speed (vehicle _x);
			_modDist = (((_modDist - (((((_h * 1 / 100) max 1) * (_s * 10)) / 100 * 25))) min _modDist) max (_modDist / 5));

			_dist = _x inArea [_leaderPos,(_modDist),(_modDist),0,false];
			if (_dist) exitWith {_tooClose = true;};
		} count _players;
		if (_tooClose) exitWith { };
		[nil,_onlyLead] call aiMaster_fnc_unCacheInf;
		aiMaster_activeGroups pushBack _array;
		[aiMaster_cachedGroups,_array] call aiMaster_fnc_depend;
	};
};
true