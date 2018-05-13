/* ----------------------------------------------------------------------------
Function: ai_ins_fnc_setParam

Description:
	finds the parameter from pad and replaces it

Parameters:
0:  _pad			- pad to use
1:	_param			- name of param (string)
2:	_value			- new value for the param
3:	_pub			- set as public variable
Returns:
	array			- modified array
Examples:
	[_pad,"cache",[500,600]] call ai_ins_fnc_setParam;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ['_pad','_param','_value',['_pub',false]];

// Throw an error if missing critical params
if (isNil "_pad") exitWith {
	'ai_ins_fnc_setParam: MISSING _pad' call debug_fnc_log;
};
if (isNil "_param") exitWith {
	'ai_ins_fnc_setParam: MISSING _param' call debug_fnc_log;
};

// set the variable in pad namespace
_pad setVariable [_param,_value,_pub];