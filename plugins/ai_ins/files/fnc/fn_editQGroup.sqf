/* ----------------------------------------------------------------------------
Function: ai_ins_fnc_editQGroup

Description:
	Edits the group from editQ

Parameters:
0:  _pad		- Target array to edit
1:	_update		- array containing updates
2:	_garr		- Is this a garrison group

Returns:
	nothing
Examples:
	call ai_ins_fnc_editQGroup;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params [['_pad',objNull],'_update'];

// exit if pad does not exist
if (isNull _pad) exitWith {};

// exit if no update or update not an array
if (isNil '_update' || {!(_update isEqualType [])}) exitWith {};
_update params ['_param','_newValue'];



// if param is not delete, update the param and push it back in the groups
if !((toLower _param) isEqualTo 'delete') then {
	[_pad,_param,_newValue] call ai_ins_fnc_setParam;
};

// todo delete ?
