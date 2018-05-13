//-----------------------------------------------------------------------------
// --- SETTINGS ---
//-----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
//Setting: mission_respawn_jip
//
//Used in:
// 	fn_postInit
//
//Description:
//	Allow players to jip
//
//Values:
// 	true			- jip allowed
//	false			- players who jip will start dead
// ----------------------------------------------------------------------------
#define RESPAWN_SETTING_JIP true
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
//Setting: mission_respawn_deadHudEnabled
//
//Used in:
// 	fn_postInit
//
//Description:
//	Enables deadhud for players
//
//Values:
// 	true			- dead hud will be enabled for all players
//	false			- dead hud will be disabled for all players
// ----------------------------------------------------------------------------
#define RESPAWN_SETTING_DEADHUD true
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
//Setting: mission_respawn_base_location_<west/east/ind/civ>
//
//	Override: Change setting to a object or location used for respawn during mission
//	PLEASE BE SURE ALL OF THESE EXIST OR IT WILL BREAK!
//
//Used in:
// 	respawn_fnc_default_respawn
//
//Description:
//	Respawn base object or location
//
//Values:
// 	object OR position	- Location which is used for respawn
// ----------------------------------------------------------------------------
#define RESPAWN_SETTING_BASE_WEST base_blu_1
#define RESPAWN_SETTING_BASE_EAST base_op_1
#define RESPAWN_SETTING_BASE_IND base_ind_1
#define RESPAWN_SETTING_BASE_CIV base_civ_1
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
//Setting: mission_respawn_notify
//Setting: mission_respawn_notifyEveryone
//
//Used in:
// 	fn_notify
//
//Description:
//	Are players notified of respawns? Do all sides see all respawns?
//
//Values:
//	NOTIFY			- True to enable notifications
//	NOTIFYEVERYONE	- True to notify players about all sides, false for only player side
// ----------------------------------------------------------------------------
#define RESPAWN_SETTING_NOTIFY true
#define RESPAWN_SETTING_NOTIFYEVERYONE true
// ----------------------------------------------------------------------------


// ----------------------------------------------------------------------------
//Parameter: p_respawn_location
//Description:
// 	Respawn location to be used
//Values:
//	0		- Default/ marker
//	1		- Base/ object
// ----------------------------------------------------------------------------
#define RESPAWN_PARAM_LOCATION 1
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
//Setting: mission_respawn_jipCode
//
//Used in:
// 	fn_postInit
//
//Description:
//	Code to run when player jips
//	Parameters: player
//	U can change this via:
//		missionNamespace setVariable ['mission_respawn_jipCode',{/*CODE HERE*/}];
//
//Values:
// 	CODE			- Code to run when player has jiped (after dead check in postInit)
// ----------------------------------------------------------------------------
#define RESPAWN_SETTING_JIPCODE {}
// ----------------------------------------------------------------------------