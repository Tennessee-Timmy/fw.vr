params ["_vehicle","_startingInfo","_code","_ticketsCost"];
_startingInfo params ["_type","_position","_dir"];
_availableTickets = brm_insurgency_respawn_tickets;
if !(_availableTickets > _ticketsCost) exitWith {};
_vehicleNew = _type createVehicle [0,0,0];
_vehicleNew setPos _position;
_vehicleNew setDir _dir;
_vehicleNew call compile _code;
_vehicleNew setVariable ["aiMaster_cleanUpDisabled",true];
_array = [_vehicleNew,_startingInfo,_code,_ticketsCost];
brm_insurgency_respawn_tickets = _availableTickets - _ticketsCost;
publicVariable 'brm_insurgency_respawn_tickets';
brm_insurgency_respawnVehicles = brm_insurgency_respawnVehicles - [_this];
brm_insurgency_respawnVehicles pushBackUnique _array;
true