// Loads all the functions for the plugin from the files
class PLUGIN {
	class init {
		file = QPLUGIN_PATHFILES;
	};
	class fnc {
		file = QPLUGIN_PATHFILE(fnc);
		class getSetting {};
		class loadSettings {};
	};
};