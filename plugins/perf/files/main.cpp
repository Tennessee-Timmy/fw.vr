#include "script_component.cpp"
#ifdef MISSION_PLUGIN_META
	class PLUGIN {
		name = "perf";
		version = 1.00;
		authors[] = {"nigel"};
		description = "Clientside performance script";
		required[] = {};
		conflicts[] = {};
	};
#endif

#ifdef MISSION_PLUGIN_FUNCTIONS
	#include "functions.cpp"
#endif
#undef PLUGIN