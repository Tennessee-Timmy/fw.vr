
#ifdef BRM_PLUGIN_META
	class insurgency_respawn
	{
		name = "Insurgency Respawn Plugin";
		version = 1.00;
		authors[] = {"nigel"};
		description = "Spawn on team-mates.";
	};
#endif

#ifdef BRM_PLUGIN_FUNCTIONS
	#include "Functions.cpp"
#endif

#ifdef BRM_PLUGIN_DIALOGS
	#include "functions\defines.hpp"
	#include "dialogs.hpp"
#endif