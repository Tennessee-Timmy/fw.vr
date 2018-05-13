#include "script_component.cpp"
#ifdef MISSION_PLUGIN_META
	class PLUGIN {
		name = "Task Force Radio";
		version = 1.00;
		authors[] = {"nigel"};
		description = "Task force radio functionality.";
		required[] = {"respawn"};
		conflicts[] = {"acre"};
	};
#endif

#ifdef MISSION_PLUGIN_FUNCTIONS
	#include "functions.cpp"
#endif

#undef PLUGIN