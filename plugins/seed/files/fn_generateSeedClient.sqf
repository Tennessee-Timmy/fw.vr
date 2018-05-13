/* ----------------------------------------------------------------------------
Function: seed_fnc_generateSeedClient

Description:
	Makes sure player has recieved seed from server and loads it from profilenameSpace
	It runs in preInit automatically

Parameters:
	none
Returns:
	nothing
Examples:
	call seed_fnc_generateSeedClient;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// Run the following in scheduled due to waitUntil
[] spawn {
	// Clean older seeds
	call seed_fnc_cleanSeeds;

	// set _seed as private so it can be defined in waitUntil
	private _seed = nil;

	// Run the loop
	waitUntil {
		// Grab seed from missionNamespace (nil default)
		_seed = missionNamespace getVariable ["mission_seed_key",nil];

		// Check if _seed is defined yet
		!(isNil "_seed")
	};

	// Create the seed vars using format
	_seedVarName = format ["seed_Vars_%1",_seed];

	// Grab any variables already defined
	_seedVars = profileNamespace getVariable [_seedVarName,[]];

	// set the seed variable so it's defined on the profile
	profileNamespace setVariable [_seedVarName,_seedVars];

	// Update seedlist
	private _seedList = profileNamespace getVariable ["seed_seedList",[]];
	_seedList pushBackUnique _seedVarName;
	profileNamespace setVariable ["seed_seedList",_seedList];

	// Save the profile
	saveProfileNamespace;
};