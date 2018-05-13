// Loads all the functions for the plugin from the files
class PLUGIN {
	class init {
		file = QPLUGIN_PATHFILES;
		class setParams {postInit = 1;};
		class postInit {postInit = 1;};
		class spawnUnits {};
	};
	class fnc {
		file = QPLUGIN_PATHFILE(fnc);
		class arrayShuffle{};
		class arrayShufflePlus{};
		class findBuildings{};
		class createMarkers{};
		class updateMarkers{};
		class taskMarker{};
		class mark_base{};
		class callMark{};
		class campTask{};
		class vehTask{};
		class removeToMark{};
		class newMarkerArea{};
		class newMarkerIcon{};
	};
};
