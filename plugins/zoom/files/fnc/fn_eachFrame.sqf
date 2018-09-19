/* ----------------------------------------------------------------------------
Function: zoom_fnc_eachFrame

Description:
	to run each frame does most of thigns for zoom evaluation

Parameters:
	none
Returns:
	nothing
Examples:
	call zoom_fnc_eachFrame

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

private _nextCheck = missionNamespace getVariable ['mission_zoom_nextCheck',CBA_Missiontime];
if (CBA_Missiontime < _nextCheck) exitWith {};
private _disabledFor = 0.1;

private _cc = missionNamespace getVariable ['mission_zoom_cc_handle',30000];
private _db = missionNamespace getVariable ['mission_zoom_db_handle',800];

private _zoom = (call CBA_fnc_getFov) select 1;
call {
	// exit if zoom is less than 1.2 (no need to evaluate)
	if (_zoom <= 1.2) exitWith {};

	// zoom 0 if camera not on player or player in vehicle
	if ( (cameraOn != player) || !(isNull objectParent player)) exitWith {
		_zoom = 0;
		_disabledFor = 1;
    };


	// make sure camera is near my face
	if !((positionCameraToWorld [0,0,0]) inArea [(player modelToWorldVisual [0,0,1.6]),0.5,0.5,0,false,0.5]) exitWith {
		_zoom = 0;
		_disabledFor = 1.5;
	};


    // exit if not in a scope
	if (cameraView != 'GUNNER') exitWith {};

	// zoom 0 if using binocs
	if (currentWeapon player isEqualTo binocular player) exitWith {
		_zoom = 0;
		_disabledFor = 1.5;
	};

	private _maxZoom = call zoom_fnc_maxZoom;

	// zoom 0 if max zoom for optics is < 0.2
	if (_maxZoom < 0.2) exitWith {
		_zoom = 0;
		_disabledFor = 1;
	};
};


private _v = velocityModelSpace player;
private _speed = ((abs(_v select 0)) + (abs (_v select 1)));
private _maxBlur = linearConversion [0,6,_speed,0.2,2,true];


private _coef = linearConversion [1.2,3,_zoom,1.5,0,true];
private _blur = linearConversion [1.2,3,_zoom,0,_maxBlur,true];
private _ccArr = [
	0.0, 0.0, 0.0,
	[
		0, 0, 0, 1
	], [
		1, 1, 1, 0
	], [
		1, 1, 1, 0
	],[
		0.9,0.6,0,0,0,_coef,1.0
	]
];
_cc ppEffectAdjust _ccArr;
_cc ppEffectCommit 0.1;

_db ppEffectAdjust [_blur];
_db ppEffectCommit 0.1;


missionNamespace setVariable ['mission_zoom_nextCheck',CBA_Missiontime + _disabledFor];