/* ----------------------------------------------------------------------------
Function: respawn_fnc_deadHudScriptAdd

Description:
	Adds or removes the deadhud for the target
	[] to add to everyone
Parameters:
0:	_add			- true to add, false to remove
1:	_targets		- Array of targets so which add the deadhud
Returns:
	nothing
Examples:
	// adds the deadhud to mission scripts
	[true] call respawn_fnc_deadHudScriptAdd;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params [["_add",false],["_targets",[""]]];

// code to be added/removed
_codeOnRespawn = {call respawn_fnc_deadHudShow};
_codeOnRespawnUnit = {[] spawn respawn_fnc_deadHudClose};


// Remove all instances of this script from the target
[_targets,_codeOnRespawnUnit,"onRespawnUnit"] call respawn_fnc_scriptRemove;
[_targets,_codeOnRespawn,"onRespawn"] call respawn_fnc_scriptRemove;

// Add it if add it's allowed to be added
if (_add) exitWith {
	[_targets,_codeOnRespawnUnit,"onRespawnUnit",true] call respawn_fnc_scriptAdd;
	[_targets,_codeOnRespawn,"onRespawn",true] call respawn_fnc_scriptAdd;
};
