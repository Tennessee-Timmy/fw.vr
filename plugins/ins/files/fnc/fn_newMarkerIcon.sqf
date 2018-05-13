private ["_marker"];

if (_this select 0 == "local") then {
	_count = 1;
	_name = format ["%1", floor(random(100000000000000000))];
	_marker = createMarkerLocal [_name, (_this select _count)];
	_marker setMarkerShapeLocal "ICON";
	_count = _count + 1;
	_marker setMarkerTypeLocal (_this select _count);
	_count = _count+1; if (count _this <= _count) exitWith {_marker};
	_marker setMarkerColorLocal (_this select _count);
	_count = _count+1; if (count _this <= _count) exitWith {_marker};
	_marker setMarkerTextLocal (_this select _count);
	_count = _count+1; if (count _this <= _count) exitWith {_marker};
	_marker setMarkerSizeLocal (_this select _count);
	_count = _count+1; if (count _this <= _count) exitWith {_marker};
	_marker setMarkerDirLocal (_this select _count);
	_count = _count+1; if (count _this <= _count) exitWith {_marker};
	_marker setMarkerAlphaLocal (_this select _count);
	_count = _count+1; if (count _this <= _count) exitWith {_marker};
} else {
	_count = 1;
	_name = format ["%1", floor(random(100000000000000000))];
	_marker = createMarker [_name, (_this select _count)];
	_marker setMarkerShape "ICON";
	_count = _count + 1;
	_marker setMarkerType (_this select _count);
	_count = _count+1; if (count _this <= _count) exitWith {_marker};
	_marker setMarkerColor (_this select _count);
	_count = _count+1; if (count _this <= _count) exitWith {_marker};
	_marker setMarkerText (_this select _count);
	_count = _count+1; if (count _this <= _count) exitWith {_marker};
	_marker setMarkerSize (_this select _count);
	_count = _count+1; if (count _this <= _count) exitWith {_marker};
	_marker setMarkerDir (_this select _count);
	_count = _count+1; if (count _this <= _count) exitWith {_marker};
	_marker setMarkerAlpha (_this select _count);
	_count = _count+1; if (count _this <= _count) exitWith {_marker};
};

_marker