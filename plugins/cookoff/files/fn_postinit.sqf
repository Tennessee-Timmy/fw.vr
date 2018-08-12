/* ----------------------------------------------------------------------------
Function: cookoff_fnc_postInit

Description:
	cookoff

Parameters:
	none
Returns:
	nothing
Examples:
	call cookoff_fnc_postInit;
	Runs in the postInit from functions.cpp

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

{
    if (isNil (_x select 0)) then {
        missionNamespace setVariable _x;
    };
} forEach [
    ["mission_cookOff_enableCookOff",           COOKOFF_SETTING_ENABLE],

    ["mission_cookOff_percentToExplode",        COOKOFF_SETTING_PERCENT],

    ["mission_cookOff_maxAmmoSmall",            COOKOFF_SETTING_MAXSMALL],
    ["mission_cookOff_cookOffSmallMinDelay",    COOKOFF_SETTING_DELAYSMALL],
    ["mission_cookOff_cookOffSmallRandomDelay", COOKOFF_SETTING_DELAYRANDSMALL],

    ["mission_cookOff_maxAmmoLarge",            COOKOFF_SETTING_MAXLARGE],
    ["mission_cookOff_cookOffLargeMinDelay",    COOKOFF_SETTING_DELAYLARGE],
    ["mission_cookOff_cookOffLargeRandomDelay", COOKOFF_SETTING_DELAYRANDLARGE],

    ["mission_cookOff_volume",                  COOKOFF_SETTING_VOLUME],
    ["mission_cookOff_smallSounds",             ["z\ace\addons\cookoff\sounds\light_crack_close_filtered.wss"]],
    ["mission_cookOff_largeSounds",             ["z\ace\addons\cookoff\sounds\cannon_crack_close_filtered.wss","z\ace\addons\cookoff\sounds\heavy_crack_close.wss"]]
];

// remove ace cookoff
[] spawn {
    sleep 1;
    ace_cookoff_enableAmmoCookoff = false;
    ace_cookoff_enableAmmoBox = false;
};
if (!isServer) exitWith {};
["ace_cookoff_enableAmmoCookoff", !(missionNamespace getVariable ['mission_cookoff_enabled',COOKOFF_PARAM_ENABLED]), true, "mission", false] call CBA_settings_fnc_set;
["ace_cookoff_enable", (missionNamespace getVariable ['mission_cookoff_burn',COOKOFF_PARAM_BURN]), true, "mission", false] call CBA_settings_fnc_set;
["ace_cookoff_ammoCookoffDuration", 0.001, true, "mission", false] call CBA_settings_fnc_set;

