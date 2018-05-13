/* ----------------------------------------------------------------------------
Function: loadout_fnc_roleList

Description:
	Return list of roles (for menu plugin)

Parameters:
	none
Returns:
	nothing
Examples:
	call loadout_fnc_roleList;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
disableSerialization;

[
	["Officer","officer"],

	["Squad leader","sl"],

	["Team leader","tl"],

	["FAC","fac"],

	["Medic","medic"],

	["Paramedic","paramedic"],

	["Light MG","lmg"],

	["Light MG Ass.","lmgAss"],

	["Medium MG","mmg"],

	["Medium MG Ass.","mmgAss"],

	["Heavy MG","hmg"],

	["Heavy MG Ass.","hmgAss"],

	["Grenade MG","gmg"],

	["Grenade MG Ass.","gmgAss"],

	["Light AT","lat"],

	["Medium AT","mat"],

	["Medium AT Ass.","matAss"],

	["Heavy AT","hat"],

	["Heavy AT Ass.","hatAss"],

	["AA","aa"],

	["AA Ass.","aaAss"],

	["Marksman","marksman"],

	["Grenadier","grenadier"],

	["Pointman","pointman"],

	["Rifleman","rifleman"],

	["Recon SL","reconsl"],

	["Recon team leader","recontl"],

	["Recon scout","reconscout"],

	["Recon scout (at)","reconlat"],

	["Recon marksman","reconmarksman"],

	["Recon demo specialist","recondemo"],

	["Recon paramedic","reconparamedic"],

	["Diver","diver"],

	["Crewman","crew"],

	["Pilot","pilot"],

	["Heli pilot","helipilot"],

	["Engineer","engineer"],

	["Explosive specialist","demo"],

	["UAV operator","uav"],

	["Mortar","mortar"],

	["Mortar Ass.","mortarAss"],

	["Sniper","sniper"],

	["Spotter","spotter"],

	["custom 1","custom1"],

	["custom 2","custom2"],

	["custom 3","custom3"],

	["custom 4","custom4"],

	["custom 5","custom5"],

	["AUTO","","Role will be auto selected"]
]