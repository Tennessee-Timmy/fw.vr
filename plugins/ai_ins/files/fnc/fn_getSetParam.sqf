/* ----------------------------------------------------------------------------
Function: ai_ins_fnc_getSetParam

Description:
	finds the parameter from pad and returns it
	if the parameter is empty, it adds it.

Parameters:
0:  _pad			- pad with data
1:	_param			- name of param (string)
2:	_value			- new value for the param
3:	_pub			- public (only if not found)
Returns:
	value			- found or new value
Examples:
	[_pad,"cache",[500,600]] call ai_ins_fnc_getSetParam;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ['_pad','_param','_value',['_pub',false]];

// Throw an error if missing critical params
if (isNil "_pad") exitWith {
	'ai_ins_fnc_getSetParam: MISSING _pad' call debug_fnc_log;
};
if (isNil "_param") exitWith {
	'ai_ins_fnc_getSetParam: MISSING _param' call debug_fnc_log;
};

// get the old variables
private _var = _pad getVariable _param;

// if it does not exists, set it
if (isNil '_var') then {
	_var = _value;
	_pad setVariable [_param,_var,_pub];
};

// return variable
_var