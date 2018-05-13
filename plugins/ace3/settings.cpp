//-----------------------------------------------------------------------------
// --- SETTINGS ---
//-----------------------------------------------------------------------------


// ----------------------------------------------------------------------------
//Medical settings / params
//
//Used in:
// 	fn_postInit and params.cpp
//
// ----------------------------------------------------------------------------
// Set this as 0 if you want to use modules to set ace settings
#define ACE3_PARAM_ENABLED				1		//1 Enable plugin settings / 0 disabled
// ----------------------------------------------------------------------------
// REVIVE
#define ACE3_SETTINGS_REVIVE_ENABLE 	0		//1 to enable revive system
#define ACE3_SETTINGS_REVIVE_TIME		601		//seconds, time until death
#define ACE3_SETTINGS_REVIVE_LIVES		1		//revive system lives
// MEDICAL PARAMS
#define ACE3_PARAM_MED_EVERYONE_MEDIC	1		//1 for everyone is a medic (can pak)
#define ACE3_PARAM_MED_LEVEL 			1		//1 - basic/2 - advanced (PARAM)
#define ACE3_PARAM_MED_PLAYER_HEALTH	3		//Player health (PARAM)
#define ACE3_PARAM_MED_INSTADEATH		1		//1 == true, enable instedeath
// MEDICAL
#define ACE3_SETTINGS_AI_HEALTH			1		//ai health
#define ACE3_SETTINGS_AI_UNCON			1		//Allow ai unconciousness (1 allowed/0 not allowed)
#define ACE3_SETTINGS_MED_BLEED			0.75	//Bleeding coef. (lower than 1 to bleed slower)
#define ACE3_SETTINGS_MED_PAIN			1		//Pain coef. (lower than 1 for less pain)
// ADVANCED
#define ACE3_SETTINGS_ADV_WOUNDS		false	//Enable advanced wounds?(wound reopening)
#define ACE3_SETTINGS_ADV_PAK_CONSUME	0		//0, to not, 1 to Consume PAK on use
#define ACE3_SETTINGS_ADV_HITPOINTS		true	//Heal hitpoints with bandages? (also done by surgical kits with rgd ace3)
// CUSTOM
#define ACE3_SETTINGS_LEGSFIX			false	//Allow players to splint legs

// these are not used at the moment
#define ACE3_CUSTOM_DISPERSION			0		//Custom dispersion coeficiant (0.05) to simulate slighly less trained forces	[rgd_overheating_customDispersion]
#define ACE3_CUSTOM_JAM					0		//Custom JAMMING coef. (0.1) to simulate bad weapons / conditions				[rgd_overheating_customJam]
#define ACE3_CUSTOM_SWAYADD				-0.5	//Custom amunt of sway to add, (negative to reduce sway)						[rgd_customAimCoefAdd]
#define ACE3_CUSTOM_SUICIDE				true	//Allow suicides?																[easywayout_canSuicide]
// ----------------------------------------------------------------------------
