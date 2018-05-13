/* ----------------------------------------------------------------------------
Function: safe_fnc_enable

Description:
	enables safe zone restrictions for the player

Parameters:
	none
Returns:
	nothing
Examples:
	call safe_fnc_enable;
Author:
	nigel
	help from commy2
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

if (!hasInterface) exitWith {};

// remove old action / eachFrame
private _action = player getVariable 'unit_safe_action';
if (!isNil '_action') then {
	player removeAction _action;
};


commy_safezone_muzzles = getArray (configFile >> "CfgWeapons" >> "Throw" >> "muzzles") + getArray (configFile >> "CfgWeapons" >> "Put" >> "muzzles");

safe_fnc_eachFrame = {
	private _enabled = player getVariable ['unit_safe_enabled',false];

    if (_enabled) then {
        {
            _this setWeaponReloadingTime [_this, _x, 1];
        } forEach commy_safezone_muzzles;
        true
    } else {
        false
    };
};

_action = player addAction ["", {true}, [], -99, false, true, "DefaultAction", "call safe_fnc_eachFrame"];

player setVariable ['unit_safe_action',_action];

// start the loop
call safe_fnc_clientLoop;