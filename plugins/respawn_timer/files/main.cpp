#include "script_component.cpp"
#ifdef MISSION_PLUGIN_META
	class PLUGIN {
		name = "Respawn type: timer";
		version = 1.00;
		authors[] = {"nigel"};
		description = "The timer respawn type for respawns";
		required[] = {"respawn","seed","menus"};
		conflicts[] = {"respawn_wave","respawn_instant"};
	};
#endif

#ifdef MISSION_PARAMS
	#include "parameters.cpp"
#endif

#ifdef MISSION_PLUGIN_FUNCTIONS
	#include "functions.cpp"
#endif

#undef PLUGIN