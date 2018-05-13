#include "script_component.cpp"
#ifdef MISSION_PLUGIN_META
	class PLUGIN {
		name = "Escape plugin";
		version = 1.00;
		authors[] = {"nigel"};
		description = "Escape from/to area/location. Ends mission or puts players in spectator";
	};
#endif

#ifdef MISSION_PLUGIN_FUNCTIONS
	#include "functions.cpp"
#endif

#undef PLUGIN