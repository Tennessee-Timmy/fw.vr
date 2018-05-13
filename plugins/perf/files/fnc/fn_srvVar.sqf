/* ----------------------------------------------------------------------------
Function: perf_fnc_srvVar

Description:
	Sets variable on the server
	Runs on a client
	Uses player as target for variable
	from the client to the client unit on the server

Parameters:
0:	_variable		- string, variable to set on the server
1:	_value			- any, value for the variable to set on server
2:	_client			- bool, also set the variable on the client this is running on

Returns:
	nothing
Examples:
	['perf_pause',false,true] call perf_fnc_srvVar;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

params ['_variable','_value',['_client',true]];

// exit if variable not defined or not a string
if (isNil '_variable' || {!(_variable isEqualType "")}) exitWith {};

private _target = player;
if (isNil '_value') exitWith {
	[_target,[_variable,nil]] remoteExec ['setVariable',2];
	if (_client) then {
		player setVariable [_variable,nil];
	};
};
[_target,[_variable,_value]] remoteExec ['setVariable',2];
if (_client) then {
	player setVariable [_variable,_value];
};