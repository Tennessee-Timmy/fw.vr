#include "script_component.cpp"
#ifdef MISSION_PLUGIN_META
	class PLUGIN {
		name = "Insurgent Plugin";
		version = 1.00;
		authors[] = {"nigel"};
		description = "Insurgency stuff";
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