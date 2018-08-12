/* ----------------------------------------------------------------------------
Function: supp_fnc_postInit

Description:
	runs everything for the supperssion

Parameters:
	none
Returns:
	nothing
Examples:
	call supp_fnc_postInit;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

if (!(hasInterface) || isDedicated) exitWith {supp_fnc_fired = {}};

// Color Correction
mission_supp_cc = ppEffectCreate ["colorCorrections", 1501];
mission_supp_cc ppEffectAdjust [1, 1, 0, [0,0,0,0], [1,1,1,1],[1,1,1,0]];
mission_supp_cc ppEffectEnable true;
mission_supp_cc ppEffectCommit 0;

// Blur
mission_supp_blur = ppEffectCreate ["DynamicBlur", 800];
mission_supp_blur ppEffectAdjust [0];
mission_supp_blur ppEffectCommit 0.3;
mission_supp_blur ppEffectEnable true;

// RBlur
mission_supp_rBlur = ppEffectCreate ["RadialBlur", 1003];
mission_supp_rBlur ppEffectAdjust [0, 0, 0, 0];
mission_supp_rBlur ppEffectCommit 0;
mission_supp_rBlur ppEffectEnable true;


mission_supp_impactCC = ppEffectCreate ["colorCorrections", 1499];
mission_supp_impactCC ppEffectAdjust [1, 1, 0, [0,0,0,0], [1,1,1,1],[1,1,1,0]];
mission_supp_impactCC ppEffectEnable true;
mission_supp_impactCC ppEffectCommit 0;

mission_supp_impactBlur = ppEffectCreate ["RadialBlur", 1002];
mission_supp_impactBlur ppEffectAdjust [0, 0, 0, 0];
mission_supp_impactBlur ppEffectCommit 0;
mission_supp_impactBlur ppEffectEnable true;

// Check if active, exec script if so
[supp_fnc_mainHandler] call CBA_fnc_addPerFrameHandler;
[supp_fnc_main, 1] call CBA_fnc_addPerFrameHandler;
[supp_fnc_pinnedDown, 0.5] call CBA_fnc_addPerFrameHandler;

["unit", {

    // Resets PinnedDown PP Effects
  mission_supp_suppressed = false;
  mission_supp_cc ppEffectAdjust [1, 1, 0, [0,0,0,0], [1,1,1,1],[1,1,1,0]];
  mission_supp_cc ppEffectCommit 0;

  // Blur
  mission_supp_blur ppEffectAdjust [0];
  mission_supp_blur ppEffectCommit 0;

  // RBlur
  mission_supp_rBlur ppEffectAdjust [0, 0, 0, 0];
  mission_supp_rBlur ppEffectCommit 0;

    // reset Variables that PPEffects dont get reactivated
    mission_supp_threshold = 0;
    mission_supp_lastShotAt = 0;

    // Resets Impact PP Effects
    mission_supp_impactBlur ppEffectAdjust [0, 0, 0, 0];
    mission_supp_impactBlur ppEffectCommit 0;

    mission_supp_impactCC ppEffectAdjust [1, 1, 0, [0,0,0,0], [1,1,1,1],[1,1,1,0]];
    mission_supp_impactCC ppEffectCommit 0;

    // rest CamShake Effect
    resetCamShake;
}] call CBA_fnc_addPlayerEventHandler;




// hit reactions
// todo make sure this is working after respawn

a2k_hitBlur = {
  if (alive player) then {
    "dynamicBlur" ppEffectEnable true;
    "dynamicBlur" ppEffectAdjust [7];
    "dynamicBlur" ppEffectCommit 0;
    "dynamicBlur" ppEffectAdjust [0.0];
    "dynamicBlur" ppEffectCommit 1.5;
  };
};



a2k_hitBlur = {
    if (alive player) then {
        //if !(isNull objectParent player) exitWith {};

        if (random 1 > 0.8) then {
            private _safeWeapons = player getVariable ['ace_safemode_safedWeapons',[]];
            if ((currentWeapon player) in _safeWeapons) exitWith {};

            player forceWeaponFire [currentWeapon player,(weaponState player)#2];
        };

        0 = ["ColorCorrections", 15000, [
                0.0, 0.0, 0.0,
            [
                0.3, 0, 0, 1
            ], [
                1, 1, 1, 0
            ], [
                1, 1, 1, 0
            ],[
                // maybe first values at 0?
                0.7,0.6,0,0,0,0.2,0.3
        ]]] spawn {
            params ["_name", "_priority", "_effect", "_handle"];
            while {
            _handle = ppEffectCreate [_name, _priority];
            _handle < 0
            } do {
            _priority = _priority + 1;
            };
            _handle ppEffectEnable true;
            _handle ppEffectAdjust _effect;
            _handle ppEffectCommit 0.05;
            waitUntil {ppEffectCommitted _handle};
            uiSleep 0.3;
            _handle ppEffectAdjust [
                1,
                1,
                0,
                [0., 0, 0, 0],
                [1, 1, 1, 1],
                [0.299, 0.587, 0.114, 0],
                [1.9,1.7,0,0,0,0.2,0.3]
            ];
            _handle ppEffectCommit 0.7;
        };
        0 = ["WetDistortion", 15, [-50, 0, 0.4, 40.10, 30.70, 2.50, 1.85, 0.0054, 0.0041, 0.05, 0.0070, 0.01, 0.01, 1, 1]] spawn {
            params ["_name", "_priority", "_effect", "_handle"];
            while {
                _handle = ppEffectCreate [_name, _priority];
                _handle < 0
            } do {
                _priority = _priority + 1;
            };
            _handle ppEffectEnable true;
            _handle ppEffectAdjust _effect;
            _handle ppEffectCommit 0.15;
            waitUntil {ppEffectCommitted _handle};
            uiSleep 0.15;
            _handle ppEffectAdjust [
                0,
                0, 0,
                4.10, 3.70, 2.50, 1.85,
                0.0054, 0.0041, 0.0090, 0.0070,
                0.5, 0.3, 10.0, 6.0
            ];
            _handle ppEffectCommit 0.5;
        };
    };
};
player addEventHandler ["Hit", { (_this select 0) spawn a2k_hitBlur; }];

a2k_explBlur = {
  if (alive player) then {
    "dynamicBlur" ppEffectEnable true;
    "dynamicBlur" ppEffectAdjust [5];
    "dynamicBlur" ppEffectCommit 0;
    "dynamicBlur" ppEffectAdjust [0.0];
    "dynamicBlur" ppEffectCommit 1;
  };
};
player addEventHandler ["Explosion", { (_this select 0) spawn a2k_explBlur; }];