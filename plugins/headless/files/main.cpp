// Loads all the plugin information for this plugin
#include "script_component.cpp"
#ifdef MISSION_PLUGIN_META
	class PLUGIN {
		name = "Headless Plugin";
		version = 1.00;
		authors[] = {"nigel"};
		description = "Headless functionaility. Helps transfer units to hc or server from zeus. Increases performance";
		required[] = {};
		conflicts[] = {};
	};
#endif

#ifdef MISSION_PARAMS
	#include "parameters.cpp"
#endif

#ifdef MISSION_PLUGIN_FUNCTIONS
	#include "functions.cpp"
#endif

#undef PLUGIN