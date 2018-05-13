#include "script_component.cpp"
#ifdef MISSION_PLUGIN_META
	class PLUGIN {
		name = "cleaner";
		version = 1.00;
		authors[] = {"nigel"};
		description = "This is some crazy shit that'll save FPS.";
		required[] = {};
		conflicts[] = {};
	};
#endif

#ifdef MISSION_PLUGIN_FUNCTIONS
	#include "functions.cpp"
#endif

#undef PLUGIN