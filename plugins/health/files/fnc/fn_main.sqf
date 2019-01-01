#include "script_component.cpp" //
/////////////////////////////////
if (mission_supp_threshold > 0) then {
	private _subtract = call {
		if (((time - mission_supp_lastShotAt) <= 1.75)) exitWith {0};
		if (mission_supp_suppressed) exitWith {1.2};
		2
	};
	mission_supp_threshold = (mission_supp_threshold - _subtract) max 0;
};
