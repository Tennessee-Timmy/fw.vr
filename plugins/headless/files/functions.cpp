// Loads all the functions for the plugin from the files
class PLUGIN {
	class init {
		file = QPLUGIN_PATHFILES;
		class setParams {postInit = 1;};
		class postInit {postInit = 1;};
	};
	class fnc {
		file = QPLUGIN_PATHFILE(fnc);
		class changeOwner {};
		class moveAll {};
		class moveAllMission {};
	};
	class zeus {
		file = QPLUGIN_PATHFILE(zeus);
		class addZeusModules {};
	};
	class menus {
		file = QPLUGIN_PATHFILE(menus);
		class menu {};
	};
};
