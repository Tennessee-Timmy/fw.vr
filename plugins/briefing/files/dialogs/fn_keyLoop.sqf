/* ----------------------------------------------------------------------------
Function: briefing_fnc_keyLoop

Description:
	A loop that adds keydown eventhandlers to a bunch of displays

Parameters:
	none
Returns:
	nothing
Examples:
	call briefing_fnc_keyLoop
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// Allow saving display as variable
disableSerialization;
private _nil = {
	if !(_x isEqualTo displayNull) then {
		private _keyDown = (findDisplay _x) displayAddEventHandler ["KeyDown", {
			call briefing_fnc_keyDown;
		}];
	};
	false
} count [37,12,63,52,53,603000];