#include "script_component.cpp"
#ifdef MISSION_PLUGIN_META
	class PLUGIN {
		name = "Respawn type: round";
		version = 1.00;
		authors[] = {"nigel"};
		description = "The round respawn type. Includes some extra functionality like mid-round etc.";
		required[] = {"respawn","seed","menus"};
		conflicts[] = {"respawn_timer","respawn_instant","respawn_wave","casualty_cap","round"};
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