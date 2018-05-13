/* ----------------------------------------------------------------------------
Function: tfr_fnc_preInit

Description:
	Tfr init

Parameters:
	none
Returns:
	nothing
Examples:
	call tfr_fnc_preInit;
	Runs in the postInit from functions.cpp

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// set up radios for loadout plugins
missionNamespace setVariable ["mission_tfr_radio_personal_west",TFR_SETTING_RADIO_PERSONAL_WEST];
missionNamespace setVariable ["mission_tfr_radio_personal_east",TFR_SETTING_RADIO_PERSONAL_EAST];
missionNamespace setVariable ["mission_tfr_radio_personal_guer",TFR_SETTING_RADIO_PERSONAL_GUER];

missionNamespace setVariable ["mission_tfr_radio_sl_west",TFR_SETTING_RADIO_SL_WEST];
missionNamespace setVariable ["mission_tfr_radio_sl_east",TFR_SETTING_RADIO_SL_EAST];
missionNamespace setVariable ["mission_tfr_radio_sl_guer",TFR_SETTING_RADIO_SL_GUER];

missionNamespace setVariable ["mission_tfr_radio_lr_west",TFR_SETTING_RADIO_LR_WEST];
missionNamespace setVariable ["mission_tfr_radio_lr_east",TFR_SETTING_RADIO_LR_EAST];
missionNamespace setVariable ["mission_tfr_radio_lr_guer",TFR_SETTING_RADIO_LR_GUER];


if !(isMultiplayer) exitWith {};
if (hasInterface) then {
	call tfr_fnc_setupRadios;
};