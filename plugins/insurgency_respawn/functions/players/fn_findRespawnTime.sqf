/*
 * Find or create the respawn time in the respawn time array and return it
 *
 * Arguments:
 * 0: unit <object>
 *
 * Return value:
 * 0: unit id <number>
 * 1: normal respawn time <number>
 * 2: extra respawn time <number>
 * 3: total respawn time <number>
 */
private ['_arraySelect','_totalTime','_respawningList','_normalTime','_extraTime'];
_respawningList = missionNamespace getVariable ['brm_insurgency_respawn_players',[]];
_playerID = getPlayerUID _this;
{
	if (_playerID in _x) then {
		_arraySelect = _forEachIndex;
	};
}forEach _respawningList;
if (isNil '_arraySelect') then {
	_respawningList pushBackUnique [_playerID,30,0];
	missionNamespace setVariable ['brm_insurgency_respawn_players',_respawningList,true];
	_normalTime = 30;
	_extraTime = 0;
	_totalTime = 30;
} else {
	_normalTime = ((_respawningList select _arraySelect) select 1);
	_extraTime = ((_respawningList select _arraySelect) select 2);
	_totalTime = _normalTime + _extraTime;
};
[_playerID,_normalTime,_extraTime,_totalTime]