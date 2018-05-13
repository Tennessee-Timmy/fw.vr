//-----------------------------------------------------------------------------
// --- PARAMS ---
//-----------------------------------------------------------------------------


// ----------------------------------------------------------------------------
//Setting: mission_safe_time
//Parameter: p_safe_time
//
//Used in:
// 	fn_postInit
//
//Description:
// 	For how long are the safe zones enabled for
//	if this time runs out, safezones are disabled until function is ran again
//
//Values:
// 	60000					- infinite	/ 1000 minutes
//	0						- disabled
//	10						- seconds
//	30						- seconds
//	60						- seconds	/ 1 minute
//	120						- seconds	/ 2 minutes
//	300						- seconds	/ 5 minutes
//	600						- seconds	/ 10 minutes
// ----------------------------------------------------------------------------
#define SAFE_PARAM_TIME 120
// ----------------------------------------------------------------------------


// ----------------------------------------------------------------------------
//Setting: mission_safe_restrict_time
//Parameter: p_safe_restrict_time
//
//Used in:
// 	fn_postInit
//
//Description:
// 	For how long are the restrict zones enabled for
//	if this time runs out, restrictions are disabled until time is enabled
//
//Values:
// 	60000					- infinite	/ 1000 minutes
//	0						- disabled
//	10						- seconds
//	30						- seconds
//	60						- seconds	/ 1 minute
//	120						- seconds	/ 2 minutes
//	300						- seconds	/ 5 minutes
//	600						- seconds	/ 10 minutes
// ----------------------------------------------------------------------------
#define SAFE_PARAM_RESTRICT_TIME 0
// ----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// --- SETTINGS ---
//-----------------------------------------------------------------------------


// ----------------------------------------------------------------------------
//Setting: mission_safe_zones
//
//Used in:
// 	fn_postInit
//
//Description:
// 	Defines the array of safe zones
//	For global safety, just use AO marker
//	This is used on the client. So bear that in mind when using array
//
//Values:
// 	array			- containing area markers / triggers or area or boolean
//					- boolean to enable everything as safezone
//					- markers MUST be strings
//					- based on https://community.bistudio.com/wiki/inArea
//					- MUST BE DEFINED PROPERLY
//
// ----------------------------------------------------------------------------
#define SAFE_SETTING_ZONES ["safeZone_1",safezone_2,true]
// ----------------------------------------------------------------------------


// ----------------------------------------------------------------------------
//Setting: mission_safe_disableDamage
//
//Used in:
// 	fn_postInit
//
//Description:
//	disables damage for players when they are inside of the safe zone
//
//Values:
//	bool				- true to disable damage (make invincible)
//
// ----------------------------------------------------------------------------
#define SAFE_SETTING_DISABLEDAMAGE true
// ----------------------------------------------------------------------------


// ----------------------------------------------------------------------------
//Setting: mission_safe_restrict_zones_<west/east/guer/civi>
//
//Used in:
// 	fn_postInit
//
//Description:
// 	Defines the array of restriction zones (the area you can't leave)
//	This is used on the client. So bear that in mind when using array
//
//Values:
// 	array			- containing area markers / triggers or area or boolean
//					- boolean to enable everything as safezone
//					- markers MUST be strings
//					- based on https://community.bistudio.com/wiki/inArea
//					- MUST BE DEFINED PROPERLY
//
// ----------------------------------------------------------------------------
#define SAFE_SETTING_RESTRICT_ZONES_WEST [respawn_round_1,respawn_round_2]
#define SAFE_SETTING_RESTRICT_ZONES_EAST [respawn_round_1,respawn_round_2]
#define SAFE_SETTING_RESTRICT_ZONES_GUER [respawn_round_1,respawn_round_2]
#define SAFE_SETTING_RESTRICT_ZONES_CIVI [respawn_round_1,respawn_round_2,safezone_2]
// ----------------------------------------------------------------------------


// ----------------------------------------------------------------------------
//Setting: mission_safe_restrict_sides
//
//Used in:
// 	fn_postInit
//
//Description:
// 	Array of sides, for which the restrictions apply to
//
//Values:
// 	array			- containing area markers / triggers or area or boolean
//					- boolean to enable everything as safezone
//					- markers MUST be strings
//					- based on https://community.bistudio.com/wiki/inArea
//					- MUST BE DEFINED PROPERLY
//
// ----------------------------------------------------------------------------
#define SAFE_SETTING_RESTRICT_SIDES [west,east,resistance,civilian]
// ----------------------------------------------------------------------------
