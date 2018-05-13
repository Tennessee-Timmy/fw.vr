/* ----------------------------------------------------------------------------
Function: respawn_fnc_srvRespawn

Description:
	Respawns the targets
Parameters:
0:	_targets	- Targets to respawn: Unit(s), Group, Side, player name or nothing for all players
Returns:
	nothing
Examples:
	// for unit
	[_unit] remoteExec ["respawn_fnc_srvRespawn",2];
	// for group
	[_group] remoteExec ["respawn_fnc_srvRespawn",2];
	// for side
	[west] remoteExec ["respawn_fnc_srvRespawn",2];
	// for nigel
	["nigel"] remoteExec ["respawn_fnc_srvRespawn",2];
	// For everyone
	remoteExec ["respawn_fnc_srvRespawn",2];
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

if !(isServer) exitWith {};
[_this] params [["_targets", [], [[]]]];
if (_targets isEqualTo []) then {
    _targets = [west,east,resistance,civilian];
};

// Remove all targets from dead list (This means units that are disconnected will no longer be dead)
_targets call respawn_fnc_srvDeadRemove;

// Loop
{
	call {
		private _target = _x;

		// If target is a unit or a group
		if (_target isEqualType objNull || _target isEqualType grpNull) exitWith {

			// Set the units as target
			private _targetUnits = [_target];

			// If target is a group use units from the group instead
			if (_target isEqualType grpNull) then {
				_targetUnits = units _target;
			};

			// Loop through all units
			private _nul = {
				private _targetUnit = _x;
				// remoteExec the respawn function
				_targetUnit remoteExec ["respawn_fnc_respawnUnit",_targetUnit];
				false
			} count _targetUnits
		};

		// If target is a side
		if (_target isEqualType sideEmpty) exitWith {
			private _targetSide = _target;

			// remoteExec the respawn function for all units in the side
			private _nul = {
				if (side _x isEqualTo _target) then {
					_x remoteExec ["respawn_fnc_respawnUnit",_x,false];
				};
				true
			} count PLAYERLIST;
		};

		// If target is a string (name)
		if (_target isEqualType "") exitWith {
			private _nul = {
				// remoteExec the respawn function for player with same name
				private _name = name _x;
			  	private _targetLower = toLower _target;
			  	private _nameLower = toLower _name;
				if (_targetLower isEqualTo _nameLower) exitWith {
					_x remoteExec ["respawn_fnc_respawnUnit",_x,false];
				};
				false
			} count PLAYERLIST;
		};

		// If we made it this far, it means that we need to respawn everyone
		private _nil = {
			_x remoteExec ["respawn_fnc_respawnUnit",_x,false];
			true
		} count PLAYERLIST;
	};
	false
} count _targets;