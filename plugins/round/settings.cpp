//-----------------------------------------------------------------------------
// --- SETTINGS ---
//-----------------------------------------------------------------------------


// ROUND
// ----------------------------------------------------------------------------
//Parameter: p_round_mode
//Variable:	mission_round_mode
//Description:
// 	Mode of the game?
//Values:
//	0			- A single random map is played and the game ended
//	1			- A single voted map is played and the game is ended
//	2			- 3 random maps played and game ended
//	3			- 3 voted maps played and game ended
//	4			- Random maps
//	5			- Voted maps
// ----------------------------------------------------------------------------
#define ROUND_PARAM_MODE 1
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
//Parameter: p_round_time
//Variable:	mission_round_time
//Description:
// 	Duration of a round
//Values:
//	1,2,3,5,10,15,20,30,60,120 - time in minutes
//	to use 0.1,0.5, 1.5, 2.5 minutes, use 999,1000,1001,1002
// ----------------------------------------------------------------------------
#define ROUND_PARAM_TIME 3
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
//Parameter: p_round_prepTime
//Variable:	mission_round_prepTime
//Description:
//	time to prepare before every round (freezetime kinda thingy)
//Values:
//	1,5,10,15,20,30,60,120 - time in seconds
// ----------------------------------------------------------------------------
#define ROUND_PARAM_PREPTIME 10
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
//Parameter: p_round_count
//Variable:	mission_round_count
//Description:
// 	How many rounds are there?
//	Game will end when this is reached and winner decided based on victories
//	Ties settled, by comparing alive counts on the final round
//Values:
//	1,2,3,4,5,10,100 - amount of respawn rounds
// ----------------------------------------------------------------------------
#define ROUND_PARAM_COUNT 10
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
//Parameter: p_round_count_win
//Description:
// 	First team to reach this amount of vitories will win
//	EX:	Allows for total rounds 10 and needed to win 3
//		useful for > 2 sides
//Values:
//	1,2,3,4,5,10,100 - amount of respawn rounds
// ----------------------------------------------------------------------------
#define ROUND_PARAM_COUNT_WIN 3
// ----------------------------------------------------------------------------

//
// SETTINGS:
// time for between location switch: (mission_round_switchTime)
#define ROUND_SETTING_SWITCHTIME 10

// time before the game starts (before first round): (mission_round_startTime)
#define ROUND_SETTING_STARTTIME 10


//---old
/*
// ----------------------------------------------------------------------------
//variable:	mission_round_sidesAmount
//Description:
// 	Amount of sides to be used
//	SIDES MUST BE DEFINED BELOW
//
//Values:
//	number				- a intiger number of how many sides are goign to be used in this
// ----------------------------------------------------------------------------
//	Amount of sides to use
#define ROUND_SETTING_SIDESAMOUNT 2
// ----------------------------------------------------------------------------
*/



// ----------------------------------------------------------------------------
//variable: mission_round_sides
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
#define ROUND_SETTING_SIDES [['BLUFOR',west],['OPFOR',east]]
// ----------------------------------------------------------------------------
// Current implementation for hostages and other special sides:
// mission_round_sidesLocked
// sides that will never change sides
#define ROUND_SETTING_SIDELOCKED []		// side name, location to use, fake location nr,not scoring(true - hide from HUD/skip scoring || false - show on HUD/score)
// ----------------------------------------------------------------------------

/* ----------------------------------------------------------------------------
variable: mission_round_aoList
Description:
 	Array of locations

Values:
0:	_name:
	The name of the area/location set
	must be lowercaps, no spaces or special characters
	Will be used to load map files / available in conditions and other codes.
	AO codes run before all other codes

	YOU can also add title / text for the ao in the code file ex:
		_aoTitleText = 'AirPort';
		_aoDescText = '';

1:	_locations:
	The value inside the array can be:
		area			- anything based on https://github.com/CBATeam/CBA_A3/blob/master/addons/common/fnc_randPosArea.sqf#L18
						- or https://community.bistudio.com/wiki/inArea
						- to use a marker area, use the following array: ["marker",false]

		object			- object's location will be used
		marker			- marker position will be used
		position		- array with 3 elements (getposASL)

	You can add custom code to when player is moved to location by
	name based on array element number
	making a file in code folder name loc_<number>.sqf (ex. loc_0.sqf)
	this code runs before side code

	At this time you have to make sure the area is empty of objects manually

2:	_aoMaker:
	The ao marker that will mark the ao(camera will also rotate around this area)

	You can add custom code for ao by using ao_0 (based on array element number)


3:	_locExtra:
	extra parameters for the location (camera height custom pos etc.)


---------------------------------------------------------------------------- */
// this is just added to make formatting easier
#define ROUND_AO1 ['de_cinder',[respawn_round_1,respawn_round_2],'ao']
#define ROUND_AO2 ['de_cinder_ext',[respawn_round_3,respawn_round_4],'ao_1']
#define ROUND_AO3 ['de_gas',[respawn_round_5,respawn_round_6],'ao_2',[((getMarkerPos 'marker_16')),50]]
#define ROUND_AO4 ['de_air',[respawn_round_7,respawn_round_8],'ao_3']

//
#define ROUND_SETTING_AOLIST [ROUND_AO1,ROUND_AO2]

// ----------------------------------------------------------------------------
// mission_round_aoWait
//	How long should we wait for the ao to be chosen? (time to vote for map)
#define ROUND_SETTING_AOWAIT 30
// ----------------------------------------------------------------------------

// switch locations every x rounds
//	mission_round_locSwitch
#define ROUND_SETTING_LOCSWITCH 1000
// ----------------------------------------------------------------------------

// todo
// a setting to make the winner the (players) with most round wins instead (zombie/spy/ttt)

// todo
// random location

// todo side code
// todo loc code