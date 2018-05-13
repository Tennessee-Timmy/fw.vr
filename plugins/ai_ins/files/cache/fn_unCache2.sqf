/* ----------------------------------------------------------------------------
Function: ai_ins_fnc_unCache2

Description:
	Caching check. Checks if players are in distance

Parameters:
0:  _pos			- Position
0:  _side			- Side
0:  _amount			- Amount
0:  _extra			- Array with parameters
Returns:
	bool			- are players inside the distance (< _distance)
Examples:
	_array call ai_ins_fnc_unCache2

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ['_pos',['_side',east],['_amount',1],['_extra',[]]];

// keep the array
private _arr = _this;

// set as cached2
[_extra,"cached2",false] call ai_ins_fnc_setParam;

// show all units
private _nil = {
	[_x,false] remoteExec ["hideObjectGlobal",2];
	[_x,true] remoteExec ["enableSimulationGlobal",2];
	true
} count units _group;
