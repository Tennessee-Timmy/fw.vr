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