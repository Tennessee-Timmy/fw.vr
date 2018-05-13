/* ----------------------------------------------------------------------------
Function: acre_fnc_setupRadios

Description:
	Setup default radios


Parameters:
	none
Returns:
	nothing
Examples:
	call acre_fnc_setupRadios;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins
/*
if (canSuspend) exitWith {
	isNil {call acre_fnc_setupRadios};
};*/

if (missionNamespace getVariable ['mission_acre_setupBlock',false]) exitWith {};


// init variables needed for setting frequencies
private _freq_343 = 2400;
private _freq_lr = 60;
private _lrArray = [["ACRE_PRC152",'description'],["ACRE_PRC117F",'label'],["ACRE_PRC148",'name']];	//,"PRC77","SEM52Sl","SEM70"


{
	private _preset = _x;
	// NAMES
	{
		diag_log _x;
		private _radio = _x select 0;
		private _scheme = _x select 1;

		[_radio, "default", _preset] call acre_api_fnc_copyPreset;
		[_radio, _preset, 1, "name", "PLTNET 01"] call acre_api_fnc_setPresetChannelField;
		[_radio, _preset, 2, "name", "PLTNET 02"] call acre_api_fnc_setPresetChannelField;
		[_radio, _preset, 3, "name", "PLTNET 03"] call acre_api_fnc_setPresetChannelField;
		[_radio, _preset, 4, "name", "COY"] call acre_api_fnc_setPresetChannelField;
		[_radio, _preset, 5, "name", "CAS"] call acre_api_fnc_setPresetChannelField;
		[_radio, _preset, 6, "name", "FIRES"] call acre_api_fnc_setPresetChannelField;
	} forEach _lrArray;

	["ACRE_PRC343", "default", _preset] call acre_api_fnc_copyPreset;

	// FREQUENCIES
	// 343 goes from 2400 to 2402.55
	// steps of .01
	for '_channel' from 1 to 16 do {
		["ACRE_PRC343", _preset, _channel, "frequencyRX", _freq_343] call acre_api_fnc_setPresetChannelField;
		["ACRE_PRC343", _preset, _channel, "frequencyTX", _freq_343] call acre_api_fnc_setPresetChannelField;
		_freq_343 = _freq_343 + 0.01;
	};

	// leave some middle ground between sides
	_freq_343 = _freq_343 + 0.1;


	// LR goes from 59.3750 to 71.6250
	// limited by 152 and 148
	// steps of .1250
	for '_channel' from 1 to 16 do {
		{
			private _radio = _x select 0;
			[_radio, _preset, _channel, "frequencyRX", _freq_lr] call acre_api_fnc_setPresetChannelField;
			[_radio, _preset, _channel, "frequencyTX", _freq_lr] call acre_api_fnc_setPresetChannelField;
		} forEach _lrArray;
		_freq_lr = _freq_lr + 0.1250;
	};

	// leave some middle ground between sides
	_freq_lr = _freq_lr + 0.1250;
} forEach ACRE_SETTING_PRESETS;

if !(hasInterface) exitWith {};

waitUntil {([] call acre_api_fnc_isInitialized)};

// init variables
private _side = player call respawn_fnc_getSetUnitSide;

// override
private _presetOverride = player getVariable 'unit_acre_preset';

private _preset = (call {
	if ((!isNil '_presetOverride') && {!(_presetOverride isEqualTo "")}) exitWith {
		_presetOverride
	};
	if (_side isEqualTo west) exitWith {
		ACRE_SETTING_PRESET_WEST
	};
	if (_side isEqualTo east) exitWith {
		ACRE_SETTING_PRESET_EAST
	};
	if (_side isEqualTo resistance) exitWith {
		ACRE_SETTING_PRESET_GUER
	};
	if (_side isEqualTo civilian) exitWith {
		ACRE_SETTING_PRESET_CIV
	};
	"default"
});

["ACRE_PRC343", _preset] call acre_api_fnc_setPreset;
{
	[(_x select 0), _preset] call acre_api_fnc_setPreset;
} forEach _lrArray;


//--- Babel langage system
private _babeltOverride = player getVariable 'unit_acre_babel';
if (ACRE_SETTING_BABLE_ENABLE) then {


	private _babelSetupWest = [];
	private _babelSetupEast = [];
	private _babelSetupGuer = [];
	private _babelSetupCivi = [];
	private _nil = {
		private _var = _x param [0];
		private _langs = _x param [1,['Common'],[[]]];
		private _nil = {
			private _lang = _x;
			[_lang,_lang] call acre_api_fnc_babelAddLanguageType;
			_var pushBack _lang;
			false
		} count _langs;
		false
	} count [
		[_babelSetupWest,(missionNamespace getVariable ['mission_acre_bable_west',ACRE_SETTING_BABLE_WEST])],
		[_babelSetupEast,(missionNamespace getVariable ['mission_acre_bable_east',ACRE_SETTING_BABLE_EAST])],
		[_babelSetupGuer,(missionNamespace getVariable ['mission_acre_bable_guer',ACRE_SETTING_BABLE_GUER])],
		[_babelSetupCivi,(missionNamespace getVariable ['mission_acre_bable_civi',ACRE_SETTING_BABLE_CIV])]
	];


	private _babel = call {
		if (!isNil '_babeltOverride' && {!(_babeltOverride isEqualTo [])}) exitWith {
			_babeltOverride
		};
		if (_side isEqualTo west) exitWith {
			_babelSetupWest
		};
		if (_side isEqualTo east) exitWith {
			_babelSetupEast
		};
		if (_side isEqualTo resistance) exitWith {
			_babelSetupGuer
		};
		_babelSetupCivi
	};
//	[
//		_babelSetupWest,
//		_babelSetupEast,
//		_babelSetupGuer,
//		_babelSetupCivi
//	] call acre_api_fnc_babelSetupMission;
//

	_babel call acre_api_fnc_babelSetSpokenLanguages;
};

// reset spectator if player is not dead
if (player call respawn_fnc_deadCheck) exitWith {};
[] call acre_sys_core_fnc_spectatorOff;