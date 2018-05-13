// Loads all the functions for the plugin from the files
class PLUGIN {
	class init {
		file = QPLUGIN_PATHFILES;
		class setParams {postInit = 1;};
		class preInit {preInit = 1;};
	};
	class fnc {
		file = QPLUGIN_PATHFILE(fnc);
		class end {};
		class onKilled {};
		class srvEnd {};
		class unitInit {};
		class update {};
	};
};
