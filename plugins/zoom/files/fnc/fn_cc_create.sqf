/* ----------------------------------------------------------------------------
Function: zoom_fnc_cc_create

Description:
	Creates the color correction handle and returns it

Parameters:
	none
Returns:
	nothing
Examples:
	call zoom_fnc_cc_create

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

private _zoom_cc_handle = missionNamespace getVariable ['mission_zoom_cc_handle',30000];
if (ppEffectEnabled _zoom_cc_handle) exitWith {_zoom_cc_handle};
call {

	private _priority = 30000;
	for '_i' from 0 to 1 step 0 do {
		if (ppEffectEnabled _zoom_cc_handle) exitWith {};
		_zoom_cc_handle = ppEffectCreate ['ColorCorrections',_priority];
		_priority = _priority + 1;
		_zoom_cc_handle ppEffectEnable true;
	};
	missionNamespace setVariable ['mission_zoom_cc_handle',_zoom_cc_handle];
};
_zoom_cc_handle