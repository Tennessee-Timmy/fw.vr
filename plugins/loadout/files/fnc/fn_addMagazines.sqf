/* ----------------------------------------------------------------------------
Function: loadout_fnc_addMagazines

Description:
	Adds magazines to unit/conntainer
	Unit will only get as many as he can fit


Parameters:
0:	_target			- Unit or container
1:	_mag			- Classname of mag to be added or array:
	0:	_mag		- Classname of mag
	1:	_bullets	- Amount of bullets per mag
2:	_amount			- Amount of mags added
Returns:
	nothing
Examples:
	[player,"30Rnd_65x39_caseless_mag",5] call loadout_fnc_addMagazines;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_target","_mag",["_amount",1]];

if (isNil "_target" || {isNull _target} || {isNil "_mag"} || {!(_mag isEqualType "")} || {_mag isEqualTo ""}) exitWith {};

if (!local _target) exitWith {
	_this remoteExec ["loadout_fnc_addMagazines",_target];
};

private _varName = vehicleVarName _target;
if (isNil "_varName" || {_varName isEqualTo ""}) then {
	_varName = typeOf _target;
};

for "_i" from 1 to _amount do {
	if !(_target canAdd _mag) then {
		(format ["%1 does not have room for magazines!",_varName]) call debug_fnc_log;
	};
	_target addMagazine _mag;
};