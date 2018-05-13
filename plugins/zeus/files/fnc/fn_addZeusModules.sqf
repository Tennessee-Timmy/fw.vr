/* ----------------------------------------------------------------------------
Function: zeus_fnc_addZeusModules

Description:
	Add custom module to zeus
	Requires achilles

Parameters:
	none
Returns:
	nothing
Examples:
	// Use this to register custom modules
	call zeus_fnc_addZeusModules;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// code begins

// Leave if achilles is not loaded
if !(isClass (configFile >> "CfgPatches" >> "achilles_modules_f_achilles")) exitWith {};

["* Mission Zeus", "Check Performance",
{
	call zeus_fnc_displayPerf;
}] call Ares_fnc_RegisterCustomModule;