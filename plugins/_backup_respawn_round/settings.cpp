//-----------------------------------------------------------------------------
// --- SETTINGS ---
//-----------------------------------------------------------------------------


// ROUND
// ----------------------------------------------------------------------------
//Parameter: p_respawn_round_time
//Variable:	mission_respawn_round_time
//Description:
// 	Duration of a round
//Values:
//	1,2,3,5,10,15,20,30,60,120 - time in minutes
//	to use 0.1,0.5, 1.5, 2.5 minutes, use 999,1000,1001,1002
// ----------------------------------------------------------------------------
#define RESPAWN_ROUND_PARAM_TIME 999
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
//Parameter: p_respawn_round_prepTime
//Variable:	mission_respawn_round_prepTime
//Description:
//	time to prepare before every round (freezetime kinda thingy)
//Values:
//	1,5,10,15,20,30,60,120 - time in seconds
// ----------------------------------------------------------------------------
#define RESPAWN_ROUND_PARAM_PREPTIME 1
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
//Parameter: p_respawn_round_count
//Variable:	mission_respawn_round_count
//Description:
// 	How many rounds are there?
//	Game will end when this is reached and winner decided based on victories
//	Ties settled, by comparing alive counts on the final round
//Values:
//	1,2,3,4,5,10,100 - amount of respawn rounds
// ----------------------------------------------------------------------------
#define RESPAWN_ROUND_PARAM_COUNT 10
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
//Parameter: p_respawn_round_count_win
//Description:
// 	First team to reach this amount of vitories will win
//	EX:	Allows for total rounds 10 and needed to win 3
//		useful for > 2 sides
//Values:
//	1,2,3,4,5,10,100 - amount of respawn rounds
// ----------------------------------------------------------------------------
#define RESPAWN_ROUND_PARAM_COUNT_WIN 3
// ----------------------------------------------------------------------------

//
// SETTINGS:
// time for between location switch: (mission_respawn_round_switchTime)
#define RESPAWN_ROUND_SETTING_SWITCHTIME 3

// time before the game starts (before first round): (mission_respawn_round_startTime)
#define RESPAWN_ROUND_SETTING_STARTTIME 3


// ----------------------------------------------------------------------------
//variable: mission_respawn_round_sides
//Description:
// 	Array of arrays, each element is a side
//	contains the people in that side
//
//Values:
//	The first value is a string containg the name
//	of the side
//
//	The value inside the array can be:
//		side(s)			- all units from this side will be on this side
//		string(s)		: the following must be string (to work with unslotted units)
//			group		- all units in this group will be on this side
//			unit			- these units will be on this side
//
//
//Examples:
//	// west and east vs resistance and civilian
//	[['Good Guys',west,east],['Bad Guys',resistance,civilian]]
//
//	// 1 guy from west vs rest west
//	[['Zombies','blu_5_3'],['Survivors',west]]
//
//	// 2 guys vs west
//	[['Spys','blu_0_1','blu_0_2'],['Blufor',west]]
//
//	// 4 groups
//	[['Alpha','blu_1'],['Bravo','blu_2'],['Charlie','blu_3'],['Delta','blu_4']]
//
//	If a unit is already in one side, he can't be in other sides
//	[['blufor',west],['zombie','blu_0_1']]	// WONT WORK, because blu_0_1 is already included in west
//	[['zombie','blu_0_1'],['blufor,west]]	// WORKS, because blu_0_1 already in a side and it won't be added to 2nd side
//
//
//
//	to add custom code, add the code files in the code folder
//	the files must have the same name as the sides below
//	files MUST be lower cap, but names don't have to be lowercaps
//	ex. blufor.sqf
//	this code runs after location code
// ----------------------------------------------------------------------------
#define RESPAWN_ROUND_SETTING_SIDES [['BLUFOR',west],['OPFOR',east],['HOSTAGES',civilian]]
// ----------------------------------------------------------------------------
// Current implementation for hostages and other special sides:
// mission_respawn_round_sidesLocked
// sides that will never change sides
#define RESPAWN_ROUND_SETTING_SIDELOCKED [['HOSTAGES',safeZone_2,99,true]]		// side name, location to use, fake location nr,not scoring(true - hide from HUD/skip scoring || false - show on HUD/score)
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
//variable: mission_respawn_round_loc
//Description:
// 	Array of locations
//
//Values:
//	The value inside the array can be:
//		area			- anything based on https://github.com/CBATeam/CBA_A3/blob/master/addons/common/fnc_randPosArea.sqf#L18
//						- or https://community.bistudio.com/wiki/inArea
//						- to use a marker area, use the following array: ["marker",false]
//
//		object			- object's location will be used
//		marker			- marker position will be used
//		position		- array with 3 elements (getposASL)
//
//	You can add custom code to when player is moved to location by
//	name based on array element number
//	making a file in code folder name loc_<number>.sqf (ex. loc_0.sqf)
//	this code runs before side code
//
//	At this time you have to make sure the area is empty of objects manually
//
//
// ----------------------------------------------------------------------------
#define RESPAWN_ROUND_SETTING_LOC [respawn_round_1,respawn_round_2]

// switch locations every x rounds
//	mission_respawn_round_locSwitch
#define RESPAWN_ROUND_SETTING_LOCSWITCH 2
// ----------------------------------------------------------------------------

// todo
// a setting to make the winner the (players) with most round wins instead (zombie/spy/ttt)

// todo
// random location

// todo side code
// todo loc code