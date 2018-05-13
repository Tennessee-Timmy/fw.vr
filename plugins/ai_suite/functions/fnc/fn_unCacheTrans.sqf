params ["_transArray","_vehicle"];
_transArray params ["_transGroup","_transPatrol","_transCached","_transFight","_transWave","_transCachedActive","_transCUnits","_transCustomLimit","_transSpeaker","_transSide","_transBuildingPatrol","_transAlert"];


if (isNil "_transGroup") then {_transGroup = createGroup _transSide};
if (isNull _transGroup) then {_transGroup = createGroup _transSide};
_none = {
	_form = "NONE";
	_radius = 0;
	_x params ["_gear","_pos","_damage","_skill","_type"];
	if (_active) then {
		_form = "FORM";
		_radius = 10;
		_pos = getPos leader _transGroup
	};
	_base = _type;
	_unit = _transGroup createUnit [_base, [0,0,0], [], _radius, _form];
	_unit allowDamage false;
	_unit setPosATL _pos;
	if ((count units _transGroup) isEqualTo 1) then {_transGroup selectLeader _unit};
	_gear = [_unit,_gear] call aiMaster_fnc_setGear;
	_skill = [_unit,_skill] call aiMaster_fnc_setSkill;
	_unit setDamage _damage;
	if (_transFight select 1) then {
		_unit disableAI "AUTOCOMBAT";
	};
	_unit addEventHandler ["Killed", aiMaster_fnc_onKilled];
	_unit setSpeaker _transSpeaker;
	[_unit, _transSpeaker] remoteExecCall ["setSpeaker", 0];
	true
} count _transCUnits;
_transGroup enableGunLights "forceOn";
_transArray set [6,[]];
_transArray set [0,_transGroup];

if (isNil "_vehicle") exitWith {};
if (isNull _vehicle) exitWith {};
[(units _transGroup),_vehicle] call aiMaster_fnc_loadTransIn;

_nul = {_x allowDamage true; true} count (units _transGroup);