class PLUGIN {
	class init {
		file = QPLUGIN_PATHFILES;
		class preInit {preInit = 1;};
		class postInit {postInit = 1;};
	};
	class cargo {
		file = QPLUGIN_PATHFILE(cargo);
		class cargo {};
		class cargoFind {};
		class cargoGear {};
	};
	class fnc {
		file = QPLUGIN_PATHFILE(fnc);
		class addMagazines {};
		class addWeapon {};
		class addWeaponKit {};
		class auto {};
		class onRespawnUnit {};
		class removeGear {};
	};
	class menus {
		file = QPLUGIN_PATHFILE(menus);
		class menu {};
		class roleList {};
	};
	class unit {
		file = QPLUGIN_PATHFILE(unit);
		class roleFind {};
		class unit {};
		class unitGear {};
	};
	class zeus {
		file = QPLUGIN_PATHFILE(zeus);
		class addZeusModules {};
	};
};