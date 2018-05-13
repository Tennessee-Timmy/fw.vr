/* ----------------------------------------------------------------------------
Function: ai_ins_fnc_findParam

Description:
	finds the parameter from pad

Parameters:
0:  _pad			- pad with variables
1:	_param			- name of param (string)
2:	_def			- default value to use instead
Returns:
	value			- found value
Examples:
	[_pad,"cache",[500,600]] call ai_ins_fnc_findParam;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ['_pad','_param','_def'];

// Throw an error if missing critical params
if (isNil "_pad") exitWith {
	'ai_ins_fnc_findParam: MISSING _pad' call debug_fnc_log;
};
if (isNil "_param") exitWith {
	'ai_ins_fnc_findParam: MISSING _param' call debug_fnc_log;
};

// get variables from pad namespace
private _var = _pad getVariable [_param,_def];

// return found variables
_var