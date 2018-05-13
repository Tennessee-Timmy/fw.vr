//['cache'] call BRM_insurgency_fnc_removeToMark;
private ["_select"];
params ["_remove"];
{
	_select = _forEachIndex;
	if (_remove in _x) exitWith {};
}forEach BRM_insurgency_toMark;
BRM_insurgency_toMark = BRM_insurgency_toMark - [(BRM_insurgency_toMark select _select)];