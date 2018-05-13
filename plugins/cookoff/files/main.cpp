#include "script_component.cpp"
#ifdef MISSION_PLUGIN_META
	class PLUGIN {
		name = "Custom cookoff";
		version = 1.00;
		authors[] = {"nigel","cory"};
		description = "A much better version of cookoff than ace3";
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

#ifdef MISSION_PLUGIN_XEHINIT
	class All {
		class cookOff_init_eh {
			//serverInit = "_this select 0 addMPEventHandler ['MPKilled', { (_this select 0) call cookOff_fnc_cookoffVehicle; }]";
			exclude[] = {"Man", "StaticWeapon"};
		};
	};
#endif

#undef PLUGIN