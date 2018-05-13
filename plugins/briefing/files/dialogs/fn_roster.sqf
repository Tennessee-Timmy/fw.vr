/* ----------------------------------------------------------------------------
Function: briefing_fnc_roster

Description:
	Handles the showing of dead texts
	used in onload

Parameters:
	none
Returns:
	nothing
Examples:
	[] spawn briefing_fnc_roster
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// Allow saving display as variable
disableSerialization;
{
	if !(_x isEqualTo displayNull) then {
 		_display = (findDisplay _x) createDisplay "briefing_roster";

		((findDisplay 603000) displayCtrl 1000) ctrlSetEventHandler ["mouseMoving",'
			disableSerialization;
			params ["_display","_xPos","_yPos","_inside"];
			if (_inside) exitWith {};
			[603000] call menus_fnc_displayCloser;

		'];
	};
	false
} count [37,12,63,52,53];	//[37,52,53,12]
//[_display] spawn {(_this select 0) closeDisplay 1;};

// close display after 37 is closed
//waitUntil {(findDisplay 37) isEqualTo displayNull};
//[603000] call menus_fnc_displayCloser;
