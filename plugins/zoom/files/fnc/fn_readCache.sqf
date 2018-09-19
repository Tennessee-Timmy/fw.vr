/* ----------------------------------------------------------------------------
Function: zoom_fnc_readCache

Description:
	reads value for the name from config, if no value found runs code and saves the return into the value

Parameters:
	none
Returns:
	nothing
Examples:
	call zoom_fnc_readCache

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

params ['_name','_code',['_params',[]]];

private _value = mission_zoom_cache getVariable _name;
if (!isNil '_value') exitWith {_value};
_value = _params call _code;
mission_zoom_cache setVariable [_name,_value];
_value