0 spawn {
	uiSleep 10;
	while {isNil "mission_AI_controller_name"} do {uiSleep 1;};
	if !(mission_ai_controller) exitWith { };
	CenterWorld =  getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition");
	BRM_insurgency_buildings = [CenterWorld,10000] call BRM_insurgency_fnc_findbuildings;
	BRM_insurgency_buildings = BRM_insurgency_buildings call BRM_insurgency_fnc_arrayShuffle;
	BRM_insurgency_gridmarkers = [];
	{_x call BRM_insurgency_fnc_createMarkers}count BRM_insurgency_buildings;
	BRM_insurgency_gridmarkers = BRM_insurgency_gridmarkers call BRM_insurgency_fnc_arrayShuffle;
	BRM_insurgency_toMark = [];
	call BRM_insurgency_fnc_spawnUnits;
	uiSleep 10;
	BRM_insugrency_updateMarkers = true;
	BRM_insugrency_cache_tasks = 0;
	BRM_insugrency_veh_tasks = 0;
	BRM_insurgency_cacheAsked = false;
	publicVariable 'BRM_insurgency_cacheAsked';
	BRM_insurgency_tankAsked = false;
	publicVariable 'BRM_insurgency_tankAsked';
	BRM_insurgency_btrAsked = false;
	publicVariable 'BRM_insurgency_btrAsked';
	BRM_insurgency_nvgAsked = false;
	publicVariable 'BRM_insurgency_nvgAsked';
	BRM_insurgency_bmpAsked = false;
	publicVariable 'BRM_insurgency_bmpAsked';
	[] spawn {
		while {BRM_insugrency_updateMarkers} do {
			if (isNil "cache") then {
				if (BRM_insurgency_cacheAsked) then {
					cache = [CenterWorld,5000,true,["ins_cache"],"cache"]call BRM_insurgency_fnc_campTask;
					cache_pos = getPos cache;
					publicVariable 'cache';
					publicVariable 'cache_pos';
					BRM_insurgency_toMark pushBackUnique ["cache",cache,100,50,5,3,0.6];
					["cache",cache,100,50,5,3] call BRM_insurgency_fnc_mark_base;
					uiSleep 5;
					publicVariable 'BRM_insugrency_cache_tasks';
					[side_a_side, (format ["BLU1_cache_%1",BRM_insugrency_cache_tasks]),
					["FIND THE CACHE",
					"The enemy have an weapons cache somewhere in chernarus, capture or destroy it. Find the location by killing enemies and picking up intel.",
					"destroy",[]],
					["(true)","(!alive cache || cache distance cache_pos > 5)"],
					0, ["", "{if (mission_ai_controller)then{
						_nam = 'cache';
						missionNameSpace setVariable [_nam,nil];
						publicVariable _nam;
						_name = format['BRM_insurgency_camp_%1',_nam];
						_campArray = missionNamespace getVariable [_name,[]];
						{
							_x setVariable ['aiMaster_cleanUp',true,true];
						}count _campArray;
						_name2 = format['BRM_insurgency_markers_%1',_nam];
						_markers = missionNamespace getVariable [_name2,[]];
						{deleteMarker _x}count _markers;
						missionNameSpace setVariable [_name2,[]];[_nam] call BRM_insurgency_fnc_removeToMark;
					}}remoteExec ['bis_fnc_call',0];BRM_insurgency_cacheTasked = false; publicVariable 'BRM_insurgency_cacheTasked';", ""]] remoteExec ["BRM_FMK_fnc_newTask",2];
					BRM_insugrency_cache_tasks = BRM_insugrency_cache_tasks + 1;
					publicVariable 'BRM_insugrency_cache_tasks';
					BRM_insurgency_cacheAsked = false;
					BRM_insurgency_cacheTasked = true;
					publicVariable 'BRM_insurgency_cacheTasked';
					publicVariable 'BRM_insurgency_cacheAsked';
					if (dayTime > 19 || dayTime < 6) then {
						100 remoteExec ["setTimeMultiplier", 2];
					} else {
						1 remoteExec ["setTimeMultiplier", 2];
					};
				};
			};
			call BRM_insurgency_fnc_updateMarkers;
			sleep 5;
		};
	};
};