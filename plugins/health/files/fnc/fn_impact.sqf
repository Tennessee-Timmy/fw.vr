#include "script_component.cpp" //
/////////////////////////////////
if !(alive player) exitWith {};
if ((isNull objectParent player) || (isTurnedOut player)) then {

    mission_supp_impactBlur ppEffectAdjust [0.015, 0.015, 0.2, 0.2];
    mission_supp_impactBlur ppEffectCommit 0;
	mission_supp_impactCC ppEffectAdjust [1, 1, 0, [0,0,0,0.4], [1,1,1,1],[1,1,1,0]];
	mission_supp_impactCC ppEffectCommit 0;

	mission_supp_impactBlur ppEffectAdjust [0, 0, 0, 0];
	mission_supp_impactBlur ppEffectCommit 0.5;
	mission_supp_impactCC ppEffectAdjust [1, 1, 0, [0,0,0,0], [1,1,1,1],[1,1,1,0]];
	mission_supp_impactCC ppEffectCommit 0.25;

	// Makes the player twitch if it's been a while since he was getting shot at
	if ((time - mission_supp_lastShotAt) >= 120) then {
		addCamShake [3,0.4, 80];
	};
};
