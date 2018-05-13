/* ----------------------------------------------------------------------------
Function: ai_ins_fnc_cacheCheck

Description:
	Caching check. Checks if players are in distance

Parameters:
0:	_pos			- Position from where to check
1:	_distance		- Distance from position

Returns:
	bool			- are players inside the distance (< _distance)
Examples:
	[_pos,_distance] call ai_ins_fnc_cacheCheck;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ['_pos',['_distance',500]];

// get 3d pos from object / marker
if (_pos isEqualType objNull) then {
	_pos = getPos _pos;
};
if (_pos isEqualType "") then {
	_pos = getMarkerPos _pos;
};

// Targets to check
private _players = allPlayers;

// Get all targets closer than distance
private _near =  _players inAreaArray [_pos,_distance,_distance,0,false];

// returns false if nothing was near
!(_near isEqualTo [])