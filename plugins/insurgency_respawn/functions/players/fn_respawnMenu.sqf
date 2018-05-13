_respawningList = player call BRM_insurgency_respawn_fnc_findRespawnTime;
_respawningList params ['_playerID','_normalTime','_extraTime','_totalTime'];
player setVariable ['insurgency_respawn_playerTime',[_totalTime,_extraTime,time]];

if !([player] call BRM_insurgency_respawn_fnc_evaluateRespawnTime) then {
	missionNamespace setVariable ['BRM_insurgency_respawn_force',true];
} else {
	missionNamespace setVariable ['BRM_insurgency_respawn_force',false];
};

createdialog "RscInsurgencyRespawn";

/*

hint format ['There are %1 respawn tickets remaining.',brm_insurgency_respawn_tickets];
brm_insurgency_respawn_tickets = brm_insurgency_respawn_tickets - 1;
publicVariable 'brm_insurgency_respawn_tickets';

*/