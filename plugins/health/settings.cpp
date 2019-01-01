//-----------------------------------------------------------------------------
// --- SETTINGS ---
//-----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
//Setting: mission_health_enable
//Used in:
// 	health_fnc_postInit
//
//Description:
//	Enable Health ( can be disabled per client (unit_supp_enable) and mid mission)
//
//Values:
// 	bool		- true to enable
// ----------------------------------------------------------------------------
#define HEALTH_SETTING_ENABLE true
// ----------------------------------------------------------------------------
//Setting: mission_health_coef
//Used in:
//	health_fnc_postInit
//
//Description:
//	How big is the damage coef?
//Values:
//
// 	float		- How big the effect is (bigger = more damage (die faster))
// ----------------------------------------------------------------------------
#define HEALTH_SETTING_RATE 1
// ----------------------------------------------------------------------------
