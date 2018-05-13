/* ----------------------------------------------------------------------------
Function: escape_fnc_postInit

Description:
	runs the escape loop

Parameters:
	none
Returns:
	nothing
Examples:
	call ao_fnc_postInit;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins
if !(isServer) exitWith {};

[] spawn {
/*
	["blu_escape",[west,[],
	["Leave the area",
	"Escape"],
	[],"escape"],
	1,
	[{false},{false},{false}],
	[{},{},{},false]
	] call tasks_fnc_add;*/

	// Get variables
	private _sides = missionNamespace getVariable ["mission_escape_sides",ESCAPE_SETTING_SIDES];
	private _everyone = missionNamespace getVariable ["mission_escape_everyone",ESCAPE_SETTING_EVERYONE];
	private _variable = missionNamespace getVariable ["mission_escape_variable",ESCAPE_SETTING_VARIABLE];
	private _location = missionNamespace getVariable ["mission_escape_location",ESCAPE_SETTING_LOCATION];
	private _distance = missionNamespace getVariable ["mission_escape_distance",ESCAPE_SETTING_DISTANCE];
	private _away = missionNamespace getVariable ["mission_escape_away",ESCAPE_SETTING_AWAY];

	// If not server and interface and everyone enabled, quit
	//if (!isServer && {hasInterface && _everyone}) exitWith {};

	// Wait for escape to be enabled
	waitUntil {
		uiSleep 1;
		missionNamespace getVariable [_variable,false]
	};

	// create escape tasks for all factions
	{
		private _side = _x;
		if ({(_x call respawn_fnc_getSetUnitSide) isEqualTo _side} count (allUnits - (entities 'HeadlessClient_F')) > 0) then {
			private _taskName = format ["%1_escape",str _side];
			private _description = call {
				if (_away) exitWith {
					"Reach the extraction"
				};
				"Escape the area"
			};

			[_taskName,[_side,[],
			[_description,
			"Escape"],
			_location,"run"],
			1,
			[{true},{false},{false}],
			[{},{},{},false]
			] call tasks_fnc_add;
		};
	} count _sides;

	// disable respawn types, so player will not be respawned
	//missionNamespace setVariable ["mission_respawn_type",{},true];

	// wait for mission to start
	sleep 10;

	// location determination local function
	private _fnc_location = nil;
	if (_location isEqualType objNull) then {
		_fnc_location = {
			getPos _location
		};
	} else {
		_fnc_location = {
			getMarkerPos _location
		};
	};

	// area determionation local function
	private _fnc_inArea = {
		params ['_unit','_location'];
		if (_away) then {
			(_unit distance _location) >= _distance
		} else {
			(_unit distance _location) <= _distance
		};
	};
	if (_distance isEqualType true) then {
		_fnc_inArea = {
			params ['_unit','_location'];
			_unit inArea _location
		};
	};

	// wait until there's atleast 1 player
	waitUntil {!(ALIVELIST isEqualTo [])};

	// Loop until everyone is dead
	private _exit = false;
	while {true} do {
		{
			private _side = _x;

			private _units = ALIVELIST;

			// Get current location
			private _pos = call _fnc_location;

			// loop through all unit
			private _escapedCount = {

				// check if the unit has escaped yet
				if (((_x call respawn_fnc_getSetUnitSide) isEqualTo _side && {!(_x call respawn_fnc_deadCheck)}) && {[_x,_pos] call _fnc_inArea}) then {

					// if everyone does not have to escape at once, send player to spectator
					if !(_everyone) then {
						[_x,_x] remoteExec ["respawn_fnc_onRespawn",_x];
					};

					// Add player to the list of escaped players, he made it.
					private _escaped = missionNamespace getVariable ["mission_escape_units",[]];
					_escaped pushBackUnique _x;
					missionNamespace setVariable ["mission_escape_units",(_escaped)];

					// let everyone know that player has escaped
					private _text = format ["%1 has escaped",name(_x)];
					_text remoteExec ["systemChat",-2];

					true
				} else {false};
			} count ALIVELIST;

			// check if all players have escaped and quit
			if ((_escapedCount > 0) && {_escapedCount >= ({(_x call respawn_fnc_getSetUnitSide) isEqualTo _side}count PLAYERLIST)}) exitWith {
				_exit = true;
			};

		} forEach _sides;

		// check if we should exit or not
		if (_exit) exitWith {};

		// timeout
		sleep 1;
	};

	'escape end' call debug_fnc_log;
	private _escaped = missionNamespace getVariable ["mission_escape_units",[]];
	private _winners = missionNamespace getVariable ["mission_tasks_winPlayers",[]];
	missionNamespace setVariable ["mission_tasks_winPlayers",(_winners + _escaped)];
	call tasks_fnc_endSrv;
};
