/* ----------------------------------------------------------------------------
Function: acre_fnc_addRadios

Description:
	Add radios, based on side, also removes all radios before adding default ones

Parameters:
	none
Returns:
	nothing
Examples:
	call acre_fnc_addRadios;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

if (!hasInterface || {player getVariable ["unit_respawn_dead",false]}) exitWith {};

if (missionNamespace getVariable ['mission_acre_addBlock',false]) exitWith {};

// Remove all radios
call acre_fnc_clearRadios;

// Init variables
private _side = player call respawn_fnc_getSetUnitSide;
private _groupName = toLower (groupID(group player));
if (isNil '_groupName' || {_groupName isEqualTo ''}) then {
	_groupName = 'alpha';
};
private _isLeader = ((leader player) isEqualTo player);
private _playerVar = (vehicleVarName player);
private _playerVarLength = (count _playerVar);
private _playerRole = toLower(roleDescription player);
private _playerNR = call compile(((_playerVar select [(count _playerVar)-2]) splitString "_") select 0);
private _giveRadios_LR = missionNamespace getVariable ["mission_acre_giveRadios_LR",ACRE_SETTING_GIVERADIOS_LR];
private _giveRadios_SL = missionNamespace getVariable ["mission_acre_giveRadios_SL",ACRE_SETTING_GIVERADIOS_SL];
private _giveRadios_role_LR = (missionNamespace getVariable ["mission_acre_giveRadios_role_LR",ACRE_SETTING_GIVERADIOS_ROLE_LR]);
private _giveRadios_role_SL = (missionNamespace getVariable ["mission_acre_giveRadios_role_SL",ACRE_SETTING_GIVERADIOS_ROLE_SL]);

// these will force sl or lr on player
private _overRideSL = player getVariable ["unit_acre_SL",false];
private _overRideLR = player getVariable ["unit_acre_LR",false];

// Short Range Radio
player addItem (call {

		if (_side isEqualTo west) exitWith {
			missionNamespace getVariable ["mission_acre_radio_personal_west",ACRE_SETTING_RADIO_PERSONAL_WEST]
		};
		if (_side isEqualTo east) exitWith {
			missionNamespace getVariable ["mission_acre_radio_personal_east",ACRE_SETTING_RADIO_PERSONAL_EAST]
		};
		if (_side isEqualTo independent) exitWith {
			missionNamespace getVariable ["mission_acre_radio_personal_guer",ACRE_SETTING_RADIO_PERSONAL_GUER]
		};
		"ACRE_PRC343"
});


if (_playerNR in _giveRadios_SL || ({(_playerRole find (toLower _x)) > -1}count _giveRadios_role_SL > 0) || _overRideSL) then {
	player addItem (call {

		if (_side isEqualTo west) exitWith {
			missionNamespace getVariable ["mission_acre_radio_sl_west",ACRE_SETTING_RADIO_SL_WEST]
		};
		if (_side isEqualTo east) exitWith {
			missionNamespace getVariable ["mission_acre_radio_sl_east",ACRE_SETTING_RADIO_SL_EAST]
		};
		if (_side isEqualTo independent) exitWith {
			missionNamespace getVariable ["mission_acre_radio_sl_guer",ACRE_SETTING_RADIO_SL_GUER]
		};
		"ACRE_PRC152"
	});
};

if (_playerNR in _giveRadios_LR || ({(_playerRole find (toLower _x)) > -1}count _giveRadios_role_LR > 0) || _overRideLR) then {
	if (((backpack player) isEqualTo "")) then {
		player addBackpack "B_AssaultPack_khk";
	};
	player addItemToBackpack call {
		if (_side isEqualTo west) exitWith {
			missionNamespace getVariable ["mission_acre_radio_lr_west",ACRE_SETTING_RADIO_LR_WEST]
		};
		if (_side isEqualTo east) exitWith {
			missionNamespace getVariable ["mission_acre_radio_lr_east",ACRE_SETTING_RADIO_LR_WEST]
		};
		if (_side isEqualTo independent) exitWith {
			missionNamespace getVariable ["mission_acre_radio_lr_guer",ACRE_SETTING_RADIO_LR_WEST]
		};
		"ACRE_PRC117F"
	};
};

//--- SR radio channel
private _srCurrentChannel = call {
	if ((_groupName find 'alpha') > -1) exitWith {
		1
	};
	if ((_groupName find 'bravo') > -1) exitWith {
		2
	};
	if ((_groupName find 'charlie') > -1) exitWith {
		3
	};
	if ((_groupName find 'delta') > -1) exitWith {
		4
	};
	if ((_groupName find 'zero') > -1) exitWith {
		5
	};
	1
};


_srCurrentChannel spawn {
	private _channel = _this param [0,1];
	sleep 8;
	private _radio = ["ACRE_PRC343"] call acre_api_fnc_getRadioByType;
	if (!(isNil '_radio') && {!(_radio isEqualTo "")}) then {
		[_radio, _channel] call acre_api_fnc_setRadioChannel;
	};
};