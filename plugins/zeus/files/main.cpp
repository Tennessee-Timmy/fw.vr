// Loads all the plugin information for this plugin
#include "script_component.cpp"
#ifdef MISSION_PLUGIN_META
	class PLUGIN {
		name = "Zeus Plugin";
		version = 1.00;
		authors[] = {"nigel"};
		description = "Adds zeus functions, that can be used in other plugins and extends zeus functionality.";
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