// Loads all the functions for the plugin from the files
class PLUGIN {
	class init {
		file = QPLUGIN_PATHFILES;
		class setParams {postInit = 1;};
		class postInit {postInit = 1;};
	};
	class cache {
		file = QPLUGIN_PATHFILE(cache);
		class cache {};
		class cache2 {};
		class cacheCheck {};
		class cacheLog {};
		class gCache {};
		class gCacheLog {};
		class gUnCache {};
		class unCache {};
		class unCache2 {};
	};
	class fnc {
		file = QPLUGIN_PATHFILE(fnc);
		class check {};
		class copyParams {};
		class detGarr {};
		class editFunc {};
		class editGroups {};
		class editGroupsAdv {};
		class editGroupsSimple {};
		class editQGroup {};
		class editSetting {};
		class findParam {};
		class flatPos {};
		class getGroup {};
		class getNearestGroups {};
		class getSetParam {};
		class loop {};
		class padPos {};
		class setParam {};
		class spawn {};
	};
	class patrol {
		file = QPLUGIN_PATHFILE(patrol);
		class garrison {};
		class gPatrol {};
		class house {};
		class housePos {};
		class moveToHouse {};
		class patrol {};
		class patrolC {};
	};
	class zeus {
		file = QPLUGIN_PATHFILE(zeus);
		class addZeusModules {};
		class onCuratorClosed {};
		class onCuratorOpen {};
	};
};
