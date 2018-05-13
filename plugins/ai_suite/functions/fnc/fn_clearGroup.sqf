params ["_gVars","_parent"];
_parentValue = call compile _parent;
_group = _gVars select 0;
_cached = _gVars select 6;
_customLimit = _gVars select 7;
private _useCustomLimit = false;
private _customLimitNR = 0;
if (!isNil "_customLimit") then {
	_useCustomLimit = true;
	_customLimitNR = call compile _customLimit;
};
if (isNil "_group") exitWith {
	if((count(_cached)isEqualTo 0)) then {
		[_parentValue,_gVars] call aiMaster_fnc_depend;
		missionNamespace setVariable [_parent,_parentValue];
		if (_useCustomLimit) then {missionNamespace setvariable [_customLimit,_customLimitNR-1]};
		_gVars set [7,nil];
	};
};
if (isNull _group) exitWith {
	if((count(_cached)isEqualTo 0)) then {
		[_parentValue,_gVars] call aiMaster_fnc_depend;
		missionNamespace setVariable [_parent,_parentValue];
		if (_useCustomLimit) then {missionNamespace setvariable [_customLimit,_customLimitNR-1]};
		_gVars set [7,nil];
	};
};
if({alive _x}count units _group isEqualTo 0 && (count(_cached)isEqualTo 0)) then {
	[_parentValue,_gVars] call aiMaster_fnc_depend;
	missionNamespace setVariable [_parent,_parentValue];
	if (_useCustomLimit) then {missionNamespace setvariable [_customLimit,_customLimitNR-1]};
	_gVars set [7,nil];
	deleteGroup _group;
};
true