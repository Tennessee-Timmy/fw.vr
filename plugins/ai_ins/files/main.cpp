// Loads all the plugin information for this plugin
#include "script_component.cpp"
#ifdef MISSION_PLUGIN_META
	class PLUGIN {
		name = "AI Insurgency Plugin";
		version = 1.00;
		authors[] = {"nigel"};
		description = "Spawns ai inside buildings for insurgency";
		required[] = {"headless"};
		conflicts[] = {};
	};
#endif

#ifdef MISSION_PARAMS
	#include "parameters.cpp"
#endif

#ifdef MISSION_PLUGIN_FUNCTIONS
	#include "functions.cpp"
#endif

#ifdef MISSION_PLUGIN_XEH_DISPLAY_LOAD
class RscDisplayCurator {
    ai_ins_curatorOpen = "_this call ai_ins_fnc_onCuratorOpen";
};
#endif

#ifdef MISSION_PLUGIN_XEH_DISPLAY_UNLOAD
class RscDisplayCurator {
    ai_ins_curatorOpen = "_this call ai_ins_fnc_onCuratorClosed";
};
#endif
#undef PLUGIN