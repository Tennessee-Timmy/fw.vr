// contains code to run on certain events that occur only on the server
// do not rename this file
#include "..\settings.cpp"


// to use ao:
// private _aoName = missionNamespace getVariable ['mission_round_aoName',''];
// when round prep. starts
_onPrepCodeSrv = {

	//--- safe and restriction
	// get preptime
	private _prepTime = missionNamespace getVariable ["mission_round_prepTime",ROUND_PARAM_PREPTIME];

	// enable safe and restriction
	missionNamespace setVariable ['mission_safe_pause',false,true];
	[_prepTime+5,false] call safe_fnc_setTime;
	[_prepTime,true] call safe_fnc_setTime;
};

// when a new round starts
_onRoundStartCodeSrv = {
	missionNamespace setVariable ['mission_safe_pause',true,true];

};

// when a round ends
_onRoundEndCodeSrv = {
	missionNamespace setVariable ['mission_safe_pause',false,true];
	[99,false] call safe_fnc_setTime;

};

// when a game starts
_onGameStartCodeSrv = {
	missionNamespace setVariable ['mission_safe_pause',false,true];
	[99,false] call safe_fnc_setTime;

};

// when a game ends
_onGameEndCodeSrv = {
	missionNamespace setVariable ['mission_safe_pause',false,true];
	[99,false] call safe_fnc_setTime;

};