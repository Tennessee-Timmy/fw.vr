//['cache'] call ins_fnc_removeToMark;
private ["_select"];
params ["_remove"];
{
	_select = _forEachIndex;
	if (_remove in _x) exitWith {};
}forEach ins_toMark;
ins_toMark = ins_toMark - [(ins_toMark select _select)];