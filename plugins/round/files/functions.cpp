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
		class checkGameWin {};
		class checkRoundWin {};
		class endRoundSrv {};
		class loopGameSrv {};
		class loopSrv {};
		class markersSrv {};
		class prepRoundSrv {};
		class setup {};
		class startRoundSrv {};
		class update {};
		class updateLoc {};
		class updateSideData {};
	};
	class client {
		file = QPLUGIN_PATHFILE(client);
		class endRound {};
		class findPlayerSide {};
		class loop {};
		class onRespawn {};
		class onRespawnUnit {};
		class prepRound {};
		class startRound {};
		class sideSwitch {};
		class vote {};
	};
};