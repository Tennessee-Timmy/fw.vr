//-----------------------------------------------------------------------------
// --- SETTINGS ---
//-----------------------------------------------------------------------------


// WAVE
// ----------------------------------------------------------------------------
//Parameter: p_respawn_wave_time
//Description:
// 	Respawn wave time, starts ticking when first player dies
//Values:
//	0,1,5,10,20,30,60,120 - time in minutes
// ----------------------------------------------------------------------------
#define RESPAWN_WAVE_PARAM_TIME 5
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
//Parameter: p_respawn_wave_delay
//Description:
// 	Respawn wave delay, the timeframe in which units can still respawn
//Values:
//	1,5,10,20,30,60,120 - time in seconds
// ----------------------------------------------------------------------------
#define RESPAWN_WAVE_PARAM_DELAY 20
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
//Parameter: p_respawn_wave_count
//Description:
// 	Respawn wave count per side
//Values:
//	0,1,2,3,4,5,10,1000 - amount of respawn waves
// ----------------------------------------------------------------------------
#define RESPAWN_WAVE_PARAM_COUNT 5
// ----------------------------------------------------------------------------


// SETTINGS
// ----------------------------------------------------------------------------
//Parameter: mission_respawn_wave_side_<west/east/guer/civi>
//Description:
// 	Which side respawns does the side use, this means wave count and timers
//Values:
//	west,east,resistance,civilian
//
//Individual setting
//	You can setvariable for player to force a side
//
//	player setVariable ['unit_respawn_wave_side',west,true];
//	^ forces west side for any unit
//
//
//
// ----------------------------------------------------------------------------
#define RESPAWN_WAVE_SETTING_SIDE_WEST west
#define RESPAWN_WAVE_SETTING_SIDE_EAST east
#define RESPAWN_WAVE_SETTING_SIDE_GUER west	// west and resistance players share waves/time	/ default: resistance
#define RESPAWN_WAVE_SETTING_SIDE_CIVI civilian
// ----------------------------------------------------------------------------
