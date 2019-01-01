// Loads all the functions for the plugin from the files
class PLUGIN {
	class init {
		file = QPLUGIN_PATHFILES;
		class setParams {postInit = 1;};
		class postInit {postInit = 1;};
		class preInit {preInit = 1;};
	};
	class fnc {
		file = QPLUGIN_PATHFILE(fnc);
		class buy {};
		class buyAmmo {};
		class buyArmor {};
		class buyMenu {};
		class buySrv {};
		class buySuccess {};
		class buyWeapon {};
		class dropItems {};
		class moneyUpdate {};
		class moneyUpdateAll {};
		class onKilled {};
		class unitInit {};
	};
};
