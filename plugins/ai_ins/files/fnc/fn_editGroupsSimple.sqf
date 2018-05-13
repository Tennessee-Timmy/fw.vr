	/* ----------------------------------------------------------------------------
Function: ai_ins_fnc_editGroupsSimple

Description:
	Adds the edit into editQ simple ( 1 variable )

Parameters:
0:  _groups		- Array of groups to edit
1:	_param		- Parameter to edit
2:	_newValue	- New value for parameter

Returns:
	nothing
Examples:
	[_groups,_param,_newValue] call ai_ins_fnc_editGroupsSimple;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params [['_groups',[]],'_param','_newValue'];

// get current edit Ques and create them if they don't exist yet (for pushback)
// garrison que
private _editQG = missionNamespace getVariable 'ai_ins_garrison_editQ';
if (isNil '_editQG') then {
	_editQG = [];
	missionNamespace setVariable ['ai_ins_garrison_editQ',_editQG];
};
// normal que
private _editQ = missionNamespace getVariable 'ai_ins_groups_editQ';
if (isNil '_editQ') then {
	_editQ = [];
	missionNamespace setVariable ['ai_ins_groups_editQ',_editQ];
};

// loop through all the groups that will recieve the updates and add variable based on wether they are garrison or normal groups
{
	private _pad = _x;
	private _garrison = ([_pad] call ai_ins_fnc_detGarr);
	([_editQ,_editQG] select _garrison) pushBack [_pad,[_param,_newValue]];
} forEach _groups;