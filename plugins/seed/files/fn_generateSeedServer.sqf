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

// Clean old server seeds
call seed_fnc_cleanSeeds;

// Check missionName for future reference
private _missionName = missionName;

// Check if seed for this mission already saved in server seeds
private _serverSeedArr = profileNamespace getVariable ["seed_serverSeedList",[]];

// Allow seed to be changed in all scopes
private _seed = nil;

// Loop to generate unique seed
while {isNil "_seed"} do {
	// Generate seed
	_seed = ceil (random 100000);

	// Compare the seed to every server seed
	if (({_seed isEqualTo (_x param [1,0,[0]])}count _serverSeedArr) > 0) then {

		// More than 0 seeds match

		// Reset the seed so the loop can continue
		_seed = nil;
	};
};

// Return oldSeed if there's one that already exists
private _oldSeeds = _serverSeedArr select {
	// Checks the first element of ever element in serverSeedArr and compares to missionName
	(_x param [0,"",[""]]) isEqualTo _missionName;
};

// Check for reset from mission parameter
if !(seed_reset) then {
	// Do not reset, use OLDSEED

	// Check if old seed exists
	if !(isNil "_oldSeeds") then {
		// Select the latest seed in the list
		_oldSeed = _oldSeeds select (((count _oldSeeds)-1)max 0);

		// Exists, get variables from old seed
		_oldSeed params ["_lastMissionName","_lastSeed"];
		// Set seed from oldseed
		_seed = _lastSeed;
	};
} else {

	// Reset, use NEWSEED
	// Check if old seed exists
	if !(isNil "_oldSeeds") then {
		// Old seed exists

		// Remove it from server seeds
		_serverSeedArr = _serverSeedArr - _oldSeeds;
	};

	// Add the new seed to server seeds
	_serverSeedArr pushBackUnique [_missionName,_seed];

	// Save the server seeds
	profileNamespace setVariable ["seed_serverSeedList",_serverSeedArr];
};

// Set the mission seed as public
missionNamespace setVariable ["mission_seed_key",_seed,true];

// Save the seed for this missionName
saveProfileNamespace;
