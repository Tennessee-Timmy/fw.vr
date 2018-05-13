class PLUGIN {
	class init {
		file = QPLUGIN_PATHFILES;
		class postInit {postInit = 1;};
	};
	class fnc {
		file = QPLUGIN_PATHFILE(fnc);
		class onRespawn {};
		class onRespawnUnit {};
	};
	class menus {
		file = QPLUGIN_PATHFILE(menus);
		class menu {};
	};
};