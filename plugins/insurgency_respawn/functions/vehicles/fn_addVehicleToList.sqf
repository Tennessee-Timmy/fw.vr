/*
 * Adds vehicle to the list of respawnable vehicles
 *
 * Arguments:
 * 0: vehicle <object>
 * 1: Code to execute on respawn <string>
 * 2: Cost of tickets to respawn <number>
 *
 * Return value: None
 */
params ["_vehicle","_code","_tickets"];
_vehicle setVariable ["aiMaster_cleanUpDisabled",true];
brm_insurgency_respawnVehicles pushBackUnique [_vehicle,[typeOf _vehicle,getPos _vehicle,getDir _vehicle],_code,_tickets];