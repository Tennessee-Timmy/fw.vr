class PLUGIN {
	class init {
		file = QPLUGIN_PATHFILES;
		class setParams {postInit = 1;};
		class postInit {postInit = 1;};
	};
	class fnc {
		file = QPLUGIN_PATHFILE(fnc);
		class fakeEnd {};
		class loadAO {};
		class saveAO {};
	};
	class srv {
		file = QPLUGIN_PATHFILE(srv);
		class aoSrv {};
		class endRoundSrv {};
		class loopGameSrv {};
		class loopSrv {};
		class prepRoundSrv {};
		class setup {};
		class markersSrv {};
		class startRoundSrv {};
		class update {};
		class updateLoc {};
		class updateSideData {};
	};
	class client {
		file = QPLUGIN_PATHFILE(client);
		class endRound {};
		class loop {};
		class onRespawn {};
		class onRespawnUnit {};
		class prepRound {};
		class startRound {};
		class vote {};
	};
};