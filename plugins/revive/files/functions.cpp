class PLUGIN {
	class init {
		file = QPLUGIN_PATHFILES;
		class setParams {postInit = 1;};
		class postInit {postInit = 1;};
	};
	class fnc {
		file = QPLUGIN_PATHFILE(fnc);
		class addAceActions {};
		class deadLoop {};
		class location {};
		class markerLoop {};
		class onBodyBag {};
		class onRespawn {};
		class onRespawnUnit {};
		class revive {};
		class setup {};
		class srvLoop {};
	};
	class menus {
		file = QPLUGIN_PATHFILE(menus);
		class menu {};
	};
};