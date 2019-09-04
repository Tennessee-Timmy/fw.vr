/* ----------------------------------------------------------------------------
Function: respawn_fnc_deadHudShow

Description:
	Shows the death hud and tells you that you are dead
Parameters:
	none
Returns:
	nothing
Examples:
	call respawn_fnc_deadHudShow;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins


// if the hud does exists, close it, so it can be restarted
if !(uiNamespace getVariable ["respawn_rsc_dead",displayNull] isEqualTo displayNull) then {
	// close the hud
	private _layerT = "rscLayer_respawn_deadTitle" cutFadeOut 0;
	private _layerM = "rscLayer_respawn_deadMid" cutFadeOut 0;
	private _layerS = "rscLayer_respawn_deadSide" cutFadeOut 0;

};
"rscLayer_respawn_deadMid" cutRsc ["respawn_rsc_deadMid", "PLAIN"];
"rscLayer_respawn_deadSide" cutRsc ["respawn_rsc_deadSide", "PLAIN"];
"rscLayer_respawn_deadTitle" cutRsc ["respawn_rsc_deadTitle", "PLAIN"];

// run the text handler
[] spawn respawn_fnc_deadTextHandler;