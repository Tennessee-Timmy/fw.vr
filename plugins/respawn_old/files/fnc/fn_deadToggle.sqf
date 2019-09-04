/* ----------------------------------------------------------------------------
Function: respawn_fnc_deadToggle

Description:
	Changes unit state from dead to alive
	DEAD:
		setvariable unit_respawn_dead
		move to 0,0,50
		disable simulation
		disable damage
	ALIVE:
		setVaraible unit_respawn_dead false
		enablesimulation
		allow damage
	best used locally, to ensure evrything works
	Can be forced to dead
Parameters:
0:	_unit - unit which to handle
1:	_forceDeath - force the unit to switch to dead
Returns:
	nothing
Examples:
	[_unit,_forceDeath] call respawn_fnc_deadToggle;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_unit",["_forceDeath",false]];

// Check if the unit is dead or not by "unit_respawn_dead"
private _isDead = _unit getVariable ["unit_respawn_dead",false];

// if unit is not dead yet or death is forced
if (!_isDead || _forceDeath) then {

	// Set unit as dead
	_unit remoteExec ["respawn_fnc_srvDeadAdd",2];
	_unit setVariable ["unit_respawn_dead",true,true];
	// Move him to 0, 0, 5 (deadArea)
	_unit setPos [0,0,5];
	_unit setVelocity [0,0,0];
	[_unit,true] remoteExec ["hideObjectGlobal",2];
	[_unit,false] remoteExec ["enableSimulationGlobal",2];
	_unit allowDamage false;
} else {

	// Set unit as alive
	[_unit] remoteExec ["respawn_fnc_srvDeadRemove",2];
	_unit setVariable ["unit_respawn_dead",false,true];

	// enablesimulation / allowdamage
	[_unit,false] remoteExec ["hideObjectGlobal",2];
	[_unit,true] remoteExec ["enableSimulationGlobal",2];
	_unit allowDamage true;

	// remove velocity
	_unit setVelocity [0,0,0];
	_unit spawn {
		sleep 0.1;
		_this setVelocity [0,0,0];
		sleep 0.1;
		_this setVelocity [0,0,0];
	};
};