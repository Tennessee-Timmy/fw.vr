#include "script_component.cpp"
#ifdef MISSION_PLUGIN_META
	class PLUGIN {
		name = "ACE 3 Spectator";
		version = 1.00;
		authors[] = {"nigel"};
		description = "Enables the ace 3 spectator to work with the respawn system";
		required[] = {"respawn"};
		conflicts[] = {};
	};
#endif

#ifdef MISSION_PLUGIN_FUNCTIONS
	#include "functions.cpp"
#endif

#undef PLUGIN