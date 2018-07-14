#include "script_component.cpp"
#ifdef MISSION_PLUGIN_META
	class PLUGIN {
		name = "Arma 3 Spectator";
		version = 1.00;
		authors[] = {"nigel"};
		description = "Enables the arma 3 spectator";
		required[] = {"respawn"};
		conflicts[] = {};
	};
#endif

#ifdef MISSION_PLUGIN_FUNCTIONS
	#include "functions.cpp"
#endif

#undef PLUGIN