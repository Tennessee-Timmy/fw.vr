/* ----------------------------------------------------------------------------
Function: zoom_fnc_db_create

Description:
	Creates the dynamic blur handle and returns it

Parameters:
	none
Returns:
	nothing
Examples:
	call zoom_fnc_db_create

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

private _zoom_db_handle = missionNamespace getVariable ['mission_zoom_db_handle',800];
if (ppEffectEnabled _zoom_db_handle) exitWith {_zoom_db_handle};
call {

	private _priority = 800;
	for '_i' from 0 to 1 step 0 do {
		if (ppEffectEnabled _zoom_db_handle) exitWith {};
		_zoom_db_handle = ppEffectCreate ['DynamicBlur',_priority];
		_priority = _priority + 1;
		_zoom_db_handle ppEffectEnable true;
	};
	missionNamespace setVariable ['mission_zoom_db_handle',_zoom_db_handle];
};
_zoom_db_handle