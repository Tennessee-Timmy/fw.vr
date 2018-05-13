/* ----------------------------------------------------------------------------
Function: tasks_fnc_getEndings

Description:
	Retrives all possible endings for mission (for menu plugin)
Parameters:
	none
Returns:
	nothing
Examples:
	call tasks_fnc_getEndings;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
#define CFG_END(var) (configFile >> "CfgDebriefing" >> 'var')
// Code begins
private _missionCfg = "true" configClasses (missionconfigfile >> "CfgDebriefing");
_missionCfg append [CFG_END(endDeath),CFG_END(PlayerLost),CFG_END(PlayerWon)];
//_missionCfg append ["bin\config.bin/CfgDebriefing/endDeath","bin\config.bin/CfgDebriefing/loser",bin\config.bin/CfgDebriefing/PlayerLost,bin\config.bin/CfgDebriefing/PlayerWon];
private _endings = [];
{
	private _name = (getText(_x >> "title"));
	if (_name isEqualTo "") then {
		_name = (getText(_x >> "subtitle"));
	};
	if (_name isEqualTo "") then {
		_name = (getText(_x >> "description"));
	};
	_endings pushBack [
		_name,
		[configName(_x),_name],
		(getText(_x >> "description"))
	];

	false
} count _missionCfg;
_endings