//-----------------------------------------------------------------------------
// --- SETTINGS ---
//-----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
//Setting: mission_loadout_auto_enabled
//Setting: mission_loadout_auto_cargo
//Setting: mission_loadout_auto_unit
//
//Used in:
// 	fn_preInit
//
//Description:
//	Enable auto loadouts for vehicles, boxes, units (not players)
//	for zeus missions you probably want this disabled.
//
//Values:
// 	false			- auto loadouts disabled
//	true			- auto loadouts enabled
// ----------------------------------------------------------------------------
#define LOADOUT_SETTING_AUTO_ENABLED	true
#define LOADOUT_SETTING_AUTO_CARGO		true
#define LOADOUT_SETTING_AUTO_UNIT		true
#define LOADOUT_SETTING_AUTO_PLAYER		true		// Disables player loadouts (also on respawn)
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
//Setting: LOADOUT_SETTING_LIST
//
//Used in:
// 	fn_menu
//
//Description:
//	This list is used for zeus/admin to change the loadout from a drop list
//	Add all loadouts from loadouts folder here
//	Must be array!
//	only add the name in qoutes without file extension
//	EXAMPLE:
//		nato.sqf	-->		"nato"
//
//Values:
// 	array			- Contains strings of loadouts
// ----------------------------------------------------------------------------
#define LOADOUT_SETTING_FACTIONS		["nato","csat","aaf"]
// ----------------------------------------------------------------------------


// ----------------------------------------------------------------------------
//Setting: mission_loadout_faction_<WEST/EAST/GUER/CIV>
//
//Used in:
// 	fn_unit/cargo
//
//Description:
//	Define side auto-detection faction
//	CaSe sEnSiTiVe, must match a loadout file in loadouts folder
//
//	"disabled" to disable loadout for side
//	mission_loadout_faction_civ = "disabled";
//	"empty" to make units naked
//	player setVariable ["unit_loadout_faction","disabled"];
//	if you set this as anything wrong like "aids" it will error and unit will not recieve a loadout
//	Leave as "" or [] for auto detection based on side and settings below
//	LOADOUT_SETTING_FACTION_WEST etc.
//
//Values:
// 	string			- faction loadout which must exist in the loadouts folder
// ----------------------------------------------------------------------------
#define LOADOUT_SETTING_FACTION_WEST	"nato"
#define LOADOUT_SETTING_FACTION_EAST	"csat"
#define LOADOUT_SETTING_FACTION_GUER	"aaf"
#define LOADOUT_SETTING_FACTION_CIV		"disabled"
// ----------------------------------------------------------------------------