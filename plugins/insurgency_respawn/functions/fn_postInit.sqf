//Add eventhandelers to players and only allow for server to continue
if !(isServer) exitWith {
	if !(hasInterface) exitWith {
		player addEventHandler ["GetInMan",{(_this select 2) setVariable ['brm_insurgency_respawn_vehicleLastIn',time];}];
		player addEventHandler ["GetOutMan",{(_this select 2) setVariable ['brm_insurgency_respawn_vehicleLastIn',time];}];
	};
};
//define variables
//brm_insurgency_rock
brm_insurgency_respawnBoxes = [
	[brm_insurgency_equipmentBox_1,"[_this, 'blufor', ['backPacks','backPacks','backPacks','parachutes','parachutes','parachutes']] call BRM_fnc_assignCargo;"],
	[brm_insurgency_equipmentBox_2,"[_this, 'blufor', ['backPacks','backPacks','backPacks','parachutes','parachutes','parachutes']] call BRM_fnc_assignCargo;"],
	[brm_insurgency_nightBox_1,"[_this, 'blufor', ['night']] call BRM_fnc_assignCargo;"],
	[brm_insurgency_nightBox_1,"[_this, 'blufor', ['night']] call BRM_fnc_assignCargo;"],
	[brm_insurgency_ammoBox_1,"[_this, 'blufor', ['ammo','ammo','ammo']] call BRM_fnc_assignCargo;"],
	[brm_insurgency_ammoBox_2,"[_this, 'blufor', ['ammo','ammo','ammo']] call BRM_fnc_assignCargo;"],
	[brm_insurgency_medBox_1,"[_this, 'blufor', ['medical_adv']] call BRM_fnc_assignCargo;"],
	[brm_insurgency_medBox_2,"[_this, 'blufor', ['medical_adv']] call BRM_fnc_assignCargo;"],
	[brm_insurgency_medBox_3,"[_this, 'blufor', ['medical_adv']] call BRM_fnc_assignCargo;"],
	[brm_insurgency_repairBox,"[_this, 'blufor', ['repair']] call BRM_fnc_assignCargo"]
];
brm_insurgency_respawnVehicles = [];
brm_insurgency_respawn_tickets = missionNamespace getVariable ["brm_insurgency_respawn_tickets",100];
publicVariable 'brm_insurgency_respawn_tickets';
//list vehicles
_cars = [car_1,car_2,car_3,car_4,car_5];
_trucks = [truck_1,truck_2,truck_3,truck_4,truck_5,truck_6];
_carsArmed = [car_hmg_1,car_hmg_2,car_gmg_1,car_gmg_2];
_helis = [heli_1,heli_2];
//Add all vehicles to main list [(]vehicle,script to run,ticket cost)]
{[_x,"[_this, 'blufor', []] call BRM_fnc_assignCargo;",3] call BRM_insurgency_respawn_fnc_addVehicleToList;true}count _cars;
{[_x,"[_this, 'blufor' ['ammo']] call BRM_fnc_assignCargo;",5] call BRM_insurgency_respawn_fnc_addVehicleToList;true}count _trucks;
{[_x,"[_this, 'blufor', []] call BRM_fnc_assignCargo;",10] call BRM_insurgency_respawn_fnc_addVehicleToList;true}count _carsArmed;
[fueltruck,"[_this, 'blufor' []] call BRM_fnc_assignCargo;",15] call BRM_insurgency_respawn_fnc_addVehicleToList;
[repairtruck,"[_this, 'blufor' ['repair']] call BRM_fnc_assignCargo;",15] call BRM_insurgency_respawn_fnc_addVehicleToList;
[ammotruck,"[_this, 'blufor' []] call BRM_fnc_assignCargo;",15] call BRM_insurgency_respawn_fnc_addVehicleToList;
[apc,"[_this, 'blufor' ['ammo']] call BRM_fnc_assignCargo;",15] call BRM_insurgency_respawn_fnc_addVehicleToList;
[ifv,"[_this, 'blufor' ['ammo']] call BRM_fnc_assignCargo;",20] call BRM_insurgency_respawn_fnc_addVehicleToList;
[tank,"[_this, 'blufor' []] call BRM_fnc_assignCargo;",25] call BRM_insurgency_respawn_fnc_addVehicleToList;
{[_x,"[_this, 'blufor', ['parachutes','ammo','medical_adv']] call BRM_fnc_assignCargo;",20] call BRM_insurgency_respawn_fnc_addVehicleToList;true}count _helis;
[jet,"[_this, 'blufor' []] call BRM_fnc_assignCargo;",30] call BRM_insurgency_respawn_fnc_addVehicleToList;
[attack_heli,"[_this, 'blufor' []] call BRM_fnc_assignCargo;",35] call BRM_insurgency_respawn_fnc_addVehicleToList;
brm_insurgency_respawn_loopCount = 0;
brm_insurgency_respawn_loop = false;
[] spawn {
	waitUntil {
		private ["_vehicles","_respawnVehicles","_close","_players","_vehicle","_array","_closeDist"];
		_vehicles = brm_insurgency_respawnVehicles;
		_respawnVehicles = [];
		_players = allPlayers;
		_players pushBackUnique main_base;
		{
			_array = _x;
			_array params ["_vehicle"];
			if (isNull _vehicle) then {
				_respawnVehicles pushBackUnique _array;
			} else {
				if(!alive _vehicle || damage _vehicle isEqualTo 1) then {
					_respawnVehicles pushBackUnique _array;
				} else {
					_lastIn = _vehicle getVariable ['brm_insurgency_respawn_vehicleLastIn',time];
					_passed = time - _lastIn;
					if (_passed > (60*30)) then {
						_closeDist = 1500;
						_close = false;
						if !(canMove _vehicle) then {_closeDist = _closeDist / 3;};
						{
							if (_x distance _vehicle < _closeDist) exitWith {
								_close = true;
								true
							};
							true
						}count _players;
						if (!_close) then {
							_respawnVehicles pushBackUnique _array;
						} else {
							_vehicle setVariable ['brm_insurgency_respawn_vehicleLastIn',_lastIn + 60*10];
						};
					};
				};
			};
			sleep 0.1;
			true
		}count _vehicles;
		{
			_array = _x;
			_array params ["_vehicle","_startingInfo","_code","_ticketsCost","_timeGone"];
			private ["_passed"];
			if (isNull _vehicle) then {
				if (isNil "_timeGone") then {
					_x set [4,time];
				};
			} else {
				if (isNil "_timeGone") then {
					_lastIn = _vehicle getVariable ['brm_insurgency_respawn_vehicleLastIn',time];
					_x set [4,time];
				};
			};
			_timeGone = _array select 4;
			_passed = time - _timeGone;
			if (_passed > (60 * _ticketsCost)) then {
				_x call BRM_insurgency_respawn_fnc_respawnVehicle;
			};
			sleep 0.1;
			true
		}count _respawnVehicles;
		if (brm_insurgency_respawn_loopCount > (6*10))then {
			{
				_box = _x select 0;
				_code = _x select 1;
				_box setVariable ["unit_initialized", false];
				_box call compile _code;
				sleep 0.1;
				true
			} count brm_insurgency_respawnBoxes;
		};
		brm_insurgency_respawn_loopCount = brm_insurgency_respawn_loopCount + 1;
		sleep 10;
		brm_insurgency_respawn_loop
	};
};