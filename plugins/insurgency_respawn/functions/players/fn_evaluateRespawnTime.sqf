/*
================================================================================
Check if player has waited his respawn time out

Arguments:
	0: unit <object>
	1: true to only return evaluation, false to return time remaining<bool>

Return value:
if return bool is true:
	0: enough time has been waited <bool>

if return bool is false:
	0: normal respawn time remaining <number>
	1: extra respawn time remaining <number>

USAGE:
	_waitedEnoguh = [player,true] call BRM_insurgency_respawn_fnc_evaluateRespawnTime;
================================================================================
*/params [["_player",player],["_returnBool",true]];
_playerTime = _player getVariable ['insurgency_respawn_playerTime',[30,0,time]];
_playerTime params ["_spawnTime","_extraTime","_spawnStarted"];
_passed = (time - _spawnStarted);
_result = (_passed >= _spawnTime);
_timeLeft = _spawnTime - (time - _spawnStarted);
if (_returnBool) then {_result} else {[_timeLeft,_extraTime]}