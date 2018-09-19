/* ----------------------------------------------------------------------------
Function: zoom_fnc_init

Description:
	initializes the loop for the zoom

Parameters:
	none
Returns:
	nothing
Examples:
	call zoom_fnc_init

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

// cache namespace
private _cache = missionNamespace getVariable ['mission_zoom_cache',locationNull];
if (isNull _cache) then {
	_cache = call CBA_fnc_createNamespace;
	missionNamespace setVariable ['mission_zoom_cache',_cache];
};

// create effects
private _cc = call zoom_fnc_cc_create;
private _db = call zoom_fnc_db_create;

private _zoom_draw3d_handle = missionNamespace getVariable ['mission_zoom_draw3d_handle',nil];
if (isNil '_zoom_draw3d_handle') then {
	_zoom_draw3d_handle = addMissionEventHandler ["Draw3D", {call zoom_fnc_eachFrame;}];
};
missionNamespace setVariable ['mission_zoom_draw3d_handle',_zoom_draw3d_handle];