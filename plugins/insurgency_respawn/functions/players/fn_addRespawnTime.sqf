/*
 * Adds extra respawn time to a player
 *
 * Arguments:
 * 0: unit <object>
 * 1: time added due to deaths (permanent) <number>
 * 2: extra time added due to teamkills or civilian kill <number>
 *
 * Return value: None
 * [player,5] call BRM_insurgency_respawn_fnc_addRespawnTime;
 */
private ['_respawningList','_list'];
params ['_unit','_addNormal',['_addExtra',0]];
_respawningList = player call BRM_insurgency_respawn_fnc_findRespawnTime;
_list = brm_insurgency_respawn_players - [_respawningList];
_respawningList params ['_playerID','_normalTime','_extraTime','_totalTime'];
_normalTime = _normalTime + _addNormal;
_extraTime = _extraTime + _addExtra;
_totalTime = _normalTime + _extraTime;
_respawningList = [_playerID,_normalTime,_extraTime,_totalTime];
_list = _list + [_respawningList];
missionNamespace setVariable ['brm_insurgency_respawn_players',_list,true];