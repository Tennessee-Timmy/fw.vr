#include "script_component.cpp"
#ifdef MISSION_PLUGIN_META
	class PLUGIN {
		name = "Suppression plugin";
		version = 1.00;
		authors[] = {"nigel"};
		description = "Enables player suppression. Thanks to LAxemann and Joko";
	};
#endif

#ifdef MISSION_PLUGIN_FUNCTIONS
	#include "functions.cpp"
#endif

#ifdef MISSION_PLUGIN_XEHFIREDBIS
	class AllVehicles {
		class L_Suppress_Suppress_sys {
			clientFiredBIS="_this call supp_fnc_fired";
		};
	};
#endif

#undef PLUGIN