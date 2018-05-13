class PLUGIN {
	class init {
		file = QPLUGIN_PATHFILES;
		class postInit {postInit = 1;};
	};
	class fnc {
		file = QPLUGIN_PATHFILE(fnc);
		class clientInit {};
		class clientLoop {};
		class clientLooper {};
		class clientUpUC {};
		class clusterLoop {};
		class clusterLooper {};
		class createClusters {};
		class updateClusters {};
		class srvInit {};
		class srvLoop {};
		class srvLooper {};
		class srvUpC {};
		class srvVar {};
	};
};