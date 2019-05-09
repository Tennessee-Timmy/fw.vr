/* ----------------------------------------------------------------------------
Function: loot_fnc_postInit

Description:
	postInit script for loot plugin

Parameters:
	none
Returns:
	nothing
Examples:
	Runs in postinit (from functions.cpp)

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Script begins


// add menus
if ("menus" in mission_plugins) then {
		[["Loot Plugin","call loot_fnc_menu",[{true},{false}],true],[player]] call menus_fnc_registerItem;
};

// loop on server
if (isServer) then {
	call loot_fnc_clustersUpdate;
	call loot_fnc_srvLoopAdd;
};

if (isNil 'mission_loot_onClusterActivate') then {
	missionNamespace setVariable ['mission_loot_onClusterActivate',{
		#include "..\onActivate.sqf"
	}];
};

if (isNil 'mission_loot_onClusterDeActivate') then {
	missionNamespace setVariable ['mission_loot_onClusterDeActivate',{
		#include "..\onDeActivate.sqf"
	}];
};

if (isNil 'mission_loot_onLootSpawn') then {
	missionNamespace setVariable ['mission_loot_onLootSpawn',{
		#include "..\onLootSpawn.sqf"
	}];
};

if (hasInterface) then {

	action_loot = [
		"action_loot",
		"Loot the crate",
		"",
		{

			// todo maybe do a zombie call
			//[player,{{if (_x inArea [_this,400,400,0,false]) then {_x setVariable ["fpz_zombies_victim", _this]}} forEach fpz_zombies_zombies;}] remoteExec ['call',2];
			//[_target,['alarm_blufor',1500]] remoteExec ['say3D',-2];
			//call ten_fnc_hordeSpawn;

			private _oldTime = _target getVariable ['ten_radio_timeLeft',7];
			private _type = 'normal';
			// ([_x,(_cachedArr select _forEachIndex)] call loot_fnc_create);
			if ('Toolkit' in (items player)) then {
				_oldTime = 2;
				_type = 'fast';
			};

			// sound effect:
			// todo test
			// Sound plays from the server when the box is opened,
			// will stop if player stops
			// will stop if crate is broken (by another player)
			// will stop after 7 seconds
			// plays different sound if opened with a toolkit

			// execute sound playback from servers
			[{
				params [['_player',objNull],['_object',objNull],['_type','normal']];
				if (isNull _object) exitWith {};
				// create an invisible object to play the sound from
				private _pad = createSimpleObject ['Land_HelipadEmpty_F', getPosASL _object];
				
				// settings for fast open (toolbar)
				private _soundName = 'open_fast';
				private _dist = 75;

				// normal open (longer)
				if (_type isEqualTo 'normal') then {
					_soundName = selectRandom ['open_1','open_2','open_3'];
					_dist = 35;
				};

				[_pad,_soundName,_dist] remoteExec ['say3D'];
				
				// spawn a loop to check the removal of the box
				[_pad,_object] spawn {
					params [['_pad',objNull],['_object',objNull]];

					private _stopAt = time + 7;
					
					// wait until the box has been removed
					waitUntil {
						isNull _object ||
						isNull _pad ||
						time > _stopAt
					};

					// delete the pad (sound source)
					sleep 0.5;
					deleteVehicle _pad;
				};

				// send the player the pad of the sound
				_player setVariable ['unit_loot_currentlyOpeningSoundSource',_pad,true];
			},[player,_target,_type]] remoteExec ['call',2];

			// progress bar
			[_oldTime, [_target], {

				// success
				_crate = ((_this param [0]) param [0,objNull]);

				// todo make this a function
				// todo remoteexec
				[_crate] call {
					private _lootArr = _crate getVariable ['loot_holder_lootArr',[]];
					private _lootPos = _crate getVariable ['loot_holder_lootPos',[]];
					private _lootCluster = _crate getVariable ['loot_holder_lootCluster',objNull];
					private _clusterHolderArr = _lootCluster getVariable ['lootCluster_holderArr',[]];
					private _holderIndex = _clusterHolderArr find _crate;
					// create the actual loot
					private _loot = [_lootPos,_lootArr] call loot_fnc_create;
					private _holder = _loot param [0,objNull];

					// update the holderArr on the cluster
					_clusterHolderArr set [_holderIndex,_holder];

					private _holderPos = getPosASL _holder;
					_holderPos set [2, _holderPos#2 - 0.25];
					_holder setPosASL _holderPos;

					// deletet the box
					deleteVehicle _crate;
				};

			}, {

				// fail
				params ['_args','_elapsedTime'];
				private _target = _args param [0,objNull];

				// 
				private _soundSource = player getVariable ['unit_loot_currentlyOpeningSoundSource',objNull];
				deleteVehicle _soundSource;
				//private _oldTime = _target getVariable ['ten_radio_timeLeft',15];
				//_target setVariable ['ten_radio_timeLeft',(_oldTime - _elapsedTime),true];
			}, "Looting", {

				// check every frame
				params ['_args','_elapsedTime'];
				private _target = _args param [0,objNull];

				// check
				!(isNull _target)
			}] call ace_common_fnc_progressBar;

		},{
			private _isLootCrate = _target getVariable ['loot_holder_lootIsCrate',false];
			_isLootCrate
		}, {}, [], [0,0,0.05], 2
	] call ace_interact_menu_fnc_createAction;
	["Fort_Crate_wood", 0, [], action_loot] call ace_interact_menu_fnc_addActionToClass;
	["Land_PaperBox_01_small_closed_brown_F", 0, [], action_loot] call ace_interact_menu_fnc_addActionToClass;
	["AmmoCrate_NoInteractive_", 0, [], action_loot] call ace_interact_menu_fnc_addActionToClass;
};