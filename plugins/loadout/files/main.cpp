#include "script_component.cpp"
#ifdef MISSION_PLUGIN_META
	class PLUGIN {
		name = "Loadout system";
		version = 1.00;
		authors[] = {"nigel"};
		description = "Adds loadouts to units";
		required[] = {};
		conflicts[] = {};
	};
#endif

#ifdef MISSION_PLUGIN_FUNCTIONS
	#include "functions.cpp"
#endif

#undef PLUGIN