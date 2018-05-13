/* ----------------------------------------------------------------------------
Function: briefing_fnc_postInit

Description:
	Loadout init

Parameters:
	none
Returns:
	nothing
Examples:
	call briefing_fnc_postInit;
	Runs in the postInit from functions.cpp

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

if !(hasInterface) exitWith {};

// roster
player createDiarySubject ["roster","Team Roster"];
player createDiaryRecord ["roster", ["Team Roster","<execute expression='[] spawn briefing_fnc_roster'>Click here or press J to open roster</execute><br/>"]];

call briefing_fnc_keyLoop;
briefing_openMap_handle = addMissionEventHandler ["Map",{
	params ["_mapIsOpened","_mapIsForced"];

	// If map is opened open the menu
	if (_mapIsOpened) then {
		call briefing_fnc_keyLoop;
	} else {

		// If map is closed, close the displays
		false call menus_fnc_MenusClose;
	};
}];

// briefing

_briefing = missionNamespace getVariable ["unit_briefing_faction",(side player)];

if ((toLower (str _briefing)) in ["west","guer","east","civ"]) then {
	private _briefingFile = format ["plugins\briefing\briefings\%1.sqf",_briefing];
	_briefingFile call mission_fnc_checkFile;
	call compile preprocessFileLineNumbers 	_briefingFile;
};