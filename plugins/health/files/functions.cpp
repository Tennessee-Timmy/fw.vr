class PLUGIN {
	class init {
		file = QPLUGIN_PATHFILES;
		class postInit {postInit = 1;};
		class preInit {preInit = 1;};
	};
	class fnc {
		file = QPLUGIN_PATHFILE(fnc);
		class fired {};
		class impact {};
		class main {};
		class mainHandler {};
		class pinnedDown {};
		class readCacheValues {};
		class suppressDummy {};
	};
};