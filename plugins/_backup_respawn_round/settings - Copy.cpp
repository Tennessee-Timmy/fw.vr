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
//	1,3,5,10,15,20,30,60,120 - time in minutes
// ----------------------------------------------------------------------------
#define RESPAWN_ROUND_PARAM_TIME 3
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
//Parameter: p_respawn_round_delay
//Variable:	mission_respawn_round_delay
//Description:
// 	Respawn round delay, time between rounds
//Values:
//	1,5,10,20,30,60,120 - time in seconds
// ----------------------------------------------------------------------------
#define RESPAWN_ROUND_PARAM_DELAY 10
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
#define RESPAWN_ROUND_PARAM_COUNT 3
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
#define RESPAWN_ROUND_PARAM_COUNT_WIN 2
// ----------------------------------------------------------------------------

//
// SETTINGS:
// time for prep every round: (mission_respawn_round_prepTime)
#define RESPAWN_ROUND_SETTING_PREPTIME 10

// time before the game starts: (mission_respawn_round_startTime)
#define RESPAWN_ROUND_SETTING_STARTTIME 15


// ----------------------------------------------------------------------------
//variable:	mission_respawn_round_sidesAmount
//Description:
// 	Amount of sides to be used
//	SIDES MUST BE DEFINED BELOW
//
//Values:
//	number				- a intiger number of how many sides are goign to be used in this
// ----------------------------------------------------------------------------
//	Amount of sides to use
#define RESPAWN_ROUND_SETTING_SIDESAMOUNT 2
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
//variable: mission_respawn_round_sides
//Description:
// 	Array of arrays, each element is a side
//	contains the people in that side
//
//Values:
//	The first value is a array containg the name and loadout override
//	if defined, overwrites location loadout and normal loadout
//	['west']		- which loadout to use in this position
//	The roles can be choosen here:
//	2nd element is leader role
//	rest of the roles will be given given 1 by 1
//	['west','sl',['rifleman','medic','lat','lmg']]
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
//	[[['Good Guys'],west,east],[['Bad Guys'],resistance,civilian]]
//
//	// 1 guy from west vs rest west
//	[[['Zombies'],'blu_5_3'],[['Survivors'],west]]
//
//	// 2 guys vs west
//	[[['Spys'],'blu_0_1','blu_0_2'],[['Blufor'],west]]
//
//	// 4 groups
//	[[['Alpha'],'blu_1'],[['Bravo'],'blu_2'],[['Charlie'],'blu_3'],[['Delta'],'blu_4']]
//
//	If a unit is already in one side, he can't be in other sides
//	[[['blufor'],west],[['zombie'],'blu_0_1']]	// WONT WORK, because blu_0_1 is already included in west
//	[[['zombie'],'blu_0_1'],[['blufor'],west]]	// WORKS, because blu_0_1 already in a side and it won't be added to 2nd side

// ----------------------------------------------------------------------------
#define RESPAWN_ROUND_SETTING_SIDES [[['BLUFOR'],west],[['OPFOR',['csat']],east]]
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
//variable: mission_respawn_round_loc
//Description:
// 	Array of locations and loadouts
//
//Values:
//	The 1st elemnet inside the array can be:
//		area			- anything based on https://github.com/CBATeam/CBA_A3/blob/master/addons/common/fnc_randPosArea.sqf#L18
//						- or https://community.bistudio.com/wiki/inArea
//						- to use a marker area, use the following array: ["marker",false]
//
//		object			- object's location will be used
//		marker			- marker position will be used
//		position		- array with 3 elements (getposASL)
//
//
//	2nd Element:
//		if defined, sets loadout, but overwritten by sides loadout
//		['west']		- which loadout to use in this position
//
//		The roles can be choosen here:
//		2nd element is leader role
//		rest of the roles will be given given 1 by 1
//		['west','sl',['rifleman','medic','lat','lmg']]
//
//
//
//
//
// ----------------------------------------------------------------------------
#define RESPAWN_ROUND_SETTING_LOC [[respawn_round_1,['nato']],[respawn_round_2]]
// ----------------------------------------------------------------------------

// todo
// a setting to make the winner the (players) with most round wins instead (zombie/spy/ttt)

// todo
// random location