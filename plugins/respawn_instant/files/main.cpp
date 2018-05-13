#include "script_component.cpp"
#ifdef MISSION_PLUGIN_META
	class PLUGIN {
		name = "Respawn type: instant";
		version = 1.00;
		authors[] = {"nigel"};
		description = "The instant respawn type for respawns";
		required[] = {"respawn","seed","menus"};
		conflicts[] = {"respawn_timer","respawn_wave"};
	};
#endif

#ifdef MISSION_PLUGIN_FUNCTIONS
	#include "functions.cpp"
#endif

#undef PLUGIN