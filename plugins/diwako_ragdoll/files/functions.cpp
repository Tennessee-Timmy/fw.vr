class PLUGIN {
	class init {
		file = QPLUGIN_PATHFILES;
		class preInit {preInit = 1;};
	};
	class fnc {
		file = QPLUGIN_PATHFILE(fnc);
		class animChangedEH {};
		class initRagdoll {};
	};/*
	class menus {
		file = QPLUGIN_PATHFILE(menus);
		class menu {};
	};*/
};