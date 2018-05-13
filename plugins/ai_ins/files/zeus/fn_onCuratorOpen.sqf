/* ----------------------------------------------------------------------------
Function: ai_ins_fnc_onCuratorOpen

Description:
	Runs when display opened

Parameters:
0:  _display         - display that got opened (curator display)
Returns:
	nothing
Examples:
	_this call ai_ins_fnc_onCuratorOpen;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins
missionNamespace setVariable ["ai_ins_curatorLoopOpen",true];
["ai_ins_curatorLoop", "onEachFrame", {

	// delete old shit
	private _markers = missionNamespace getVariable ['ai_ins_curatorMarkers',[]];

	{
		_x params ['_marker','_pos','_arr'];
		deleteMarkerLocal _marker;
	} forEach _markers;


	if ((findDisplay 312)isEqualTo displayNull) exitWith {
		call ai_ins_fnc_onCuratorClosed;
	};
	_curator = curatorCamera;

	private _dist = (getObjectViewDistance select 0);
	private _oldPos = missionNamespace getVariable ['ai_ins_curatorPos',[0,0,0]];
	private _oldTime = missionNamespace getVariable ['ai_ins_curatorTime',0];
	if (!(_oldPos inArea [_curator, (_dist/3),(_dist/3),0,false]) || (time - _oldTime > 3)) then {
		private _groups = [_curator,999,[west,east,resistance,civilian],(_dist),2,2] call ai_ins_fnc_getNearestGroups;
		missionNamespace setVariable ['ai_ins_curatorNear',_groups];
		missionNamespace setVariable ['ai_ins_curatorPos',(getposATL _curator)];
		missionNamespace setVariable ['ai_ins_curatorTime',time];
	};


	_groups = missionNamespace getVariable ['ai_ins_curatorNear',[]];
	_markers = [];

	private _i = 0;
	{
		call {
			/*
			private _arr = _x;
			_arr params ['_pos',['_side',east],['_amount',1],['_extra',[]]];
			private _extra = _arr param [3,[]];
			private _cached = [_extra,"cached",false] call ai_ins_fnc_findParam;
			_i = _i + 1;
			if (_cached) exitWith {
				private _cachedPos = [_extra,"cachedPos",[_pos]] call ai_ins_fnc_findParam;
				_cachedPos = (_cachedPos param [0,_pos]);
				if (_cachedPos isEqualTo [] || {_cachedPos isEqualTo [0,0,0]}) exitWith {};
				private _marker = createMarkerLocal [(format ["curator_marker_%1",_i]),_cachedPos];
				_marker setMarkerShapeLocal "ICON";
				_marker setMarkerTypeLocal "mil_objective";
				_marker setMarkerColorLocal "ColorPink";
				_marker setMarkerTextLocal "Cached";
				_marker setMarkerSizeLocal [0.7,0.7];
				_marker setMarkerAlphaLocal 0.85;
				_markers pushBack [_marker,_cachedPos,_arr,true];
				drawIcon3D ["A3\Modules_F_MP_Mark\Objectives\images\CarrierIcon.paa",  	[1,0.3,0.4,0.7] , _cachedPos, 2.0, 2.0, 0, "Cached", 1];
			};
			_units = units([_extra,"group",grpNull] call ai_ins_fnc_findParam);
			if (_units isEqualTo []) exitWith {};
			private _target = _units param [0];
			if (isNil "_target" || {isNull _target}) exitWith {};
			private _pos = getPos _target;
			if (_pos isEqualTo [] || {_pos isEqualTo [0,0,0]}) exitWith {};
			private _marker = createMarkerLocal [(format ["curator_marker_%1",_i]),(_pos)];
			_marker setMarkerShapeLocal "ICON";
			_marker setMarkerTypeLocal "mil_objective";
			_marker setMarkerColorLocal "ColorBlue";
			_marker setMarkerTextLocal "Active";
			_marker setMarkerSizeLocal [0.7,0.7];
			_marker setMarkerAlphaLocal 0.85;
			_markers pushBack [_marker,_pos,_arr,false];
			drawIcon3D ["A3\Modules_F_MP_Mark\Objectives\images\CarrierIcon.paa", [0.0,0.0,1,0.7], (_pos), 2.0, 2.0, 0, "Active", 1];
			*/
			private _pad = _x;

			// get pad pos
			private _pos = getpos _pad;

			private _cached = [_pad,"cached",false] call ai_ins_fnc_findParam;
			_i = _i + 1;
			if (_cached) exitWith {
				private _cachedPos = [_pad,"cachedPos",[_pos]] call ai_ins_fnc_findParam;
				_cachedPos = (_cachedPos param [0,_pos]);
				if (_cachedPos isEqualTo [] || {_cachedPos isEqualTo [0,0,0]}) exitWith {};
				private _marker = createMarkerLocal [(format ["curator_marker_%1",_i]),_cachedPos];
				_marker setMarkerShapeLocal "ICON";
				_marker setMarkerTypeLocal "mil_objective";
				_marker setMarkerColorLocal "ColorPink";
				_marker setMarkerTextLocal "Cached";
				_marker setMarkerSizeLocal [0.7,0.7];
				_marker setMarkerAlphaLocal 0.85;
				_markers pushBack [_marker,_cachedPos,_arr,true];
				drawIcon3D ["A3\Modules_F_MP_Mark\Objectives\images\CarrierIcon.paa",  	[1,0.3,0.4,0.7] , _cachedPos, 2.0, 2.0, 0, "Cached", 1];
			};
			_units = units([_pad,"group",grpNull] call ai_ins_fnc_findParam);
			if (_units isEqualTo []) exitWith {};
			private _target = _units param [0];
			if (isNil "_target" || {isNull _target}) exitWith {};
			private _pos = getPos _target;
			if (_pos isEqualTo [] || {_pos isEqualTo [0,0,0]}) exitWith {};
			private _marker = createMarkerLocal [(format ["curator_marker_%1",_i]),(_pos)];
			_marker setMarkerShapeLocal "ICON";
			_marker setMarkerTypeLocal "mil_objective";
			_marker setMarkerColorLocal "ColorBlue";
			_marker setMarkerTextLocal "Active";
			_marker setMarkerSizeLocal [0.7,0.7];
			_marker setMarkerAlphaLocal 0.85;
			_markers pushBack [_marker,_pos,_arr,false];
			drawIcon3D ["A3\Modules_F_MP_Mark\Objectives\images\CarrierIcon.paa", [0.0,0.0,1,0.7], (_pos), 2.0, 2.0, 0, "Active", 1];
		};

	} forEach _groups;
	missionNamespace setVariable ['ai_ins_curatorMarkers',_markers];

}] call BIS_fnc_addStackedEventHandler;