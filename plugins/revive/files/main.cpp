#include "script_component.cpp"
#ifdef MISSION_PLUGIN_META
	class PLUGIN {
		name = "Revive system";
		version = 1.00;
		authors[] = {"nigel"};
		description = "A replacement for respawn allowing players to revive each other.";
		required[] = {"respawn","menus"};
		conflicts[] = {"respawn_timer","respawn_instant",'respawn_wave'};
	};
#endif

#ifdef MISSION_PARAMS
	#include "parameters.cpp"
#endif

#ifdef MISSION_PLUGIN_FUNCTIONS
	#include "functions.cpp"
#endif

#undef PLUGIN