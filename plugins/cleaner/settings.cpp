//-----------------------------------------------------------------------------
// --- SETTINGS ---
//-----------------------------------------------------------------------------
//Setting: mission_cleaner_enabled
//Description:
//	enable/disable cleaners
//Values:
//	boolean		- true to enable cleaner
// ----------------------------------------------------------------------------
#define CLEANER_SETTINGS_ENABLED		true
// ----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//Setting: mission_cleaner_badsList
//Description:
//	The list of bad stuff you want cleared. Vehicle Classnaems etc.
//Values:
//	array		- Array of bad boys to remove, you can add a classname of a vehicle to have a vehicle removed
// ----------------------------------------------------------------------------
#define CLEANER_SETTINGS_BADS			["WeaponHolder","GroundWeaponHolder","WeaponHolderSimulated","CraterLong_small","CraterLong","#dynamicsound","#destructioneffects","#track","#particlesource"]
// ----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
//Setting: mission_cleaner_<min/dist/distveh/distlow/minveh,maxVeh>
//Description:
//	to change priroity:
//		unit setVariable ['unit_cleaner_priority',5];
//		//would mean it is not going to be deleted as fast as normal bodies
//Used in: fn_cleanUp
//
// ----------------------------------------------------------------------------
#define CLEANER_SETTINGS_TOOCLOSE		25		//dead units in this range will not be deleted
#define CLEANER_SETTINGS_MIN			15		//Minimum amount of bodies to initialize smart checks(based on priority etc.)
#define CLEANER_SETTINGS_DISTLOW		1000	//dumb check distance (based only on distance)
#define CLEANER_SETTINGS_DIST			300		//Required distance from players for bodies to be deleted
#define CLEANER_SETTINGS_DISTVEH		1500	//distance from dead vehicles to be deleted
#define CLEANER_SETTINGS_MINVEH			10		//amount of dead vehicles required to delte dead vehicles
#define CLEANER_SETTINGS_IMMOBILE		true	//clean immobile vehicles?
#define CLEANER_SETTINGS_MAXVEH			10		//Amount of vehicles required for broken down vehicle cleanup (immobile)
// ----------------------------------------------------------------------------