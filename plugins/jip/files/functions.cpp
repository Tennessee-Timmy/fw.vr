class PLUGIN {
	class init {
		file = QPLUGIN_PATHFILES;
		class postInit {postInit = 1;};
	};
	class fnc {
		file = QPLUGIN_PATHFILE(fnc);
		class teleport {};
	};
	class menus {
		file = QPLUGIN_PATHFILE(menus);
		class menu {};
	};
};