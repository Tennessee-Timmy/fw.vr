#include "script_component.cpp"
#ifdef MISSION_PLUGIN_META
	class PLUGIN {
		name = "Briefing system";
		version = 1.00;
		authors[] = {"nigel"};
		description = "Adds briefing stuff";
		required[] = {"menus"};
		conflicts[] = {};
	};
#endif

#ifdef MISSION_PLUGIN_FUNCTIONS
	#include "functions.cpp"
#endif

#ifdef MISSION_PLUGIN_DIALOGS
	#include "dialogs\dialogs.hpp"
#endif

#undef PLUGIN