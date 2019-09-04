/* ----------------------------------------------------------------------------
Function: respawn_fnc_scriptAdd

Description:
	Adds respawn scripts
Parameters:
0:	_targets	- Targets to which the scripts will be added to Unit(s), Group, Side or "" for mission scripts
1:	_script		- {code} to be added to the target
2:	_scriptType	- "onKilled","onRespawn","onRespawnUnit" must be one of these strings
3:	_keep		- True by default, will the script be kept after first use
Returns:
	nothing
Examples:
	TO UNIT onKilled:
		[[_unit],{call spec_fnc_exit},"kill",false] call respawn_fnc_scriptAdd;
	TO SIDE respawn:
		[[side],{_this setVariable ['reSpawned',true]},"onRespawnUnit",true] call respawn_fnc_scriptAdd;
	TO MISSION onRespawn:
		[[""],{call loadout_fnc_default},"onRespawn",false] call respawn_fnc_scriptAdd;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params [["_targets",[""]],"_script","_scriptType",["_keep",true]];

// Determine type and add the script to units or the mission
_nul = {
	call {
		private _target = _x;

		// Object > player
		if (_target isEqualType objNull) exitWith {
			private _unit = _target;
			[_unit,_script,_scriptType,_keep] call respawn_fnc_scriptAddUnit;
		};

		// Group > players in group
		if (_target isEqualType grpNull) exitWith {
			_group = _target;
			_nil = {
				private _unit = _x;
				[_unit,_script,_scriptType,_keep] call respawn_fnc_scriptAddUnit;
				false
			} count units _group;
		};

		// Side > players in side
	if (_target isEqualType sideEmpty) exitWith {
			private _side = _target;
			_nil = {
				if ((side _x)isEqualTo _side) then {
					private _unit = _x;
					[_unit,_script,_scriptType,_keep] call respawn_fnc_scriptAddUnit;
				};
				false
			} count PLAYERLIST;
		};

		// Add the script as mission script, because it does not fit anywhere else
		/*
			mission_onKilled_scripts
			mission_onRespawn_scripts
			mission_onRespawnUnit_scripts
		*/

		// Get scrtipt type name
		private _scriptTypeName = format ["mission_%1_scripts",_scriptType];

		// Grab old scripts
		private _mission_scripts = missionNamespace getVariable [_scriptTypeName,[]];

		// Add the script to the list
		_nul = _mission_scripts pushBack [_script];

		// Update the script array on the unit
		missionNamespace setVariable [_scriptTypeName,_mission_scripts,true];
	};
	false
}count _targets;