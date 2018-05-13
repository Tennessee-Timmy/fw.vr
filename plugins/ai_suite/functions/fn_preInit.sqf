asr_ai3_main_enabled = 0;
0 spawn {
	uiSleep 3;
	waitUntil {!isNil "mission_headless_setup"};
	if !(mission_headless_controller) exitWith { };
	aiMaster_groups = [ ];
	aiMaster_cachedGroups = [ ];
	aiMaster_activeGroups = [ ];
	aiMaster_fightingGroups = [ ];
	aiMaster_groupsVeh = [ ];
	aiMaster_cachedGroupsVeh = [ ];
	aiMaster_activeGroupsVeh = [ ];
	aiMaster_fightingGroupsVeh = [ ];


	aimaster_spawned_inf = 0;
	aimaster_spawned_veh = 0;

	call aiMaster_fnc_spawnUnits;
	uiSleep 10;
	last_time = 0;
	aiMaster_debug = 0;


	aiMasterLoopNew = true;
	//aiMasterLoop = [{
	aiMasterLoop = true;
	while {aiMasterLoop} do {
	//waitUntil{
		if (aiMasterLoopNew) then {
			aiMasterPlayers = ((allUnits + allDeadMen) select {isPlayer _x && {!(_x isKindOf "HeadlessClient_F")}});
			//aiMasterPlayers = ((allUnits + allDeadMen) select {(side _x) isEqualTo west});
			systemChat str (time-last_time);
			if (time - last_time < 1) then {uisleep 1} else {if (time - last_time < 3) then {uisleep 0.1};};
			last_time = time;
			aiMasterLoopNew = false;
			aiMasterLoopCounter = 0;
			aiMaster_patrolHouses = [ ];
			aiMaster_patrolWP = [ ];
			{[_x,"aiMaster_groups"] call aiMaster_fnc_clearGroup}count aiMaster_groups;
			{[_x,"aiMaster_cachedGroups"] call aiMaster_fnc_clearGroup}count aiMaster_cachedGroups;
			{[_x,"aiMaster_activeGroups"] call aiMaster_fnc_clearGroup}count aiMaster_activeGroups;
			{[_x,"aiMaster_fightingGroups"] call aiMaster_fnc_clearGroup}count aiMaster_fightingGroups;
			aiMasterLoopGroups = [];
			aiMasterLoopGroups append aiMaster_groups;
			aiMasterLoopCachedGroups = aiMaster_cachedGroups;
			aiMasterLoopactiveGroups = aiMaster_activeGroups;
			aiMasterLoopfightingGroups = aiMaster_fightingGroups;
			{[_x,"aiMaster_groupsVeh"] call aiMaster_fnc_clearGroup}count aiMaster_groupsVeh;
			{[_x,"aiMaster_cachedGroupsVeh"] call aiMaster_fnc_clearGroup}count aiMaster_cachedGroupsVeh;
			{[_x,"aiMaster_activeGroupsVeh"] call aiMaster_fnc_clearGroup}count aiMaster_activeGroupsVeh;
			{[_x,"aiMaster_fightingGroupsVeh"] call aiMaster_fnc_clearGroup}count aiMaster_fightingGroupsVeh;
			aiMasterLoopgroupsVeh = [];
			aiMasterLoopgroupsVeh append aiMaster_groupsVeh;
			aiMasterLoopcachedGroupsVeh = aiMaster_cachedGroupsVeh;
			aiMasterLoopactiveGroupsVeh = aiMaster_activeGroupsVeh;
			aiMasterLoopfightingGroupsVeh = aiMaster_fightingGroupsVeh;
		};
		_loopcount = (count aiMasterLoopGroups)+(count aiMasterLoopgroupsVeh);
		private _loopgroup = nil;
		if (count aiMasterLoopGroups > 0) then {
			_loopgroup = aiMasterLoopGroups select 0;
			[aiMasterLoopGroups,_loopgroup] call aiMaster_fnc_depend;

		} else {
			if (count aiMasterLoopgroupsVeh > 0) then {
				_loopgroup = aiMasterLoopgroupsVeh select 0;
				[aiMasterLoopgroupsVeh,_loopgroup] call aiMaster_fnc_depend;
			};
		};
		if (isNil "_loopgroup") then {aiMasterLoopNew = true;} else {
			if (_loopGroup in aiMaster_groups && !(_loopgroup in aiMaster_activeGroups || _loopgroup in aiMaster_fightingGroups || _loopgroup in aiMaster_cachedGroups)) then {
				aiMaster_activeGroups pushBack _loopgroup;
			};
			if (_loopGroup in aiMaster_groupsVeh && !(_loopgroup in aiMaster_activeGroupsVeh || _loopgroup in aiMaster_fightingGroupsVeh || _loopgroup in aiMaster_cachedGroupsVeh)) then {
				aiMaster_activeGroupsVeh pushBack _loopgroup;
			};
			if (_loopgroup in aiMaster_activeGroups || _loopgroup in aiMaster_cachedGroups) then {_loopgroup call aiMaster_fnc_aiCache};
			if (_loopgroup in aiMaster_activeGroups) then {_loopgroup call aiMaster_fnc_patrols};
			if (_loopgroup in aiMaster_fightingGroups) then {_loopgroup call aiMaster_fnc_alert;_loopgroup call aiMaster_fnc_aiFight};
			if (_loopgroup in aiMaster_activeGroups) then {_loopgroup call aiMaster_fnc_alert;_loopgroup call aiMaster_fnc_aiFight};
			if (_loopgroup in aiMaster_groupsVeh || _loopgroup in aiMaster_cachedGroupsVeh) then {_loopgroup call aiMaster_fnc_aiCacheVeh};
			if (_loopgroup in aiMaster_activeGroupsVeh) then {_loopgroup call aiMaster_fnc_patrolsVeh;_loopgroup call aiMaster_fnc_unFlip;};
			if (_loopgroup in aiMaster_fightingGroupsVeh) then {_loopgroup call aiMaster_fnc_alertVeh;_loopgroup call aiMaster_fnc_aiFightVeh;_loopgroup call aiMaster_fnc_unFlip;};
			if (_loopgroup in aiMaster_activeGroupsVeh) then {_loopgroup call aiMaster_fnc_alertVeh;_loopgroup call aiMaster_fnc_aiFightVeh;};
		};
		//(!aiMasterLoop)
	};
	//},0] call CBA_fnc_addPerFrameHandler;
};