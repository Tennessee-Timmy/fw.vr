/* ----------------------------------------------------------------------------
Function: ai_ins_fnc_copyParams

Description:
	Copies parameters from pad

Parameters:
0:	_fromPad			- pad to get variables from
1:	_toPad				- (optional), pad to put variables on

Returns:
	_array				- array of parameters
Examples:
	[_fromPad,_toPad] call ai_ins_fnc_copyParams;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ['_fromPad','_toPad'];

// Throw an error if missing critical params
if (isNil "_fromPad") exitWith {
	'ai_ins_fnc_copyParams: MISSING _fromPad' call debug_fnc_log;
};

// get variable names from pad namespace
private _varns = allVariables _fromPad;
private _vars = [];

// loop through all variable names
private _nil = {

	// get value for variable
	private _val = _fromPad getVariable _x;

	// make sure value is not nil
	if (!isNil '_val') then {

		// push to vars
		_vars pushBack [_x,_val];
	};
	false
} count _varns;



// if toPad exists set variables for it.
if (!isNil '_toPad' && {!isNull _toPad}) then {
	{
		_x params ['_var','_val'];
		_toPad setVariable [_var,_val];
	} count _vars;

	private _cached = [_pad,"cached",false] call ai_ins_fnc_findParam;
	[_pad,"cached",_cached,true] call ai_ins_fnc_setParam;

	private _garr = [_pad,"garrison",false] call ai_ins_fnc_findParam;
	[_pad,"garrison",_garr,true] call ai_ins_fnc_setParam;
};

// return found variables
_vars