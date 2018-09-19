#include "script_component.cpp"
#ifdef MISSION_PLUGIN_META
	class PLUGIN {
		name = "Zoom plugin";
		version = 1.00;
		authors[] = {"nigel"};
		description = "Makes zooming very much less desirable (RMB zoom)";
	};
#endif

#ifdef MISSION_PLUGIN_FUNCTIONS
	#include "functions.cpp"
#endif


#undef PLUGIN