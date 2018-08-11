#include "script_component.cpp"
#ifdef MISSION_PLUGIN_META
	class PLUGIN {
		name = "Guns plugin";
		version = 1.00;
		authors[] = {"nigel"};
		description = "Changes the gun dispersion and jam rates";
	};
#endif

#ifdef MISSION_PLUGIN_FUNCTIONS
	#include "functions.cpp"
#endif

#undef PLUGIN