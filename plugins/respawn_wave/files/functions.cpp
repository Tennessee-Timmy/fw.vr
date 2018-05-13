class PLUGIN {
	class init {
		file = QPLUGIN_PATHFILES;
		class setParams {postInit = 1;};
		class postInit {postInit = 1;};
	};
	class fnc {
		file = QPLUGIN_PATHFILE(fnc);
		class addTime {};
		class addWaves {};
		class onRespawn {};
		class onRespawnUnit {};
		class playerTimer {};
		class serverTimer {};
		class setup {};
		class updateSideTime {};
	};
};