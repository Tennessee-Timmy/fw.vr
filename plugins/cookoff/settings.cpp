//-----------------------------------------------------------------------------
// --- SETTINGS ---
//-----------------------------------------------------------------------------


// ----------------------------------------------------------------------------
//COOKOFF settings
//
//Used in:
// 	fn_postInit and params.cpp
//
// ----------------------------------------------------------------------------
#define COOKOFF_PARAM_ENABLED			1		//1 Enable cookoff - 0 disable cookoff
// ----------------------------------------------------------------------------
#define COOKOFF_PARAM_BURN				1		//1 Enable ace (burning flame) cookoff - 0 disable it
// ----------------------------------------------------------------------------
// COOKOFF SETTINGS
// missionnamespace var followed by setting define and value
//
// ----------------------------------------------------------------------------
//
// mission_cookOff_enableCookOff
#define COOKOFF_SETTING_ENABLE		 	true		//bool, true to enable
// ----------------------------------------------------------------------------
//
// mission_cookOff_percentToExplode
#define COOKOFF_SETTING_PERCENT		 	0.25		//float, 1 = 100% - 0 = 0%
// ----------------------------------------------------------------------------
//
// mission_cookOff_maxAmmoSmall
#define COOKOFF_SETTING_MAXSMALL		50			//int, maximum amount of bullets to explode
// ----------------------------------------------------------------------------
//
// mission_cookOff_cookOffSmallMinDelay
#define COOKOFF_SETTING_DELAYSMALL	 	0.05		//float, time in seconds that has to pass between every bullet exploding
// ----------------------------------------------------------------------------
//
// mission_cookOff_cookOffSmallRandomDelay
#define COOKOFF_SETTING_DELAYRANDSMALL	0.15		//float, random time added to min delay for bullets
// ----------------------------------------------------------------------------
//
// mission_cookOff_maxAmmoLarge
#define COOKOFF_SETTING_MAXLARGE	 	10			//int, max amount of bigger than bullets to explode (bombs,rockets,tankshells)
// ----------------------------------------------------------------------------
//
// mission_cookOff_cookOffLargeMinDelay
#define COOKOFF_SETTING_DELAYLARGE	 	0.5			//float, time in seconds that has to pass between every large explosion
// ----------------------------------------------------------------------------
//
// mission_cookOff_cookOffLargeRandomDelay
#define COOKOFF_SETTING_DELAYRANDLARGE 	0.25		//float, random time added to min time for non bullets
// ----------------------------------------------------------------------------
//
// mission_cookOff_volume
#define COOKOFF_SETTING_VOLUME		 	4			//float, volume at which cookoff sounds will be played
// ----------------------------------------------------------------------------