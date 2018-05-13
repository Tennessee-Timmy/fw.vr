// Loads all the plugin information for this plugin
#include "script_component.cpp"
#ifdef MISSION_PLUGIN_META
	class PLUGIN {
		name = "Easy settings framework";
		version = 1.00;
		authors[] = {"nigel"};
		description = "Allows for setting up parameters and settings to be setup easily";
		required[] = {};
		conflicts[] = {};
	};
#endif

#ifdef MISSION_PLUGIN_FUNCTIONS
	#include "functions.cpp"
#endif

#undef PLUGIN