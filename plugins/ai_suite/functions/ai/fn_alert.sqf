params ["_group","_patrol","_cached","_fight","_wave","_cachedActive","_cUnits","_customLimit","_speak","_side","_buildingPatrol",["_alert",[false,0]],["_static",false]];
_array = _this;
_leader = leader _group;
_patrol params ["_loc","_dist","_patrolVar","_out"];
_patrolVar params ["_building","_stance","_speed"];
_patrolVar params ["_building","_stance","_speed",["_oldStance",_stance],["_oldSpeed",_speed]];
_alert params ["_alerted","_time"];
if (_alerted) then {
	_passed = time - _time;
	if (_passed > 600) then {
		_group setBehaviour _oldStance;
		_group setSpeedMode _oldSpeed;
		_array set [11,[false,0]];
	};
};
/*
if (_static) then {
	[_group,_patrol] call aiMaster_fnc_aiUseStatic;
};
*/
//_group allowFleeing 0;
_enemySpotted = _leader findNearestEnemy _leader;
if (isNull _enemySpotted || !alive _leader) exitWith { };
//if (lineIntersects [eyepos _leader, eyePos _enemySpotted] || terrainIntersect [eyePos _leader, eyepos _enemySpotted]) exitWith { };
_knowlege = _group knowsAbout driver _enemySpotted;
if (_knowlege < 0.25) exitWith { };
_array set [11,[true,time]];
{
	if ((getNumber (configFile >> "CfgMagazines" >> (currentMagazine _x)>> 'count')) >= 50) then {
		private _suppressingEnd = _x getVariable ["aiMaster_suppressingEndTime",0];
		private _passedSuppressing = time - _suppressingEnd;
		private _suppressingPause = (ceil random 6) * 10;
		if (_passedSuppressing > _suppressingPause && random 100 > 75) then {
			private _suppressTime = (3 + ceil random 10);
			_x suppressFor _suppressTime;
			_x setVariable ["aiMaster_suppressingEndTime",(time + _suppressTime)];
		};
	};
}count units _group;

_infGroups = [];
_infGroups append aiMaster_activeGroups;
_infGroups append aiMaster_fightingGroups;
_vehGroups = [];
_vehGroups append aiMaster_activeGroupsVeh;
_vehGroups append aiMaster_fightingGroupsVeh;
{
	_xArray = _x;
	_xArray params ["_xGroup","_xPatrol","_xCached","_xFight"];
	private _near = (leader _xGroup) inArea [_leader,1500,1500,0,false];
	if ((alive leader _xGroup) && _near && (side _leader isEqualTo side leader _xGroup)) then {
		_xLeader = leader _xGroup;
		_xCombat = _xFight select 1;
		_xPatrol params ["_xLoc","_xDist","_xPatrolVar","_xOut",["_xLocObj",objNull]];
		_xPatrolVar params ["_xBuilding","_xStance","_xSpeed"];
		_xPatrolVar params ["_xBuilding","_xStance","_xSpeed",["_xOldStance",_xStance],["_xOldSpeed",_xSpeed]];
		private _xBeh = _xStance;
		private _near = (leader _xGroup) inArea [_leader,1200,1200,0,false];
		if (_near && (side _xLeader isEqualTo side _leader)) then {
			_xBeh = "AWARE";
			_xSpeed = "NORMAL";
			private _near = (leader _xGroup) inArea [_leader,400,400,0,false];
			if (_near && !_xCombat) then {
				_xBeh = "COMBAT";
				//_xSpeed = "FULL";
			};
			_xGroup setBehaviour _xBeh;
			_xGroup setSpeedMode _xSpeed;
			_xGroup reveal [_enemyspotted,_knowlege];
			_xArray set [11,[true,time]];
			_xArray set [1,[_xLoc,_xDist,[_xBuilding,_xBeh,_xSpeed,_xOldStance,_xOldSpeed],_xOut]];
		} else {
			_xBeh = "AWARE";
			_xSpeed = "NORMAL";
			_xGroup setBehaviour _xBeh;
			_xGroup setSpeedMode _xSpeed;
			_xArray set [11,[true,time]];
			_xArray set [1,[_xLoc,_xDist,[_xBuilding,_xBeh,_xSpeed,_xOldStance,_xOldSpeed],_xOut]];
		};
	};
} count _infGroups;
{
	_xArray = _x;
	_xArray params ["_xGroup","_xPatrol","_xCached","_xFight"];
	private _near = (leader _xGroup) inArea [_leader,2000,2000,0,false];
	if ( (alive leader _xGroup) && _near && (side _leader isEqualTo side leader _xGroup)) then {
		_xLeader = leader _xGroup;
		_xArray params ["_xGroup","_xPatrol","_xCached","_xFight"];
		_xCombat = _xFight select 1;
		_xPatrol params ["_xLoc","_xDist","_xPatrolVar","_xOut",["_xLocObj",objNull]];
		_xPatrolVar params ["_xBuilding","_xStance","_xSpeed"];
		_xPatrolVar params ["_xBuilding","_xStance","_xSpeed","_xTrans",["_xOldStance",_xStance],["_xOldSpeed",_xSpeed]];
		private _xBeh = _xStance;
		private _near = (leader _xGroup) inArea [_leader,1500,1500,0,false];
		if (_near && (side _xLeader isEqualTo side _leader)) then {
			_xBeh = "AWARE";
			private _near = (leader _xGroup) inArea [_leader,400,400,0,false];
			if (_near && !_xCombat) then {
				_xBeh = "COMBAT";
			};
			_xLeader setBehaviour _xBeh;
			_xGroup reveal [_enemyspotted,_knowlege];
			_xArray set [11,[true,time]];
			_xArray set [1,[_xLoc,_xDist,[_xBuilding,_xBeh,_xSpeed,_xTrans,_xOldStance],_xOut]];
		} else {
			_xBeh = "AWARE";
			_xLeader setBehaviour _xBeh;
			_xArray set [11,[true,time]];
			_xArray set [1,[_xLoc,_xDist,[_xBuilding,_xBeh,_xSpeed,_xTrans,_xOldStance],_xOut]];
		};
	};
} count _vehGroups;
true