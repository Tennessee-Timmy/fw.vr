class PLUGIN {
	class init {
		file = QPLUGIN_PATHFILES;
		class setParams {preInit = 1;};
		class preInit {preInit = 1;};
		class postInit {postInit = 1;};
	};
	class fnc {
		file = QPLUGIN_PATHFILE(fnc);
		class onRespawn {};
	};
	class menus {
		file = QPLUGIN_PATHFILE(menus);
		class menu {};
	};
};