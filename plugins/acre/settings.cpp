//-----------------------------------------------------------------------------
// --- SETTINGS ---
//-----------------------------------------------------------------------------
//Setting: ACRE_SETTING_GIVERADIOS
//Used in:
// 	fn_postInit
//Description:
//	Give radios based on this plugin automatically (disable if given in loadout)
// ----------------------------------------------------------------------------
#define ACRE_PARAM_GIVERADIOS 0		// 0 - auto | 1 - no auto | 2 - disabled / blocked
#define ACRE_PARAM_SETUPRADIOS 0	// 0 - auto | 1 - no auto | 2 - disabled / blocked
#define ACRE_PARAM_ENABLED 1		// 1- Enable plugin init
// ----------------------------------------------------------------------------
//Setting: mission_acre_radio_personal_<SIDE>
//Used in:
// 	fn_addRadios
//Description:
//	Personal short range radio classname for <side>
//	override with for ex. "mission_acre_radio_personal_west"
//
//	<side>			- Choices: WEST,EAST,GUER
//
//Values:
//
// 	string			- Radio classname
// ----------------------------------------------------------------------------
//	override with for ex. "mission_acre_radio_personal_west"
//	radio for squad comms.
#define ACRE_SETTING_RADIO_PERSONAL_WEST "ACRE_PRC343"
#define ACRE_SETTING_RADIO_PERSONAL_EAST "ACRE_PRC343"
#define ACRE_SETTING_RADIO_PERSONAL_GUER "ACRE_PRC343"
// ----------------------------------------------------------------------------
//	override with for ex. "mission_acre_radio_sl_west"
#define ACRE_SETTING_RADIO_SL_WEST "ACRE_PRC152"
#define ACRE_SETTING_RADIO_SL_EAST "ACRE_PRC152"
#define ACRE_SETTING_RADIO_SL_GUER "ACRE_PRC152"
// ----------------------------------------------------------------------------
//	override with for ex. "mission_acre_radio_lr_west"
#define ACRE_SETTING_RADIO_LR_WEST "ACRE_PRC117F"
#define ACRE_SETTING_RADIO_LR_EAST "ACRE_PRC117F"
#define ACRE_SETTING_RADIO_LR_GUER "ACRE_PRC117F"
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
//Setting: ACRE_SETTING_PRESETS
//Used in:
// 	fn_setupRadios
//Description:
//	Preset names to be used for radios
//
//Values:
//
// 	ARRAY			- containing strings for the presets.
// ----------------------------------------------------------------------------
#define ACRE_SETTING_PRESETS ["west","east","guer"]
// ----------------------------------------------------------------------------
//	What preset does the side use?
//	!!!MUST BE DEFINED ABOVE!!!
//	ex. ["west"] is defined above would mean you can only use west
//	This allows for 2 or more sides to be able to communicate (or not)
//
//	OVERRIDE
//	To force unit to a certain preset:
//	this setVariable ['unit_acre_preset','guer']
//
// ----------------------------------------------------------------------------
#define ACRE_SETTING_PRESET_WEST "west"
#define ACRE_SETTING_PRESET_EAST "east"
#define ACRE_SETTING_PRESET_GUER "guer"
#define ACRE_SETTING_PRESET_CIV "west"
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
//Setting:	ACRE_SETTING_BABLE_ENABLE
//			ACRE_SETTING_BABLE_<side>
//Used in:
// 	fn_setupRadios
//Description:
//	Enable the bable system
//	Allows setting the languages per side
//
//	OVERRIDE
//	To force unit to a certain preset:
//	this setVariable ['unit_acre_babel',["english","russian","estonian"]]
//
// ----------------------------------------------------------------------------
#define ACRE_SETTING_BABLE_ENABLE true
#define ACRE_SETTING_BABLE_WEST ["english"]
#define ACRE_SETTING_BABLE_EAST ["russian"]
#define ACRE_SETTING_BABLE_GUER ["english","russian"]
#define ACRE_SETTING_BABLE_CIV ["estonian"]
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
//Setting:	ACRE_SETTING_GIVERADIOS_<SL/LR>
//			ACRE_SETTING_GIVERADIOS_ROLE_<SL/LR>
//Used in:
// 	fn_addRadios
//Description:
//	LR is long range (backpack), SL is programmable squad lead radio(152/148)
//	number in the end of player variable name that recives LR/SL
//
//	OVERRIDE
//	To force unit to recieve a long range or SL radio:
//	this setVariable ['unit_acre_SL',true]
//	this setVariable ['unit_acre_LR',true]
//
//	ROLE
//	Role which will get the radio
//	This is the role in the 'lobby'
//	ex.
//	in the lobby unit is named 'scooby dooby', and ROLE_LR is ["scooby"]
//	the scooby dooby gets the LR
// ----------------------------------------------------------------------------
#define ACRE_SETTING_GIVERADIOS_LR []
#define ACRE_SETTING_GIVERADIOS_SL [1,6]
// Must be lowercase
#define ACRE_SETTING_GIVERADIOS_ROLE_LR ["commander","fac","radio","pilot"]
#define ACRE_SETTING_GIVERADIOS_ROLE_SL ["spotter"]
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
//Setting: ACRE settings (cba)
//Used in:
// 	fn_postInit
//Description:
//	Changes the CBA settings.
// ----------------------------------------------------------------------------
// Move players to a ts3 channel?
#define ACRE_SETTING_MOVE true
// ----------------------------------------------------------------------------
// Channel to move to in ts3
#define ACRE_SETTING_CHANNEL "ACRE"		// channel name
#define ACRE_SETTING_TSPW ""			// password
// ----------------------------------------------------------------------------
// Enable radio interference ?
#define ACRE_SETTING_INTERFERENCE false
// ----------------------------------------------------------------------------
// Enable full duplex radios ?
#define ACRE_SETTING_DUPLEX true
// ----------------------------------------------------------------------------
// Ignore antenna direction ?
#define ACRE_SETTING_IGNOREANTENNA true
// ----------------------------------------------------------------------------
// Terrain loss coeficiant
#define ACRE_SETTING_TERRAINLOSS 0
// ----------------------------------------------------------------------------
// Can AI hear players?
#define ACRE_SETTING_AI true
// ----------------------------------------------------------------------------


