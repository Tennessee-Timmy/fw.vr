//-----------------------------------------------------------------------------
// --- SETTINGS ---
//-----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
//Setting: SEED_SETTING_GETVARSTARGET_WAITTIME
//Used in:
// 	seed_fnc_getVarsTarget
//
//Description:
//	Max time to wait for a variable to return from remote client
//
//Values:
// 	number	- Amount of time in seconds
// ----------------------------------------------------------------------------
#define SEED_SETTING_GETVARSTARGET_WAITTIME 3
// ----------------------------------------------------------------------------
//Setting: SEED_SETTING_CLEANSEEDS_MAX
//Used in:
// 	seed_fnc_cleanSeeds
//Description:
// 	Max amount of seeds allowed to remain after cleaning
// 	Cleans seeds from ALL missions
//Values:
// 	number	- MAX amount of seeds
// ----------------------------------------------------------------------------
#define SEED_SETTING_CLEANSEEDS_MAX 10
// ----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//  --- PARAMETERS ---
//-----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
//Parameter: p_seed_reset
//Description:
// 	Will the seed be reset
//Values:
//	1		- True, the seed will be reset
//	0		- False, the seed will no be reset and loaded instead (if exists)
//-----------------------------------------------------------------------------
#define SEED_PARAM_RESET 1
//-----------------------------------------------------------------------------