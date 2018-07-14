//-----------------------------------------------------------------------------
// --- SETTINGS ---
//-----------------------------------------------------------------------------


// ----------------------------------------------------------------------------
//Setting: mission_ace_spec_modes
//
//Used in:
// 	ace_spec_fnc_onRespawn
//
//Description:
//	Only leave the modes you want to array
//	Requires atleast 1 mode
//	[1] - only internal cameras
//	[1,2] - internal and external only
//
//Values:
// ARRAY: (remove these to remove the mode)
// 	[
//		0,			- Free
//		1,			- Internal
//		2			- External
//	]
// ----------------------------------------------------------------------------
#define ACE_SPEC_SETTING_MODES [1,2]
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
//Setting: mission_ace_spec_sides
//
//Used in:
// 	ace_spec_fnc_onRespawn
//
//Description:
//	Sides that are allowed to be spectated
//	Requires atleast 1 side
//	[west] - only west units can be spectated
//	[(side player)] - side the players are on
//	[west,(side player)] - player side and west
//
//	Can also be set per player using "unit_ace_spec_sides"
//
//Values:
// ARRAY:
// 	[
//		west,			- west side allowed
//		east,			- east side allowed
//		resistance,		- resistance side allowed
//		civilian,		- civilian side allowed
//		(side player)	- player side
//	]
// ----------------------------------------------------------------------------
#define ACE_SPEC_SETTING_SIDES [(side player)]
// ----------------------------------------------------------------------------
