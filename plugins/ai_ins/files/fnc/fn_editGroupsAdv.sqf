/* ----------------------------------------------------------------------------
Function: ai_ins_fnc_editGroupsAdv

Description:
	Adds the edit into editQ advanced version

Parameters:
0:  _groups		- Target array to edit
1:	_updates	- array containing updates

Returns:
	nothing
Examples:
	[_groups,[['allowCaching',false]]] call ai_ins_fnc_editGroupsAdv;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params [['_groups',[]],['_updates',[]]];

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

// loop through all the pads that will recieve the updates and add variables based on wether they are garrison or normal groups
{
	private _pad = _x;
	private _garrison = ([_pad] call ai_ins_fnc_detGarr);
	{
		private _update = _x;
		_update params ['_param','_newValue'];
		([_editQ,_editQG] select _garrison) pushBack [_pad,[_param,_newValue]];
	} forEach _updates;
} forEach _groups;