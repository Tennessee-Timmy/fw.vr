#include "script_component.cpp" //
/////////////////////////////////
if (mission_supp_threshold >= BORDER) then {
	if (alive player) then {
		if (!mission_supp_suppressed) then {
			mission_supp_suppressed = true;
		};
		_workValue = (mission_supp_threshold - BORDER) / (MAXSUPP - BORDER);
		addCamShake
		[
			(_workValue * 1.3),		// Power 1.0
			2 + (_workValue * 23),	// Frequency
			1.5						// Duration
		];

		mission_supp_blur ppEffectAdjust [(_workValue * 0.40)];//1.28
		mission_supp_blur ppEffectCommit 0.5;

		mission_supp_cc ppEffectAdjust [1, 1, 0, [0,0,0,0], [1,1,1,(1 - (_workValue * 0.05))],[1,1,1,0]];//0.4
		mission_supp_cc ppEffectCommit 0.5;

		mission_supp_rBlur ppEffectAdjust [(_workValue * 0.01), (_workValue * 0.01), 0.2, 0.2];// 0.011 (both)
		mission_supp_rBlur ppEffectCommit 0.05;
	};
} else {
	if mission_supp_suppressed then {
		mission_supp_suppressed = false;
		mission_supp_cc ppEffectAdjust [1, 1, 0, [0,0,0,0], [1,1,1,1],[1,1,1,0]];
		mission_supp_cc ppEffectCommit 0;

		// Blur
		mission_supp_blur ppEffectAdjust [0];
		mission_supp_blur ppEffectCommit 0.3;

		// RBlur
		mission_supp_rBlur ppEffectAdjust [0, 0, 0, 0];
		mission_supp_rBlur ppEffectCommit 1;
	};
};



