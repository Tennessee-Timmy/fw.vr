class PLUGIN {
	class init {
		file = QPLUGIN_PATHFILES;
		class setParams {postInit = 1;};
		class postInit {postInit = 1;};
	};
	class fnc {
		file = QPLUGIN_PATHFILE(fnc);
		class addTime {};
		class addZone {};
		class clientLoop {};
		class disable {};
		class enable {};
		class onRespawnUnit {};
		class setTime {};
		class srvLoop {};
	};
	class menus {
		file = QPLUGIN_PATHFILE(menus);
		class menu {};
	};
};