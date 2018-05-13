#include "script_component.cpp"
#ifdef MISSION_PLUGIN_META
	class PLUGIN {
		name = "AO marker";
		version = 1.00;
		authors[] = {"nigel"};
		description = "Covers the map and only leaves the AO in";
	};
#endif

#ifdef MISSION_PLUGIN_FUNCTIONS
	#include "functions.cpp"
#endif

#undef PLUGIN