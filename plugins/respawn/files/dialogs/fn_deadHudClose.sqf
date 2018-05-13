/* ----------------------------------------------------------------------------
Function: respawn_fnc_deadHudClose

Description:
	Closes the death hud and tells you that you are alive!
	Only use this in scheduled environment, it uses suspension
Parameters:
	none
Returns:
	nothing
Examples:
	[] spawn respawn_fnc_deadHudClose;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// Todo what if player dies during this ;(
// Disable serilization to save display and control as variables
disableSerialization;

// get display for respawn dead
private _displayM = uiNamespace getVariable "respawn_rsc_deadMid";
private _displayS = uiNamespace getVariable "respawn_rsc_deadSide";
private _displayT = uiNamespace getVariable "respawn_rsc_deadTitle";

// Quit if no display found
if (isNil "_displayM") exitWith {};


// Disable sidetext, because it's used for timers
_controlText = (_displayS displayCtrl 2002);
_controlText ctrlShow false;

// Main control (alive/dead)
_control = (_displayT displayCtrl 2001);

// Set text, fade in and commit
_control ctrlSetText "You are alive";
_control ctrlSetFade 0;
_control ctrlCommit 1;

// Wait 5 seconds and hide the control
sleep 5;
_control ctrlSetFade 1;
_control ctrlCommit 3;

// Wait 3 seconds and remove the hole Rsc
// this is done because an extra message might be displayed
sleep 3;

// If player is dead don't close the hud
if (player getVariable ["unit_respawn_dead",false]) exitWith {};

// if hud exists, close it
if !(uiNamespace getVariable ["respawn_rsc_deadTitle",displayNull] isEqualTo displayNull) then {
	private _layerT = "rscLayer_respawn_deadTitle" cutFadeOut 0;
	private _layerM = "rscLayer_respawn_deadMid" cutFadeOut 0;
	private _layerS = "rscLayer_respawn_deadSide" cutFadeOut 0;
};