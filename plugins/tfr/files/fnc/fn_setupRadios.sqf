/* ----------------------------------------------------------------------------
Function: tfr_fnc_setupRadios

Description:
	Setup default radios


Parameters:
	none
Returns:
	nothing
Examples:
	call tfr_fnc_setupRadios;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// settings
TFAR_PosUpdateMode = 0;
TFAR_objectInterceptionEnabled = true;

// Do not auto-add radios
TFAR_giveLongRangeRadioToGroupLeaders = false;
TFAR_givePersonalRadioToRegularSoldier = false;
TFAR_giveMicroDagrToSoldier = false;

if !(hasInterface) exitWith {};

if !(TFR_SETTING_SETUP_AUTO) exitWith {};

// init variables
private _groupName = toLower (groupID(group player));
private _isLeader = ((leader player) isEqualTo player);
private _playerVar = (vehicleVarName player);
private _playerVarLength = (count _playerVar);
private _playerNR = call compile(((_playerVar select [(count _playerVar)-2]) splitString "_") select 0);
private _side = player call respawn_fnc_getSetUnitSide;


//--- Encryption
private _encryption = nil;
if (TFR_SETTING_ENCRYPT_ENABLED) then {
	if (TFR_SETTING_ENCRYPT_SIDES) then {
		if (_side isEqualTo independent) then {
			_encryption = str (TFR_SETTING_ENCRYPT_GUER);
		} else {
			_encryption = str _side;
		};
		tf_west_radio_code = str west;
		tf_east_radio_code = str east;
		tf_independent_radio_code = str TFR_SETTING_ENCRYPT_GUER;
	} else {
		_encryption = "disabled";
		tf_west_radio_code = "disabled";
		tf_east_radio_code = "disabled";
		tf_independent_radio_code = "disabled";
	};
};

private _srFreq = [
	"110",		//1
	"120",		//2
	"130",		//3
	"140",		//4
	"150",		//5
	"160",		//6
	"170",		//7
	"180",		//8
	"190"
];
_srFreq = (group player) getVariable ["unit_tfr_sr",_srFreq];
_srFreq = player getVariable ["unit_tfr_sr",_srFreq];
//--- SR radio
private _srAdditional = -1;
private _srCurrentChannel = call {
	if ((_groupName find 'alpha') > -1) exitWith {
		0
	};
	if ((_groupName find 'bravo') > -1) exitWith {
		1
	};
	if ((_groupName find 'charlie') > -1) exitWith {
		2
	};
	if ((_groupName find 'delta') > -1) exitWith {
		3
	};
	if ((_groupName find 'zero') > -1) exitWith {
		4
	};
	0
};
private _srData = [
	_srCurrentChannel,
	7,
	_srFreq,
	2,
	(if (isNil "_encryption") then {nil} else {_encryption}),
	_srAdditional,
	2,
	getPlayerUID player,
	false,
	true
];
(group player) setVariable ['tf_sw_frequency',_srData];


//--- LR radio
private _lrFreq = [
	"50",		//1
	"51",		//2
	"52",		//3
	"53",		//4
	"54",		//5
	"55",		//6
	"56",		//7
	"57",		//8
	"58"
];
private _lrAdditional = -1;
private _lrCurrentChannel = 0;
private _lrData = [
	_lrCurrentChannel,
	7,
	_lrFreq,
	0,
	_encryption,
	_lrAdditional,
	2,
	getPlayerUID player,
	false,
	true
];
(group player) setVariable ['tf_lr_frequency',_lrData];
/*
// Wait for game to start and lower voice
_isLeader spawn {
	sleep 1;
	if (_this) then {
		30 call TFAR_fnc_setVoiceVolume;
	} else {
		10 call TFAR_fnc_setVoiceVolume;
	};
};
*/
// If radios are already initialized, also reset the settings on current radios
//if (time > 5) then {
	if (player call respawn_fnc_deadCheck) exitWith {};
	{[player, false] call TFAR_fnc_forceSpectator;} call CBA_fnc_directCall;

	if (call TFAR_fnc_haveSWRadio) then {
		[(call TFAR_fnc_activeSwRadio), _srData] call TFAR_fnc_setSwSettings;
	};
	if (call TFAR_fnc_haveLRRadio) then {
		[(call TFAR_fnc_activeLrRadio), _lrData] call TFAR_fnc_setLrSettings;
	};
//};