params ["_group","_patrol","_cached","_fight","_wave","_cachedActive","_cUnits","_customLimit","_speak","_side","_vehicle","_alert"];
if (isNil "_vehicle") exitWith {};
if (typeName _vehicle isEqualTo "ARRAY") exitWith {};
if (isNull _vehicle) exitWith {};
if (!alive _vehicle) exitWith {};
if ((_vehicle isKindOf "LandVehicle") && ((vectorUp _vehicle) select 2 < -0.6) && (alive _vehicle)) then {
	if (speed _vehicle < 1) then {
		_dir = getDir _vehicle;
		_pos = getPos _vehicle;
		_vehicle setDir _dir;
		_vehicle setVectorUp [0,0,0];
		_vehicle setPos [_pos select 0, _pos select 1, 3];
		_vehicle setVelocity [0,0,1];
		_vehicle setDir _dir;
	};
};
true