/* ----------------------------------------------------------------------------
Function: vd_fnc_auto

Description:
	Sets viewdistance based on fov

Params:
0:	_enable			- true to enable false to disable the auto view distance

Returns:
	nothing
Examples:
	true call vd_fnc_auto

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

if (!hasInterface) exitWith {};
params [['_enable',true]];

private _handle = missionNamespace getVariable ['mission_vd_handle',nil];
if !(isNil '_handle') then {
	[_handle] call CBA_fnc_removePerFrameHandler;

	private _lastDist = missionNamespace getVariable ['mission_vd_lastDist',viewDistance];
	setViewDistance _lastDist;
	private _lastDistO = missionNamespace getVariable ['mission_vd_lastDistO',(getObjectViewDistance#0)];
		setObjectViewDistance [_lastDistO,(getObjectViewDistance#1)];
};

if (!_enable) exitWith {};

mission_vd_handle = [{
	private _fov = (([] call CBA_fnc_getFov)#1);
	call {
		private _lastFov = missionNamespace getVariable ['mission_vd_lastFov',0];
		private _ratio = missionNamespace getVariable ['mission_vd_fovRatio',0.5];
		private _min = missionNamespace getVariable ['mission_vd_fovMin',500];
		private _max = missionNamespace getVariable ['mission_vd_fovMax',3000];
		if (_fov isEqualTo _lastFov) exitWith {};
		private _dist = linearConversion [0.7,12,_fov,_min,_max];
		setObjectViewDistance [_dist,(getObjectViewDistance # 1)];
		setViewDistance (_dist * _ratio);
		missionNamespace setVariable ['mission_vd_lastFov',_fov];
	};
}, 0] call CBA_fnc_addPerFrameHandler;