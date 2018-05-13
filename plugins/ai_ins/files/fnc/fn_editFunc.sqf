/* ----------------------------------------------------------------------------
Function: ai_ins_fnc_editFunc

Description:
	Does functions for groups by adding the functions to the func que

Parameters:
0:  _groups				- Array of groups to edit
1:	_funcs				- functions array to apply
	x:	_array			- 1 function array
		0:	_name		- function to perform
		1:	_param		- extra params for the functon

Returns:
	nothing
Examples:
	[_groups,[['cache']]] call ai_ins_fnc_editFunc;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params [['_groups',[]],['_funcs',[[]]]];

// make everything in funcs lowerCaps
_funcs = _funcs apply {[(toLower (_x param [0])),(_x param [1])]};

// get garrison que and group que
// garrsion que
private _funcQG = missionNamespace getVariable 'ai_ins_garrison_funcQ';
if (isNil '_funcQG') then {
	_funcQG = [];
	missionNamespace setVariable ['ai_ins_garrison_funcQ',_funcQG];
};
// normal que
private _funcQ = missionNamespace getVariable 'ai_ins_groups_funcQ';
if (isNil '_funcQ') then {
	_funcQ = [];
	missionNamespace setVariable ['ai_ins_groups_funcQ',_funcQ];
};

// loop through all the groups to apply function to
{

	// call for exitWith
	call {

		// pad as private variable
		private _pad = _x;

		// detect if garrison
		private _garr = [(_pad)] call ai_ins_fnc_detGarr;

		// if garrisoned, do garrison checks
		if (_garr) exitWith {

			// loop through all the functions needed to run
			{
				_x params ['_name','_params'];

				// check the function names and run functions
				if ('cache' isEqualTo _name) then {
					_funcQG pushback [_pad,{_this call ai_ins_fnc_gCache}];
				};
				if ('uncache' isEqualTo _name) then {
					_funcQG pushback [_pad,{_this call ai_ins_fnc_gUnCache}];
				};
				if ('ungarrison' isEqualTo _name) then {
					_funcQG pushback [[_pad,_params],{_this call ai_ins_fnc_unGarrison}];
				};
			} forEach _funcs;
		};

		// loop through, for the groups (not garrisoned)
		{
			_x params ['_name','_params'];

			// check function names and run functions
			if ('cache' isEqualTo _name) then {
				_funcQ pushback [_pad,{_this call ai_ins_fnc_cache}];
			};
			if ('uncache' isEqualTo _name) then {
				_funcQ pushback [_pad,{_this call ai_ins_fnc_unCache}];
			};
		} forEach _funcs;
	};
} forEach _groups;
