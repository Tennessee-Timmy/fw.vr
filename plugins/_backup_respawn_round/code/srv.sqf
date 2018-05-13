// contains code to run on certain events that occur only on the server
// do not rename this file
#include "..\settings.cpp"


// when round prep. starts
_onPrepCodeSrv = {

	//--- safe and restriction
	// get preptime
	private _prepTime = missionNamespace getVariable ["mission_respawn_round_prepTime",RESPAWN_ROUND_PARAM_PREPTIME];

	// enable safe and restriction
	missionNamespace setVariable ['mission_safe_pause',false,true];
	missionNamespace setVariable ['mission_safe_restrict_pause',false,true];
	[_prepTime+5,false] call safe_fnc_setTime;
	[_prepTime,true] call safe_fnc_setTime;
};

// when a new round starts
_onRoundStartCodeSrv = {
	missionNamespace setVariable ['mission_safe_pause',true,true];
	missionNamespace setVariable ['mission_safe_restrict_pause',true,true];

};

// when a round ends
_onRoundEndCodeSrv = {
	missionNamespace setVariable ['mission_safe_pause',false,true];
	[99,false] call safe_fnc_setTime;

};

