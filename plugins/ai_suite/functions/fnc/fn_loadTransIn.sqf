// [_units,_vehicle] call aiMaster_fnc_loadTransIn
// loads the units in vehicle
// return : true
params ["_units","_vehicle"];

private _turrets = allTurrets [_vehicle,true];
{
	private _unit = _x;
	call {
		if ((_vehicle emptyPositions "cargo") > 0) exitWith {
			_unit moveInCargo _vehicle;
		};
		if (count _turrets > 0) exitWith {
			_unit moveInTurret [_vehicle,(_turrets select 0)];
			_turrets = _turrets - [ (_turrets select 0)];
		};
		if ((_vehicle emptyPositions "Commander") > 0) exitWith {
			_unit moveInCommander _vehicle;
		};
		if ((_vehicle emptyPositions "Gunner") > 0) exitWith {
			_unit moveInGunner _vehicle;
		};
	};
}count _units;
true