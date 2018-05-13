#include "script_component.cpp"
#ifdef MISSION_PLUGIN_META
	class PLUGIN {
		name = "Menus Plugin";
		version = 1.00;
		authors[] = {"nigel"};
		description = "A couple of basic menu templates";
		required[] = {"seed"};
		conflicts[] = {};
	};
#endif
/*
#ifdef MISSION_PARAMS
	#include "Parameters.cpp"
#endif
*/
#ifdef MISSION_PLUGIN_FUNCTIONS
	#include "functions.cpp"
#endif
#ifdef MISSION_PLUGIN_DIALOGS
	#include "dialogs\defines.hpp"
	#include "dialogs\controls.hpp"
	#include "dialogs\dialogs.hpp"
#endif

#undef PLUGIN