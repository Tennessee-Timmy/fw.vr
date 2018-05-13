params ["_display","_key"];
private ["_newUnit","_list"];
/*
_forced = missionNamespace getVariable ['BRM_insurgency_respawn_force',false];
if (_forced) then {
	if (_key isEqualTo 1) exitWith {createdialog "RscInsurgencyRespawn";};
};
*/
if (_key isEqualTo 32 || _key isEqualTo 30) then {
	_list = [];
	_list = _list + insurgency_respawn_spawnList;
	if (_key isEqualTo 30) then {
		reverse _list;
	};
	_listCount = count _list;
	_unit = BRM_insurgency_respawn_selectedUnit;
	_unitIndex = _list find _unit;
	if ((_listCount - 1) isEqualTo _unitIndex) then {
		_newUnit = _list select 0;
	} else {
		_newUnit = _list select (_unitIndex + 1);
	};
	_newUnit call BRM_insurgency_respawn_fnc_selectUnit;
};
if (_key isEqualTo 49) then {
	_nvgOn = missionNamespace getVariable ['BRM_insurgency_respawn_nvgOn',false];
	if !(_nvgOn) then {
		camUseNVG true;
		missionNamespace setVariable ['BRM_insurgency_respawn_nvgOn',true];
	} else {
		camUseNVG false;
		missionNamespace setVariable ['BRM_insurgency_respawn_nvgOn',false];
	};
};
if (_key isEqualTo 50) then {
	_ctrl = _display displayctrl 470;
	if !(ctrlShown _ctrl) then {
		_ctrl ctrlShow true;
	} else {
		_ctrl ctrlShow false;
	};
};
