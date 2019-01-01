#include "script_component.cpp"
#ifdef MISSION_PLUGIN_META
	class PLUGIN {
		name = "Health plugin";
		version = 1.00;
		authors[] = {"nigel"};
		description = "Enables player health.";
	};
#endif

#ifdef MISSION_PLUGIN_FUNCTIONS
	#include "functions.cpp"
#endif

#ifdef MISSION_PLUGIN_RSCTITLES
	#include "dialogs\rscTitles.hpp"
#endif

#undef PLUGIN