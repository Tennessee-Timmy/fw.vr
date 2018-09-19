class PLUGIN {
	class init {
		file = QPLUGIN_PATHFILES;
		class postInit {postInit = 1;};
	};
	class fnc {
		file = QPLUGIN_PATHFILE(fnc);
		class cc_create {};
		class db_create {};
		class eachFrame {};
		class init {};
		class maxZoom {};
		class readCache {};
	};
};