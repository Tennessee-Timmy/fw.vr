//-----------------------------------------------------------------------------
// --- SETTINGS ---
//-----------------------------------------------------------------------------


// ----------------------------------------------------------------------------
//Setting: mission_tpb_allow_unarmed
//
//Used in:
// 	fn_postInit
//
//Description:
// 	Can players use third person if they are unarmed (no weapon in hands)
//	This only works if p_tpb_mode is 1
//
//Values:
// 	true			- Players can use third person if they are unarmed
//	false			- Players can not use third person if they are unarmed
// ----------------------------------------------------------------------------
#define TPB_SETTING_ALLOW_UNARMED true
// ----------------------------------------------------------------------------



//-----------------------------------------------------------------------------
//  --- PARAMETERS ---
//-----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
//Parameter: p_tpb_mode
//Description:
// 	Which kind of third person block to use in this mission
//Values:
//	0		- Third person blocked 100%
//	1		- Only drivers can use third person
//	2		- Everyone can use third person at all time
// ----------------------------------------------------------------------------
#define TPB_PARAM_MODE 1
// ----------------------------------------------------------------------------