/* ----------------------------------------------------------------------------
Function: seed_fnc_generateSeedServer

Description:
	generates seed on the server
	It runs in preInit automatically

Parameters:
	none
Returns:
	nothing
Examples:
	call seed_fnc_generateSeedServer;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// only run on server
if !(isServer) exitWith {};


private _saveEH = addMissionEventHandler ["Ended",{saveProfileNamespace}];
[] spawn {

	// save every hour if there are no player
	while {true} do {
		sleep (60*60);
		if ((count PLAYERLIST) isEqualTo 0) then {
			saveProfileNamespace;
		};
	};
};