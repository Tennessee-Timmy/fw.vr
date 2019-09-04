/* ----------------------------------------------------------------------------
Function: respawn_fnc_findGroup

Description:
	Finds the player original group from missionConfig

Parameters:
0:	_target			- Target player/object to get the original group for

Returns:
	_group			- Found group or newly created group with same parameters || GROUPNULL if nothing found

Examples:
	_group = [player] call respawn_fnc_findGroup;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params [['_target',objNull]];

// if target does not exist, return groupNull
if (isNull _target) exitWith {grpNull};

// original group
private _side = _target call respawn_fnc_getSetUnitSide;
private _oldGroup = group _target;
private _group = grpNull;

// get player variable name (exit if empty)
private _var = vehicleVarName _target;
if (_var isEqualTo '') exitWith {_oldGroup};

private _groupVar = '';
private _groupID = groupId (group _target);
if (isNil '_groupID') then {
	_groupID = '';
};
private _found = false;

// get all groups
private _groupsCfg = ("(getText(_x >> 'dataType')) isEqualTo 'Group'") configClasses (missionconfigfile >> "MissionSQM" >> "Mission" >> "Entities");

// set scope name so we can come back here from many scopes with breakTo
scopeName 'main';

// loop through groupsConfigs
private _nil = {
	private _groupCfg = _x;

	call {
		// get all playable units for this group
		private _playableUnits = ("(getNumber(_x >> 'Attributes' >> 'isPlayable')) > 0" configClasses (_groupCfg >> "Entities"));

		// save group variable and id
		private _groupIDCfg = (("(getText(_x >> 'property')) isEqualTo 'groupID'") configClasses (_groupCfg  >> "CustomAttributes")param [0,'']);
		if (_groupIDCfg isEqualTo '') exitWith {};
		_groupID = (getText(_groupIDCfg >> "Value" >> "data" >> "value"));
		_groupVar = (getText(_groupCfg >> "Attributes" >> "name"));

		// loop through every unit in this group
		private _nil = {
			private _unitCfg = _x;

			// check unit variable name and compare to vehicleVarName of target
			_unitVar = (getText(_unitCfg >> "Attributes" >> "name"));
			if (_unitVar isEqualTo _var) then {
				_found = true;

				// break out of if and both loops (to main)
				breakTo 'main';
			};
			false
		} count _playableUnits;
	};
	false
} count _groupsCfg;


call {

	// if a group was not found exit
	// no group found, uses oldgroup instead
	if !(_found) exitWith {};

	// get group of found group variable
	_group = missionNamespace getVariable _groupVar;
};

// if group does not exists or is null create new group
if (isNil '_group' || {isNull _group}) then {
	_group = createGroup [_side,false];
	_group setGroupIdGlobal [_groupID];
	missionNamespace setVariable [_groupVar,_group,true];
};

// if current group is same as the found one, exit
if (_group isEqualTo _oldGroup) exitWith {_group};

// join the new group and return it
[_target] joinSilent _group;
_group