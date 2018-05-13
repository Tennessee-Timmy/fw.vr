#include "script_component.cpp"
#ifdef MISSION_PLUGIN_META
	class PLUGIN {
		name = "jip";
		version = 1.00;
		authors[] = {"nigel"};
		description = "Join in progress teleporter";
		required[] = {"menus"};
		conflicts[] = {};
	};
#endif

#ifdef MISSION_PLUGIN_FUNCTIONS
	#include "functions.cpp"
#endif

#undef PLUGIN