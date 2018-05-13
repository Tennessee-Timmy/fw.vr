// Loads all the plugin information for this plugin
#include "script_component.cpp"
#ifdef MISSION_PLUGIN_META
	class PLUGIN {
		name = "Tasks Plugin";
		version = 1.00;
		authors[] = {"nigel"};
		description = "Adds basic task functionality. Ends mission if tasks complete etc..";
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

#ifdef MISSION_PLUGIN_DEBRIEFING
	#include "..\custom_debriefings.sqf"
#endif

#undef PLUGIN