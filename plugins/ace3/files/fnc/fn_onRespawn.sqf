/* ----------------------------------------------------------------------------
Function: ace3_fnc_onRespawn

Description:
	Displays the last damage onthe player.

Parameters:
	none
Returns:
	nothing
Examples:
	call ace3_fnc_onRespawn;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// code begins
params ["_newUnit","_oldUnit"];

// default texts and variables
private _killer =  player getVariable ["ace_medical_lastDamageSource","Unknown"];
private _text = "<t size='2' shadow='2' color='#FFFF00'>You have died from unfortunate circumstances.</t>";
private _weapon = "an unkown weapon";

// call for exitWith
call {

	// If killer is not defined, don't change text
	if (_killer isEqualTo "Unknown") exitWith {};

	// If killer is an object/unit continue
	if (_killer isEqualType objNull) exitWith {

		// Get killer name
		private _name = name _killer;
		if (_name in [""," ",'',"Error: No unit"]) then {
			_name = getText(configfile >> "CfgVehicles" >> typeOf _killer >> "displayName");
		};

		// Get variables to get weapon/vehicle
		private _killerVehicle = vehicle _killer;
		private _killerWeapon = currentWeapon _killer;

		// Check if killer is not on foot and a man
		if ((isNull objectParent _killer ) && _killer isKindOf "CAManBase") then {

			// Check if a weapon exists.
			if (!isNil "_killerWeapon" && {_killerWeapon != ""}) then {

				_weapon = getText (configFile >> "CfgWeapons" >> _killerWeapon >> "displayName");
			};

		} else {
			private _vehicle = getText(configfile >> "CfgVehicles" >> typeOf (_killerVehicle) >> "displayName");

			// Check if killer is the driver and a man
			if ((_killer != driver (_killerVehicle)) && _killer isKindOf "CAManBase") then {

				_weapon = getText (configFile >> "CfgWeapons" >> _killerWeapon >> "displayName");
				_weapon = _weapon + " in " + _vehicle;
			} else {

				_weapon = _vehicle;
			};
		};

		_text = format ["<t size='2' shadow='2' color='#FFFF00'>%1 killed you with %2 from %3m</t>",_name,_weapon,round(_killer distance _oldUnit)];
	};

};

[_text] spawn {
	params ["_text"];


	//systemChat _text;
	cutText [_text,"BLACK OUT", 0.01,true,true];
	sleep 5;
	cutText [_text,"BLACK IN",5,true,true];
};