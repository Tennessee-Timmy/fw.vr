#include "script_component.cpp"
#ifdef MISSION_PLUGIN_META
	class PLUGIN {
		name = "ACRE radio plugin";
		version = 1.00;
		authors[] = {"nigel"};
		description = "ACRE radio functionality.";
		required[] = {"respawn"};
		conflicts[] = {"tfr"};
	};
#endif

#ifdef MISSION_PARAMS
	#include "parameters.cpp"
#endif

#ifdef MISSION_PLUGIN_FUNCTIONS
	#include "functions.cpp"
#endif

#undef PLUGIN