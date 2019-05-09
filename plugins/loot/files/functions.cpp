// Loads all the functions for the plugin from the files
class PLUGIN {
	class init {
		file = QPLUGIN_PATHFILES;
		class setParams {postInit = 1;};
		class postInit {postInit = 1;};
	};
	class cluster {
		file = QPLUGIN_PATHFILE(cluster);
		class clusterActivate {};
		class clusterDeActivate {};
		class clusterSpawn {};
		class clustersUpdate {};
		class playerInCluster {};
	};
	class fnc {
		file = QPLUGIN_PATHFILE(fnc);
		class addZeusModules {};
		class create {};
		class findLoot {};
		class onClusterActivate {};
		class onClusterDeActivate {};
		class onLootSpawn {};
		class save {};
	};
	class srv {
		file = QPLUGIN_PATHFILE(srv);
		class srvLoop {};
		class srvLoopAdd {};
	};
	class menus {
		file = QPLUGIN_PATHFILE(menus);
		class menu {};
	};
};
