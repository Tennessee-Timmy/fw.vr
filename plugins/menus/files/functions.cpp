class PLUGIN {
	class init {
		file = QPLUGIN_PATHFILES;
		class postInit {postInit = 1;};
		//class setParams {postInit = 1;};
	};
	class fnc {
		file = QPLUGIN_PATHFILE(fnc);
		class ctrlHider {};
		class displayCloser {};
		class enableMenuButtons {};
		class enableUnconsciousMenu {};
		class isAdmin {};
		class menuList_default {};
		class menuList_default2 {};
		class menuList_select {};
		class menusClose {};
		class menusOpen {};
		class openMainMenu {};
		class registerItem {};
		class registerItemUnit {};
		class removeItem {};
		class removeItemUnit {};
		class switchMenusAdmin {};
		class switchMenusMission {};
		class updateList {};
	};
	class menus {
		file = QPLUGIN_PATHFILE(menus);
		class addBackground {};
		class addButton {};
		class addDisplay {};
		class addGroup {};
		class addTextBox {};
		class addTitle {};
		class droplist {};
		class listEHButtonClick {};
		class listEHLBSelChanged {};
		class listEHmouseMoving {};
	};
};