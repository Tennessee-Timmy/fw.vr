/* ----------------------------------------------------------------------------
Function: ai_ins_fnc_onCuratorClosed

Description:
	Runs when display closed

Parameters:
0:  _display         - display that got closed (curator display)
Returns:
	nothing
Examples:
	_this call ai_ins_fnc_onCuratorClosed;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

["ai_ins_curatorLoop", "onEachFrame"] spawn BIS_fnc_removeStackedEventHandler;

private _markers = missionNamespace getVariable ['ai_ins_curatorMarkers',[]];

{
	_x params ['_marker','_pos','_arr'];
	deleteMarkerLocal _marker;
} forEach _markers;

missionNamespace setVariable ["ai_ins_curatorLoopOpen",false];