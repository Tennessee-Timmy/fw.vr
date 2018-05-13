//-----------------------------------------------------------------------------
// --- SETTINGS ---
//-----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
//Setting: mission_casualty_cap_sides
//
//Used in:
// 	fn_postInit
//
//Description:
//	Sides for which casualty cap is enabled.
//
//Values:
// ARRAY of sides 		- [west,east]
// ----------------------------------------------------------------------------
#define CASUALTY_CAP_SETTING_SIDES [west,east]
// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
//Setting: mission_casualty_cap_empty
//
//Used in:
// 	fn_postInit
//
//Description:
//	Is causalty cap enabled if there are no players on a side
//
//Values:
// 	true			- Yes, mission will end once all players disconenct
//	false			- No, mission will only end if there's atleast 1 player for a side and he is dead
// ----------------------------------------------------------------------------
#define CASUALTY_CAP_SETTING_EMPTY	false
// ----------------------------------------------------------------------------


// ----------------------------------------------------------------------------
//Parameter: p_casualty_cap_limit
//SETTING: mission_casualty_cap_limit
//Description:
// 	Percentage of dead people required for mission to end
//Values:
// [
//		0,	// disabled
//		5,	// 50%
//		7,	// 70%
//		8,	// 80%
//		9,	// 90%
//		10	// 100%
//	]
// ----------------------------------------------------------------------------
#define CASUALTY_CAP_PARAM_LIMIT 10
// ----------------------------------------------------------------------------
