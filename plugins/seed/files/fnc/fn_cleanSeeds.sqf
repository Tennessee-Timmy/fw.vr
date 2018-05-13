/* ----------------------------------------------------------------------------
Function: seed_fnc_cleanSeeds

Description:
	Cleans old seeds (max 30)
	Only 30 (latest) seeds will remain
	Cleans mission_seed_Var (client)
	Cleans seeds from all missions

Parameters:
	none
Returns:
	nothing
Examples:
	call seed_fnc_cleanSeeds;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// Define max seeds
_maxSeeds = SEED_SETTING_CLEANSEEDS_MAX;

// Get the list of saved seeds from profile
private _seedList = profileNamespace getVariable ["seed_seedList",[]];

// If there are less than _maxSeeds , quit
if (count _seedList < _maxSeeds) exitWith {};

// Loop for seed deletion
while {((count _seedList) > _maxSeeds)} do {
	// Delete the first seed from list
	_toDelete = _seedList deleteAt 0;

	// todo test
	//_toDelete params ["_missionName","_seed"];

	// Create seedVarName
	//_seedVarName = format ["seed_vars_%1",_seed];

	// Delete the seed from profileNamespace
	_seedVar = profileNamespace setVariable [_toDelete,nil];

	// Check if there are less than _maxSeeds seeds yet
	if (count _seedList < _maxSeeds) exitWith {

	};
};

// Save the claned seed list
profileNamespace setVariable ["seed_seedList",_seedList];
saveProfileNamespace;