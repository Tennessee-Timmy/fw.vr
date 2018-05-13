// contains code to run on certain events that occur only on the client
// code will be run on all clients (all sides / locations)
// do not rename this file
#include "..\settings.cpp"


// 0.1 seconds after death (spectator starts)
_onRespawnCode = {

};
// when spectator is closed
_onRespawnUnitCode = {

};
// when round prep. starts
_onRoundPrepCode = {
	// should make it so units are teleported before being restricted
	missionNamespace setVariable ['mission_safe_restrict_pause',false];

};
// when a new round starts
_onRoundStartCode = {
	missionNamespace setVariable ['mission_safe_restrict_pause',true];

	//[objNull,player] call ten_fnc_wearBomb;

};
// when a round ends
_onRoundEndCode = {

};