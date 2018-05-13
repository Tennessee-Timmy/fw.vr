/* ----------------------------------------------------------------------------
Function: respawn_fnc_deadText

Description:
	Shows text when player is dead
	use middle when important text. Side will be overwritten by newer text.

	ex. middle:
		You have 10 waves remaining.
		You've committed too many warcrimes, respawn time increased

	ex. side:
		You have 10 seconds until respawning
		You suck! (subliminal)


Parameters:
0:	_text		- text to show
1:	_middle		- true will Show text in the middle instead of side
2:	_time		- How long until text will be hidden
Returns:
	nothing
Examples:
	// Show text in middle for 10 seconds
	["Wrong HOUSE!",true,10] call respawn_fnc_deadText;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_text",["_middle",false],["_time",3]];

// Get old list
if (isNil "respawn_deadTextList") then {
	respawn_deadTextList = [];
};

// Add the new text
(respawn_deadTextList) pushBack [_text,_middle,_time];