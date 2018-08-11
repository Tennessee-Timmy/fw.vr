#include "script_component.cpp"
#ifdef MISSION_PLUGIN_META
	class PLUGIN {
		name = "Diwako's Ragdoll";
		version = 1.00;
		authors[] = {"diwako"};
		description = "Makes you ragdoll";
		required[] = {"ace3"};
		conflicts[] = {};
	};
#endif

#ifdef MISSION_PLUGIN_FUNCTIONS
	#include "functions.cpp"
#endif

#undef PLUGIN