/*
 * Remove time from the player respawn time
 *
 * Arguments:
 * 0: unit <object>
 * 1: time removed from normal time<number>
 * 2: extra time removed. If true, all extra time removed. <number/bool>
 *
 * Return value: None
 */private ['_respawningList','_list'];
params ['_unit','_removeNormal','_removeExtra'];
_respawningList = player call BRM_insurgency_respawn_fnc_findRespawnTime;
_list = brm_insurgency_respawn_players - [_respawningList];
_respawningList params ['_playerID','_normalTime','_extraTime','_totalTime'];
_normalTime = _normalTime - _removeNormal;
if (typeName _removeExtra isEqualTo "BOOL") then {
	_removeExtra = _extraTime;
};
_extraTime = _extraTime - _removeExtra;
_totalTime = _normalTime + _extraTime;
_respawningList = [_playerID,(_normalTime max 30),(_extraTime max 0),(_totalTime max 30)];
_list = _list + [_respawningList];
missionNamespace setVariable ['brm_insurgency_respawn_players',_list,true];