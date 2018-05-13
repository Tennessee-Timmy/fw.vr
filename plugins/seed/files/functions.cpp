class PLUGIN {
	class init {
		file = QPLUGIN_PATHFILES;
		class setParams {preInit = 1;};
		class generateSeedServer {preInit = 1;};
		class generateSeedClient {preInit = 1;};
		class postInit {postInit = 1;};
	};
	class fnc {
		file = QPLUGIN_PATHFILE(fnc);
		class cleanSeeds {};
		class getVars {};
		class getVarsReturn {};
		class getVarsTarget {};
		class setVars {};
		class setVarsTarget {};
	};
};