params ["_target"];
private ["_seats","_vehicle"];
_vehicle = vehicle _target;
_seats = fullCrew [_vehicle,"all",true];
if !({isNull (_x select 0)}count _seats > 0) exitWith {
	if (speed _vehicle < 1 && (getPosVisual _vehicle select 2) < 2) then {
		hint 'Target vehicle FULL. Spawning near vehicle.';
		_vehicle spawn BRM_insurgency_respawn_fnc_telePort;
	} else {
		hint 'Target vehicle FULL. Wait for the vehicle to stop to spawn near it.';
	};
};
cutText ["","BLACK OUT",0.5];
sleep 1;
findDisplay 42069 closeDisplay 0;
call {
	if (isNull (assignedDriver _vehicle)) exitWith {
		player moveInDriver _vehicle;
	};
	if ((_vehicle emptyPositions "Gunner") > 0) exitWith {
		player moveInGunner _vehicle;
	};
	if ((_vehicle emptyPositions "Commander") > 0) exitWith {
		player moveInCommander _vehicle;
	};
	if ((_vehicle emptyPositions "cargo") > 0) exitWith {
		player moveInCargo _vehicle;
	};
	if ((_vehicle emptyPositions "driver") > 0) exitWith {
		player moveInDriver _vehicle;
	};
	_turrets = allTurrets [_vehicle,true];
	if (count _turrets > 0) exitWith {
		{
			player moveInTurret [_vehicle,_x];
		}count _turrets;
	};
};
cutText ["","BLACK IN",1];