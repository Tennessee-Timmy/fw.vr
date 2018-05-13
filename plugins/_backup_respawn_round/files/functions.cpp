class PLUGIN {
	class init {
		file = QPLUGIN_PATHFILES;
		class setParams {postInit = 1;};
		class postInit {postInit = 1;};
	};
	class srv {
		file = QPLUGIN_PATHFILE(srv);
		class endRoundSrv {};
		class prepRoundSrv {};
		class setup {};
		class loopSrv {};
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
	};
};