params ["_thisUnits","_onlyLead"];
if (_onlyLead && _active) then {
	{
		[0, {_this enableSimulationGlobal true;}, _x] call CBA_fnc_globalExecute;
		[0, {_this hideObjectGlobal false;}, _x] call CBA_fnc_globalExecute;
		_x setSpeaker _speaker;
	} count (units _thisUnits);
};
if (!_onlyLead || !_active) then {
	if (isNil "_group") then {_group = createGroup _side};
	if (isNull _group) then {_group = createGroup _side};
	_none = {
		_form = "NONE";
		_radius = 0;
		_x params ["_gear","_pos","_damage","_skill","_type"];
		if (_active) then {
			_form = "FORM";
			_radius = 10;
			_pos = getPos leader _group
		};
		_base = _type;
		_unit = _group createUnit [_base, [0,0,0], [], _radius, _form];
		_unit allowDamage false;
		_unit setPosATL _pos;
		_unit allowDamage true;
		if ((count units _group) isEqualTo 1) then {_group selectLeader _unit};
		_gear = [_unit,_gear] call aiMaster_fnc_setGear;
		/*[_unit,_skill] spawn {
			sleep 1;
			params ['_unit','_skill'];
			if (isNil '_unit' || {isNull _unit}) exitWith {};
			[_unit,_skill] call aiMaster_fnc_setSkill;
		};*/
		_skill = [_unit,_skill] call aiMaster_fnc_setSkill;

		_unit setDamage _damage;
		if (_fight select 1) then {
			_unit enableAttack false;
			_unit disableAI "AUTOCOMBAT";
		};
		_unit addEventHandler ["Killed", aiMaster_fnc_onKilled];
		_unit setSpeaker _speaker;
		[_unit, _speaker] remoteExecCall ["setSpeaker", 0];
		true
	} count _cUnits;
	_group enableGunLights "forceOn";
	_array set [6,[]];
	_array set [0,_group];
};
if (_useCustomLimit) then {missionNamespace setvariable [_customLimit,_customLimitNR+1]};