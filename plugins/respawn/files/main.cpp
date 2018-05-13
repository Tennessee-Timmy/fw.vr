#include "script_component.cpp"
#ifdef MISSION_PLUGIN_META
	class PLUGIN {
		name = "Respawn systems";
		version = 1.00;
		authors[] = {"nigel"};
		description = "A couple of respawn systems which can be customized a lot";
		required[] = {"seed","menus"};
		conflicts[] = {};
	};
#endif

#ifdef MISSION_PARAMS
	#include "parameters.cpp"
#endif

#ifdef MISSION_PLUGIN_FUNCTIONS
	#include "functions.cpp"
#endif

#ifdef MISSION_PLUGIN_RSCTITLES
	#include "dialogs\rscTitles.hpp"
#endif

#ifdef MISSION_PLUGIN_NOTIFICATIONS
	#include "notifications.cpp"
#endif

#undef PLUGIN