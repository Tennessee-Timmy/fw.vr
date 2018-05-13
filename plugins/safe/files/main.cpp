#include "script_component.cpp"
#ifdef MISSION_PLUGIN_META
	class PLUGIN {
		name = "Safe zone";
		version = 1.00;
		authors[] = {"nigel"};
		description = "Enables safe zones for starting a game safe";
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

#ifdef MISSION_PLUGIN_RSCTITLES
	#include "dialogs\rscTitles.hpp"
#endif

#undef PLUGIN