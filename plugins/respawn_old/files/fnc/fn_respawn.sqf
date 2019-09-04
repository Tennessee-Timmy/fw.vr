/* ----------------------------------------------------------------------------
Function: respawn_fnc_respawn
Description:
	Will remoteExec the respawn script on the server

Parameters:
0:	_targets	- Targets to respawn: Unit(s), Group, Side, player name or nothing for all players
Returns:
	nothing
Examples:
	call respawn_fnc_respawn;
	[west] call respawn_fnc_respawn;
	[west,east,resistance,civilian] call respawn_fnc_respawn;
	["nigel"] call respawn_fnc_respawn;
	[_unit] call respawn_fnc_respawn;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

[_this] params [["_targets", [], [[]]]];
if (_targets isEqualTo []) then {
    _targets = [west,east,resistance,civilian];
};

// Call the respawns from the server
_targets remoteExec ["respawn_fnc_srvRespawn",2];