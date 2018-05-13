//-----------------------------------------------------------------------------
// --- SETTINGS ---
//-----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
//Setting: mission_escape_variable
//Used in:
// 	escape_fnc_postInit
//
//Description:
//	Set this variable true in the task code for your task. You will have to do this manually.
//	You can also just set the variable anywhere else. It does not have to be defined.
//
//Values:
//	string		- containing the variable name which must be true for the escape to be enabled
// ----------------------------------------------------------------------------
#define ESCAPE_SETTING_VARIABLE "nig_enable_escape"
// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
//Setting: mission_escape_sides
//Used in:
// 	escape_fnc_postInit
//
//Description:
//	Sides that must escape
//
//Values:
//	array of sides
// ----------------------------------------------------------------------------
#define ESCAPE_SETTING_SIDES [west]
// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
//Setting: mission_escape_everyone
//Used in:
// 	escape_fnc_postInit
//
//Description:
//	Do everyone have to escape or can you escape alone?
//
//Values:
//	true		- everyone has to escape
// 	false		- once a player escapes, he is immediately sent into spectator
// ----------------------------------------------------------------------------
#define ESCAPE_SETTING_EVERYONE true
// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
//Setting: mission_escape_location
//Used in:
// 	escape_fnc_postInit
//
//Description:
//	Location which you must reach to escape
//	Or which you must escape from
//
//Values:
//	object/marker
// ----------------------------------------------------------------------------
#define ESCAPE_SETTING_LOCATION "mission_escape_marker"
// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
//Setting: mission_escape_away
//Used in:
// 	escape_fnc_postInit
//
//Description:
//	Do you have to escape away or to the location?
//
//Values:
//	true		- you must get away from the location
//	false		- you must get to the location
// ----------------------------------------------------------------------------
#define ESCAPE_SETTING_AWAY true
// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
//Setting: mission_escape_distance
//Used in:
// 	escape_fnc_postInit
//
//Description:
//	Distance required to be reached
//	if away then distance to be away from location
//	if not away then distance requirted to be to location
//
//Values:
//	number		- distance in meters
//	true		- marker/trigger area used instead
// ----------------------------------------------------------------------------
#define ESCAPE_SETTING_DISTANCE true
// ----------------------------------------------------------------------------