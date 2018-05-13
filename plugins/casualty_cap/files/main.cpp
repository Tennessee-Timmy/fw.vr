#include "script_component.cpp"
#ifdef MISSION_PLUGIN_META
	class PLUGIN {
		name = "Casualty Cap";
		version = 1.00;
		authors[] = {"nigel"};
		description = "Ends the mission based on dead players";
		required[] = {"seed","menus","tasks"};
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