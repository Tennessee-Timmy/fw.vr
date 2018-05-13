//-----------------------------------------------------------------------------
// --- SETTINGS ---
//-----------------------------------------------------------------------------
//Setting: TFR_SETTING_GIVERADIOS
//Used in:
// 	fn_postInit
//Description:
//	Give radios to units automatically by TFAR mod or by this plugin(role dependant)
//	this is done in loadouts
// ----------------------------------------------------------------------------
#define TFR_SETTING_GIVERADIOS false
// ----------------------------------------------------------------------------
//Setting: mission_tfr_radio_personal_<SIDE>
//Used in:
// 	fn_addRadios
//Description:
//	Personal short range radio classname for <side>
//	override with for ex. "mission_tfr_radio_personal_west"
//
//	<side>			- Choices: WEST,EAST,GUER
//
//Values:
//
// 	string			- Radio classname
// ----------------------------------------------------------------------------
//	override with for ex. "mission_tfr_radio_personal_west"
#define TFR_SETTING_RADIO_PERSONAL_WEST "TFAR_rf7800str"
#define TFR_SETTING_RADIO_PERSONAL_EAST "TFAR_pnr1000a"
#define TFR_SETTING_RADIO_PERSONAL_GUER "TFAR_anprc154"
// ----------------------------------------------------------------------------
//	override with for ex. "mission_tfr_radio_sl_west"
#define TFR_SETTING_RADIO_SL_WEST "TFAR_anprc152"
#define TFR_SETTING_RADIO_SL_EAST "TFAR_fadak"
#define TFR_SETTING_RADIO_SL_GUER "TFAR_anprc148jem"
// ----------------------------------------------------------------------------
//	override with for ex. "mission_tfr_radio_lr_west"
#define TFR_SETTING_RADIO_LR_WEST "TFAR_rt1523g"
#define TFR_SETTING_RADIO_LR_EAST "TFAR_mr3000"
#define TFR_SETTING_RADIO_LR_GUER "TFAR_anprc155"
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
//Setting: mission_tfr_personal_dagr
//Description:
//	DAGRS( radio programmers ) will they be added?
//
//Used in:
// 	fn_addRadios
// ----------------------------------------------------------------------------
//	Do personal radios get DAGRs
#define TFR_SETTING_PERSONAL_DAGR false
//	Do squad leads get DAGRs
#define TFR_SETTING_SL_DAGR false
// ----------------------------------------------------------------------------
//Setting: mission_tfr_giveRadios_LR/SL
//
//Used in:
// 	fn_addRadios
//
//Description:
//	Number in end of player variable name (blu_1_1 etc.), which will recieve
//	long range radios automatically.
//
//	LR - who gets long range
//	SL - who gets programmable short range (squad lead radio)
//
//Values:
// 	array			- Array of numbers which if matched will give radios to player
//
//Example:
//	[1,6]			- Gives LR to blu_1_1,blu_1_6. Which are by default SL and TL
// ----------------------------------------------------------------------------
#define TFR_SETTING_GIVERADIOS_LR_SL_LEADER true		// base LR and SL on wether the unit is a group leader (group leaders recieve LR and SL radios if true)
#define TFR_SETTING_GIVERADIOS_LR [1]
#define TFR_SETTING_GIVERADIOS_SL [1,6]
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
//Setting: TFR_SETTING_SETUP_AUTO
//
//Used in:
// 	fn_setupRadios
//
//Description:
//	Setup radio frequencies and channels automatically
//
//Values:
// 	true			- enabled, radios will be automatically setup
//	false			- disabled, radios will not be automatically setup
// ----------------------------------------------------------------------------
#define TFR_SETTING_SETUP_AUTO true
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
//Setting: TFR_SETTING_ENCRYPT_ENABLED
//
//Used in:
// 	fn_setupRadios
//
//Description:
//	Enable encryption, otherwise will use default( unknown value )
//
//Values:
// 	true			- enabled, encryption will be overwritten (used)
//	false			- disabled, encryption will not be changed
// ----------------------------------------------------------------------------
#define TFR_SETTING_ENCRYPT_ENABLED true
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
//Setting: TFR_SETTING_ENCRYPT_SIDES
//
//Used in:
// 	fn_setupRadios
//
//Description:
//	Enable encryption per side
//
//Values:
// 	true			- enabled, sides will get different encryption
//	false			- disabled, all sides will get same encryption
// ----------------------------------------------------------------------------
#define TFR_SETTING_ENCRYPT_SIDES false
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
//Setting: TFR_SETTING_ENCRYPT_GUER
//
//Used in:
// 	fn_setupRadios
//
//Description:
//	Guer/ resitance will share encryption with this faction
//
//Values:
// 	west			- same encryption as west
//	east			- same encryption as east
//	independent		- their own encryption
// ----------------------------------------------------------------------------
#define TFR_SETTING_ENCRYPT_GUER independent
// ----------------------------------------------------------------------------