private ["_mark","_chance"];
_toMark = missionNamespace getVariable ["ins_toMark",[]];
_toMark = ([_toMark,10] call ins_fnc_arrayShufflePlus);
_mark = selectRandom _toMark;
if (isNil "_mark") exitWith {};
_mark spawn ins_fnc_mark_base;