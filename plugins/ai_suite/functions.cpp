class aiMaster
{
	class fnc {
		file = "plugins\ai_suite\functions\fnc";
		class landPos{};
		class roadPos{};
		class buildingPos{};
		class unFlip{};
		class getGear{};
		class setGear{};
		class getSkill{};
		class setSkill{};
		class clearGroup{};
		class onKilled{};
		class cacheInf{};
		class unCacheInf{};
		class cacheVeh{};
		class unCacheVeh{};
		class depend{};
		class inHouse{};
		class loadTransIn{};
		class createTransArray{};
		class cacheTrans{};
		class unCacheTrans{};
		class paraDrop{};
	};
	class ai_fnc {
		file = "plugins\ai_suite\functions\ai";
		class aiCache{};
		class aiCacheVeh{};
		class aiFight{};
		class aiFightVeh{};
		class aiSpawnInf{};
		class aiSpawnVeh{};
		class alert{};
		class alertVeh{};
		class buildingPatrols{};
		class patrols{};
		class patrolsVeh{};
		class aiSearchHouse{};
		class aiUseStatic{};
		class aiSpawnTrans{};
		class patrolsTrans{};
	};
	class init {
		file = "plugins\ai_suite\functions";
		//class zeus {postInit = 1;};
		class preInit {postInit = 1;};
		class spawnUnits {};
	};
};