/* ----------------------------------------------------------------------------
Function: ace3_fnc_postInit

Description:
	Ace3

Parameters:
	none
Returns:
	nothing
Examples:
	call ace3_fnc_postInit;
	Runs in the postInit from functions.cpp

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// Check if enabled
waitUntil {!isNil "mission_ace3_enabled"};
private _enabled = (missionNamespace getVariable ["mission_ace3_enabled",true]);
if !(_enabled) exitWith {};


// wait for server to be done
if (!isServer) then {
    waitUntil {!isNil 'mission_ace3_srvDone'};
};

//
if (isServer && ("respawn" in mission_plugins)) then {
    [[""],{call ace3_fnc_onRespawn},"onRespawn",true] call respawn_fnc_scriptAdd;
};

//ACE 3 CUSTOM =================================================================


rgd_overheating_customDispersion = (missionNamespace getVariable ["rgd_overheating_customDispersion",ACE3_CUSTOM_DISPERSION]);
rgd_overheating_customJam = (missionNamespace getVariable ["rgd_overheating_customJam",ACE3_CUSTOM_JAM]);
rgd_customAimCoefDisable = false;
rgd_customAimCoefAdd = (missionNamespace getVariable ["rgd_customAimCoefAdd",ACE3_CUSTOM_SWAYADD]);
easywayout_canSuicide = ACE3_CUSTOM_SUICIDE;

//ACE 3 Revive Settings ========================================================


if (hasInterface) then {
    player setVariable ["ace_medical_amountOfReviveLives",ace_medical_amountOfReviveLives,true];
};

//ACE 3 Medical ================================================================


if (hasInterface) then {
	private _dmg = (missionNamespace getVariable ["mission_ace3_med_player_health",ACE3_PARAM_MED_PLAYER_HEALTH]);
    player setVariable ["ace_medical_unitDamageThreshold",[_dmg,(_dmg*1.3),(_dmg*2)],true];
};

if (hasInterface) then {
    player setVariable ["ace_medical_preventInstaDeath",!(missionNamespace getVariable ["mission_ace3_med_instadeath",ACE3_PARAM_MED_INSTADEATH]),true];
};

if (hasInterface) then {
    player setVariable ["ace_medical_bleedingcoefficient",ACE3_SETTINGS_MED_BLEED,true];
};
if (hasInterface) then {
    player setVariable ["ace_medical_painCoefficient",ACE3_SETTINGS_MED_PAIN,true];
};

// only run for clients who are admins
if (hasInterface && ("menus" in mission_plugins) && {call menus_fnc_isAdmin}) then {
    [["ACE3 Plugin","call ace3_fnc_menu",[{true},{false}],true],[player]] call menus_fnc_registerItem;
};

if (hasInterface) then {
    if (mission_ace3_everyone_medic) then {
        player setvariable ["ACE_medical_medicClass", 1, true];
    };

    if (ACE3_SETTINGS_LEGSFIX) then {
        fix_legs = ["leg_fix","<t color='#ff0000'>Apply splint to broken leg</t>","",{[20, [], {player setHitPointDamage ["HitLegs", 0];player playAction "medicStop";}, {player playAction "medicStop";}, "Fixing Legs"] call ace_common_fnc_progressBar;player playAction "medicStart";},{(player getHitPointDamage "HitLegs") >= 0.5}] call ace_interact_menu_fnc_createAction;
        [typeOf player, 1, ["ACE_SelfActions"], fix_legs] call ace_interact_menu_fnc_addActionToClass;
    };
};

// at this point the server is done
if (isServer) then {
    missionNamespace setVariable ['mission_ace3_srvDone',true,true];
};