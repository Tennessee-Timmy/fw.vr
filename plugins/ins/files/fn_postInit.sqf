0 spawn {
	uiSleep 10;
	waitUntil {!isNil "mission_headless_setup"};
	if !(mission_headless_controller) exitWith { };
	CenterWorld =  getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition");
	ins_buildings = [CenterWorld,10000] call ins_fnc_findbuildings;
	ins_buildings = ins_buildings call ins_fnc_arrayShuffle;
	ins_gridmarkers = [];
	{_x call ins_fnc_createMarkers}count ins_buildings;
	ins_gridmarkers = ins_gridmarkers call ins_fnc_arrayShuffle;
	ins_toMark = [];
	call ins_fnc_spawnUnits;
	uiSleep 10;
	ins_updateMarkers = true;
	[] spawn {
		while {ins_updateMarkers} do {
			call ins_fnc_updateMarkers;
			sleep 5;
		};
	};
};