/* ----------------------------------------------------------------------------
Function: respawn_fnc_srvDeadRemove

Description:
	Removes the players / sides / groups from respawn array
Parameters:
0:	_targets	- Targets to remove from dead Unit(s), Group, Side, player name nothing for all players
Returns:
	nothing
Examples:
	// for unit
	[_unit] remoteExec ["respawn_fnc_srvDeadRemove",2];
	// for group
	[_group] remoteExec ["respawn_fnc_srvDeadRemove",2];
	// for side
	[west] remoteExec ["respawn_fnc_srvDeadRemove",2];
	// for nigel
	["nigel"] remoteExec ["respawn_fnc_srvDeadRemove",2];
	// For everyone
	call remoteExec ["respawn_fnc_srvDeadRemove",2];
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

// Get array of dead
private _mission_deadlist = ["mission_respawn_deadList",[]] call seed_fnc_getVars;

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
			{
				private _targetUnit = _x;
				// Return elements which don't have the same UID as target
				_mission_deadlist = _mission_deadlist select {
					_x params ["_uid","_side","_name"];
					!(
						_uid isEqualTo (getPlayerUID _targetUnit)
					)
				};
			} count _targetUnits
		};

		// If target is a side
		if (_target isEqualType sideEmpty) exitWith {
			private _targetSide = _target;

			// Return elements which don't have the same side as target
			_mission_deadlist = _mission_deadlist select {
				_x params ["_uid","_side","_name"];
				!(
					_targetSide isEqualTo _side
				)
			};
		};

		// If target is a string (name)
		if (_target isEqualType "") exitWith {

			// Return elements which don't have the same name
			_mission_deadlist = _mission_deadlist select {
				_x params ["_uid","_side","_name"];
			  	private _targetLower = toLower _target;
			  	private _nameLower = toLower _name;
				!(
					_targetLower isEqualTo _nameLower
				)
			};
		};

		// If we made it this far, it means that we need to remove all dead units
		_mission_deadlist = [];

	};
	false
} count _targets;

// Send the new dead list to everyone and save it
missionNamespace setVariable ["mission_respawn_deadList",_mission_deadlist,true];
["mission_respawn_deadList",_mission_deadlist] call seed_fnc_setVars;