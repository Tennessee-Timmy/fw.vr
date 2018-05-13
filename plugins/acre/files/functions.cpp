class PLUGIN {
	class init {
		file = QPLUGIN_PATHFILES;
		class setParams {preInit = 1;};
		class postInit {postInit = 1;};
		//class preInit {preInit = 1;};
	};
	class fnc {
		file = QPLUGIN_PATHFILE(fnc);
		class addRadios {};
		class clearRadios {};
		class onRespawn {};
		class onRespawnUnit {};
		class setupRadios {};
	};
	class menus {
		file = QPLUGIN_PATHFILE(menus);
		class menu {};
	};
	class zeus {
		file = QPLUGIN_PATHFILE(zeus);
		class addZeusModules {};
	};
};