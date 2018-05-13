missionNamespace SetVariable ["BRM_insurgency_respawn_selectedMarker",nil];
player cameraEffect ["terminate","back"];
camdestroy brm_insurgency_respawn_camera;
deleteMarker "BRM_insurgency_respawnMarkSelected";
BRM_insurgency_respawn = false;

_force = missionNamespace getVariable ['BRM_insurgency_respawn_force',false];
if (_force) then {
	if !([player,true] call BRM_insurgency_respawn_fnc_evaluateRespawnTime) then {
		[] spawn {
			//uiSleep 1;
			createdialog "RscInsurgencyRespawn";
		};
	} else {
		[player,5] call BRM_insurgency_respawn_fnc_addRespawnTime;
		missionNamespace setVariable ['BRM_insurgency_respawn_force',false];
		brm_insurgency_respawn_tickets = brm_insurgency_respawn_tickets - 1;
		publicVariable 'brm_insurgency_respawn_tickets';
		hintSilent format ['There are %1 respawn tickets remaining',brm_insurgency_respawn_tickets];
	};
};