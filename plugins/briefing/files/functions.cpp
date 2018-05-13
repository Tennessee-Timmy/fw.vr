class PLUGIN {
	class init {
		file = QPLUGIN_PATHFILES;
		class postInit {postInit = 1;};
	};
	class dialogs {
		file = QPLUGIN_PATHFILE(dialogs);
		class keyDown {};
		class keyLoop {};
		class roster {};
		class rosterOn {};
		class rosterUpdate {};
	};
	class fnc {
		file = QPLUGIN_PATHFILE(fnc);
	};
};