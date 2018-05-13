/* ----------------------------------------------------------------------------
Function: ai_ins_fnc_loop

Description:
	Runs the main loop for the ai ins plugin

Parameters:
	none
Returns:
	nothing
Examples:
	call ai_ins_fnc_loop;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// spawn the groups loop
ai_ins_loop_groups = [] spawn {

	// variables used in the loop
	private _last = 0;
	private _groups = [];
	private _editQ = [];
	private _funcQ = [];

	// loop until we get a stop variable
	while {isNil 'ai_ins_loop_stop'} do {
		call {

			// check if funcQue is empty and grab new stuff for it
			if (_funcQ isEqualTo []) then {
				_funcQ = missionNamespace getVariable ['ai_ins_groups_funcQ',[]];
			};

			// run the function from funcQ ( this is higest priority )
			if !(_funcQ isEqualTo []) exitWith {
				private _func = (_funcQ deleteAt 0);
				_func params ['_params','_code'];
				_params call _code;
				_groups = [];
			};

			// check if editQue is empty and grab new stuff for it
			if (_editQ isEqualTo []) then {
				_editQ = missionNamespace getVariable ['ai_ins_groups_editQ',[]];
			};

			// Run the edits from the editQue and exit ( also high priority )
			if !(_editQ isEqualTo []) exitWith {
				private _edit = (_editQ deleteAt 0);
				_edit call ai_ins_fnc_editQGroup;
				_groups = [];
			};

			// make sure it's been atleast 0.5 seconds, so we don't spam too much
			if (time - _last < 0.5) then {
				sleep 0.5;
			};

			// get new groups if none left to check
			if (_groups isEqualTo []) exitWith {

				// reset the used houses list
				ai_ins_houses = [];

				hintSilent (str (time - _last));

				// save current time for time check
				_last = time;

				// get all groups available
				// can't use deleteAt yet
				_groups append (missionNamespace getVariable ['ai_ins_pads',[]]);

				// reset used waypoint positions
				missionNamespace setVariable ['ai_ins_patrolWPs',[]];
			};

			// cant use deleteat because must edit the groups array

			private _target = _groups deleteAt 0;
			//private _target = _groups param [0];
			//_groups = _groups - [_target];

			// check the group for removal of empty/broken groups
			if !(_target call ai_ins_fnc_check) exitWith {};

			// update pad position
			_target call ai_ins_fnc_padPos;

			// run the caching logic for the group
			_target call ai_ins_fnc_cacheLog;


			// check the cached values for the target
			private _cached = [_target,"cached",false] call ai_ins_fnc_findParam;
			private _cached2 = [_target,"cached2",false] call ai_ins_fnc_findParam;

			// if unit is not cached, patrol
			if (!_cached && !_cached2) then {
				_target call ai_ins_fnc_patrol;
			};

			// if unit is cached run cached patrol
			if (_cached) then {
				_target call ai_ins_fnc_patrolC;
			};
		};
	};
};

// garrison loop code spawned
ai_ins_loop_garrison = [] spawn {

	// loop variables
	private _units = [];
	private _funcQ = [];
	private _editQ = [];

	// waitUntil (1 per frame)
	waitUntil {

		// call to use exitWith
		call {

			// check if funcQue is empty and grab new stuff for it
			if (_funcQ isEqualTo []) then {
				_funcQ = missionNamespace getVariable ['ai_ins_garrison_funcQ',[]];
			};

			// run funcQue code ( highest priority )
			if !(_funcQ isEqualTo []) exitWith {
				private _func = (_funcQ deleteAt 0);
				_func params ['_params','_code'];
				_params call _code;
				_units = [];
			};

			// check if editQue is empty and grab new stuff for it
			if (_editQ isEqualTo []) then {
				_editQ = missionNamespace getVariable ['ai_ins_garrison_editQ',[]];
			};

			// Run editQue ( also high priority )
			if !(_editQ isEqualTo []) exitWith {
				private _edit = (_editQ deleteAt 0);
				_edit set [2,true];
				_edit call ai_ins_fnc_editQGroup;
				_units = [];
			};

			// get new units
			if (_units isEqualTo []) exitWith {
				_units append (missionNamespace getVariable ['ai_ins_gPads',[]]);

				// clear used houses list
				missionNamespace setVariable ['ai_ins_houses',[]];
			};

			// cant use deleteat as must edit array
			private _target = _units deleteAt 0;
			// private _target = _units param [0];
			// _units = _units - [_target];

			// check if unit needs to be removed or is bugged
			if !(_target call ai_ins_fnc_check) exitWith {};

			// update pad position
			_target call ai_ins_fnc_padPos;

			// run cached logic
			_target call ai_ins_fnc_gCacheLog;
		};

		// if loopstop is set, stop the loop
		(!isNil 'ai_ins_loop_stop')
	};
};