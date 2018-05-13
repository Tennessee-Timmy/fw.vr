private ["_groups","_CT_INS_TREE","_markersUnit"];
//#include "defines.hpp"
_display = _this select 0;
_CT_STATIC = _display displayctrl 420;
_CT_NAME = _display displayctrl 421;
_CT_BUTTON = _display displayctrl 430;
_CT_BUTTON2 = _display displayctrl 431;
_CT_WAIT = _display displayctrl 440;
_CT_INS_TREE = _display displayctrl 450;
_CT_INS_MAP = _display displayctrl 470;
_CT_INS_MAP ctrlShow false;


_force = missionNamespace getVariable ['BRM_insurgency_respawn_force',false];
_CT_WAIT ctrlShow false;
if (_force) then {
	if !([player,true] call BRM_insurgency_respawn_fnc_evaluateRespawnTime) then {
		_CT_BUTTON ctrlEnable false;
		_CT_BUTTON2 ctrlEnable false;
		_CT_WAIT ctrlShow true;
	} else {
		_CT_WAIT ctrlShow false;
	};
};


BRM_insurgency_respawn_keyDownID = _display displayAddEventHandler ["KeyDown", "_this call BRM_insurgency_respawn_fnc_keyDown;"];
//insurgency_respawn_spawnList
insurgency_respawn_spawnList = [];
_bases = _CT_INS_TREE tvAdd [[],"BASES"];
_CT_INS_TREE tvSetValue [[_bases],-1];
_bases_main = _CT_INS_TREE tvAdd [[_bases],"MAIN BASE"];
_CT_INS_TREE tvSetValue [[_bases,_bases_main],(count insurgency_respawn_spawnList)];
insurgency_respawn_spawnList pushBack main_base;
if (!isNil 'fob') then {
	_bases_fob = _CT_INS_TREE tvAdd [[_bases],"FOB"];
	_CT_INS_TREE tvSetValue [[_bases,_bases_fob],(count insurgency_respawn_spawnList)];
	insurgency_respawn_spawnList pushBack fob_base;
};
_teammates = _CT_INS_TREE tvAdd [[],"TEAMMATES"];
_CT_INS_TREE tvSetValue [[_teammates],-1];
_debugval1 = _CT_INS_TREE tvValue [_teammates];
_groups = [];
{
	if (side _x == side player && (count units _x) > 0 && !((count units _x isEqualTo 1) && (player in units _x))) then {
		_groups pushBackUnique _x;
	};
	true
}count allGroups;
_markersUnits = [];
{
	_addGroup = _CT_INS_TREE tvAdd [[_teammates],groupId _x];
	_CT_INS_TREE tvSetValue [[_teammates,_addGroup],-1];
	{
		if (alive _x && !(_x isEqualTo player)) then {
			_unit = _CT_INS_TREE tvAdd [[_teammates,_addGroup],name _x];
			_CT_INS_TREE tvSetValue [[_teammates,_addGroup,_unit],(count insurgency_respawn_spawnList)];
			insurgency_respawn_spawnList pushBack _x;
			_markersUnits pushBack _x;
		};
		true
	}count units _x;
	true
}count _groups;
BRM_insurgency_respawn = true;
_markersUnits spawn {
	_markersUnits = _this;
	BRM_insurgency_respawn_markersLoop = [{
		private ["_markers","_markersUnits","_timeLeft","_display","_text2"];
		_markersUnits = _this select 0;
		_markers = missionNamespace getVariable ["BRM_insurgency_respawn_markers",[]];
		{deleteMarkerLocal _x}count _markers;
		_markers = [];
		{
			_markerName = (name _x + str floor random 100);
			_marker = createMarkerLocal [_markerName,getpos _x];
			_marker setMarkerTypeLocal "mil_arrow2";
			_marker setMarkerColorLocal "ColorGreen";
			_marker setMarkerTextLocal name _x;
			_marker setMarkerSizeLocal [0.5, 0.5];
			_marker setMarkerDirLocal getDir _x;
			_markers pushBack _markerName;
			true
		}count _markersUnits;
		missionNamespace setVariable ["BRM_insurgency_respawn_markers",_markers];
		if !(BRM_insurgency_respawn) then {
			[BRM_insurgency_respawn_markersLoop] call CBA_fnc_removePerFrameHandler;
			_markers = missionNamespace getVariable ["BRM_insurgency_respawn_markers",[]];
			{deleteMarkerLocal _x}count _markers;
			missionNamespace setVariable ["BRM_insurgency_respawn_markers",[]];
		};
		if (!isNil "BRM_insurgency_respawn_selectedUnit") then {
			_unit = BRM_insurgency_respawn_selectedUnit;
			_map = findDisplay 42069 displayCtrl 470;
			_map ctrlMapAnimAdd [0, 0.01, getpos _unit];
			ctrlMapAnimCommit _map;
			"BRM_insurgency_respawnMarkSelected" setMarkerPosLocal getpos _unit;
			"BRM_insurgency_respawnMarkSelected" setMarkerDirLocal getDir _unit;
		};
		_display = findDisplay 42069;
		if ([player,true] call BRM_insurgency_respawn_fnc_evaluateRespawnTime) then {
			_display displayCtrl 430 ctrlEnable true;
			_display displayCtrl 431 ctrlEnable true;
			_display displayCtrl 440 ctrlShow false;
		} else {
			_timeLeftArray = [player,false] call BRM_insurgency_respawn_fnc_evaluateRespawnTime;
			_timeLeftArray params ["_timeLeft","_extraTime"];
			_text2 = "";
			if (_timeLeft > 1) then {_timeLeft = ceil _timeLeft;} else {_timeLeft = 1;};
			if (_extraTime > 0) then {_text2 = format [". %1 Seconds Were Added Due To Civilian Kills Or Team Kills.",_extraTime];};
			_display displayCtrl 440 ctrlSetText format ["Please Wait %1 Seconds Until You Can Respawn%2",_timeLeft,_text2];
		};
	}, 0, _markersUnits] call CBA_fnc_addPerFrameHandler;
};
brm_insurgency_respawn_camera = "camera" camCreate [0,0,0];
_cam = brm_insurgency_respawn_camera;
_cam cameraEffect ["internal", "back"];
_target = missionNamespace getVariable ["BRM_insurgency_respawn_selectedUnit",(insurgency_respawn_spawnList select 0)];
_cam attachTo [(vehicle _target),[0,-5.5,0],"neck"];
_cam camCommit 0;
_target call BRM_insurgency_respawn_fnc_selectUnit;
