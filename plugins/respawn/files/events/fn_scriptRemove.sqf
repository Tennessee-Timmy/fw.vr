/* ----------------------------------------------------------------------------
Function: respawn_fnc_scriptRemove

Description:
	Removes respawn scripts
Parameters:
0:	_target		- Target to which the scripts will be removed from Unit, Group, Side or "" for mission scripts
1:	_script		- {code} to be added to the target
2:	_scriptType	- "onKilled","onRespawn","onRespawnUnit" must be one of these strings
Returns:
	nothing
Examples:
	TO UNIT onKilled:
		[_unit,{spec_fnc_exit},"kill"] call respawn_fnc_scriptRemove;
	TO SIDE respawn:
		[side,{_this setVariable ['reSpawned',true];},"onRespawnUnit"] call respawn_fnc_scriptRemove;
	TO MISSION onRespawn:
		["",{loadout_fnc_default},"onRespawn"] call respawn_fnc_scriptRemove;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_target","_script","_scriptType"];

// Determine type and add the script to units or the mission
call {
	private _target = _x;

	// Object > player
		if (_target isEqualType objNull) exitWith {
		private _unit = _target;
		[_unit,_script,_scriptType] call respawn_fnc_scriptRemoveUnit;
	};

	// Group > players in group
	if (_target isEqualType grpNull) exitWith {
		_group = _target;
		_nil ={
			private _unit = _x;
			[_unit,_script,_scriptType] call respawn_fnc_scriptRemoveUnit;
			false
		} count units _group;
	};

	// Side > players in side
	if (_target isEqualType sideEmpty) exitWith {
		private _side = _target;
		_nil ={
			if ((side _x)isEqualTo _side) then {
				private _unit = _x;
				[_unit,_script,_scriptType] call respawn_fnc_scriptRemoveUnit;
			};
			false
		} count PLAYERLIST;
	};

	// Remove the script as mission script, because it does not fit anywhere else
	/*
		mission_onKilled_scripts
		mission_onRespawn_scripts
		mission_onRespawnUnit_scripts
	*/

	// Get scrtipt type name
	private _scriptTypeName = format ["mission_%1_scripts",_scriptType];

	// Grab old scripts
	private _mission_scripts = missionNamespace getVariable [_scriptTypeName,[]];

	// Remove the script from the list
	_mission_scripts = _mission_scripts select {!(_x param [0,nil] isEqualTo _script)};

	// Update the script array on the unit
	missionNamespace setVariable [_scriptTypeName,_mission_scripts,true];
};