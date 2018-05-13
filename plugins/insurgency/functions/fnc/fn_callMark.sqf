private ["_mark","_chance"];
_toMark = missionNamespace getVariable ["BRM_insurgency_toMark",[]];
_toMark = ([_toMark,10] call BRM_insurgency_fnc_arrayShufflePlus);
_mark = selectRandom _toMark;
if (isNil "_mark") exitWith {};
_mark spawn BRM_insurgency_fnc_mark_base;