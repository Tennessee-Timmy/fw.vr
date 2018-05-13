// contains code to be checked as conditions
// do not rename this file
//
// it automatically checks for when all of 1 side are dead
// it automatically checks if amount of rounds needed to win has been reached
//
//
// variables:
//	_sideName			- name of the side
//	_sideUnits			- units that will be checked
//	_toRoundEnd			- time until round end
//	_aoName				- name of the AO
#include "..\settings.cpp"


// to win a round (all other sides lose)
_roundWinCode = {

	// this will make it so there are no ties, game will end once time to round end is less than 0 and sideLocation is 0
	false
};

// to lose a round (all other sides win)
_roundLoseCode = {

	// makes sure units are awake
	_sideUnits = _sideUnits select {
		(!isNil '_x') &&
		(!isNull _x) &&
		([_x] call ace_common_fnc_isAwake)
	};

	// this function checks if all the units are dead
	_sideUnits call respawn_fnc_areDead
};

// code which will run when round time runs out
_roundTimeOutCode = {

	// enable safe zone (no killing)
	missionNamespace setVariable ['mission_safe_pause',false,true];
	[100,false] call safe_fnc_setTime;

};


// to win the whole game (all other sides lose)
_gameWinCode = {
	false
};

// to lose the game (all other sides win)
_gameLoseCode = {
	false
};