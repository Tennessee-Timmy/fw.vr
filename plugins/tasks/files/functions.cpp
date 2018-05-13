// Loads all the functions for the plugin from the files
class PLUGIN {
	class init {
		file = QPLUGIN_PATHFILES;
		class setParams {postInit = 1;};
		class postInit {postInit = 1;};
	};
	class fnc {
		file = QPLUGIN_PATHFILE(fnc);
		class add {};
		class addZeusModules {};
		class end {};
		class endSrv {};
		class list {};
		class loop {};
		class remove {};
		class setWinners {};
		class srvLoop {};
		class update {};
	};
	class menus {
		file = QPLUGIN_PATHFILE(menus);
		class menu {};
		class getEndings {};
	};
};
