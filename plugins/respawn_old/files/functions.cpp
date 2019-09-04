class PLUGIN {
	class init {
		file = QPLUGIN_PATHFILES;
		class setParams {postInit = 1;};
		class postInit {postInit = 1;};
	};
	class dialogs {
		file = QPLUGIN_PATHFILE(dialogs);
		class deadHudClose {};
		class deadHudScriptAdd {};
		class deadHudShow {};
		class deadText {};
		class deadTextHandler {};
	};
	class events {
		file = QPLUGIN_PATHFILE(events);
		class onKilled {};
		class onRespawn {};
		class onRespawnUnit {};
		class runOnKilledScripts {};
		class runOnRespawnScripts {};
		class runOnRespawnUnitScripts {};
		class scriptAdd {};
		class scriptAddUnit {};
		class scriptRemove {};
		class scriptRemoveUnit {};
	};
	class fnc {
		file = QPLUGIN_PATHFILE(fnc);
		class areDead {};
		class deadCheck {};
		class deadToggle {};
		class findGroup {};
		class getDeadArray {};
		class getSetUnitSide {};
		class notify {};
		class readableTime {};
		class respawn {};
		class respawnUnit {};
		class srvDeadAdd {};
		class srvDeadList {};
		class srvDeadRemove {};
		class srvRespawn {};
	};
	class loc_default {
		file = QPLUGIN_PATHFILE(locations\default);
		class default_Respawn {};
		class default_setup {};
	};
	class loc_base {
		file = QPLUGIN_PATHFILE(locations\base);
		class base_Respawn {};
		class base_setup {};
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