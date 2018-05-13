/*aiSpawnInf
	[
		[*spawn logic*,*patrol logic*],						//either a logic or an array of 2 logics
		*spawn distance*,									//number
		*patrol distance*,									//number
		[*side*,*unitArray*],								//west,east,independent,civilian
		[*patrol buildings*,								//bool to enable building patrols and behaviour in qouates
		*stance*,											//https://community.bistudio.com/wiki/setWaypointBehaviour
		*speed*],											//https://community.bistudio.com/wiki/setWaypointSpeed
		*outer spawn*,										//spawn units outside, w/ building patrols units will search buildings around patrol logic
		[*min*,*max*],										//amount of groups to spawn
		[*offencive*,*autoCombat*],							//bool,disable autocombat
		*skill*,											//0 to 1 check aiMaster_skill for more
		[*startCached*,										//bool,
		*limit*,											//active group limit
		*disabled*,											//caching disabled
		*leadfunc*,											//Only leader will remain at double normal distance
		*[close,far]*],										//distances, uncache and cache
		*wave_var*											//wave
	] call fw_fnc_aiSpawnInf;
[base,300,300,[west,2],[true,"SAFE","LIMITED"],false,[5,10],true,0.5,[true,10]] call fw_fnc_aiSpawnInf;
[[opfor1,base],300,300,[east,2],[false,"AWARE","FULL"],false,[5,10],true,0.5,[false,10,true],wave_4] call fw_fnc_aiSpawnInf;
*/
params ["_pos","_dist","_distP","_units","_patrol","_out","_gAmount","_offensive","_skill","_cached","_wave","_customLimit",["_static",false]];
private _pos1 = nil;
private _pos2 = nil;
private _pos3 = objNull;
if (typeName _pos == "ARRAY") then {
	if (count _pos isEqualTo 2) then {
		_pos1 = _pos select 0;
		_pos2 = _pos select 1;
		if (typename _pos1 isequalto "OBJECT") then {
			_pos3 = _pos1;
			_pos1 = position _pos1;
		};
		if (typename _pos2 isequalto "OBJECT") then {
			_pos3 = _pos2;
			_pos2 = position _pos2;
		};
		_pos = [_pos1,_pos2,_pos3];
	} else {
		_pos1 = _pos;
		_pos = [_pos1,_pos1];
	};
} else {
	if (_pos isEqualType objNull) then {
		_pos3 = _pos;
	};
	_pos1 = position _pos;
	_pos = [_pos1,_pos1,_pos3];
};

#include "includes\units.sqf"
if (isNil "_groups")then {_groups = [];};
for "_i" from 1 to ((_gAmount select 0) + round(random((_gAmount select 1) - (_gAmount select 0)))) step 1 do {
	_unitArray = call compile format ["_%1_%2",_units select 0,_units select 1];
	_gName = createGroup (_units select 0);
	_unitPos = [(_pos select 0),_dist,[nil, _dist] select _out] call aiMaster_fnc_landPos;
	{
		aimaster_spawned_inf = aimaster_spawned_inf + 1;
		_unit = _gName createUnit [ _x, _unitPos, [], 20, "NONE" ];
		_unit addEventHandler ["Killed", aiMaster_fnc_onKilled];
		_unit setSkill _skill;
		_unit setskill ["aimingAccuracy",0.35];
		_unit setskill ["aimingShake",0.3];
		_unit setskill ["aimingSpeed",0.5];
		_unit setskill ["spotTime",0.8];
		_unit setskill ["spotDistance",1];
		_unit setskill ["Courage",0.5];
		_unit allowFleeing 0;
		if (_offensive select 1) then {
			_unit enableAttack false;
			_unit disableAI "AUTOCOMBAT";
		};
		//_voice = selectRandom ["Male01PER","Male02PER","Male03PER"];
		//_unit setSpeaker _voice;
		true
	} count _unitArray;
	if (!isNil "_customLimit")then {
		missionNamespace setvariable [_customLimit,(call compile _customLimit+1)];
	};
	_gName setBehaviour (_patrol select 1);
	_gVars = [
		_gName,														//Group				0
		[_pos select 1,_distP,_patrol,_out,_pos select 2],			//Patrol			1
		_cached,													//Cache				2
		[_offensive select 0,_offensive select 1, nil, nil],		//Fight				3
		if (isNil "_wave") then {nil} else {_wave},					//Wave				4
		[false,false],												//CacheActive		5
		[],															//cUnits			6
		if (isNil "_customLimit") then {nil} else {_customLimit},	//CustomLimit		7
		nil,														//Speak				8
		side _gName,												//Side				9
		[nil,nil,nil],												//buildingPatrol	10
		nil,														//Alert				11
		_static														//Static			12
	];
	aiMaster_groups pushBack _gVars;
	missionNamespace setVariable ["aiMaster_groups",aiMaster_groups];
	_startCached = _cached select 0;
	if (_startCached) then {_gVars spawn aiMaster_fnc_aiCache;} else {aiMaster_activeGroups pushBack _gVars;};
};
true