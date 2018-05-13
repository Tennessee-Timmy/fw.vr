/* ----------------------------------------------------------------------------
Function: perf_fnc_clientLooper

Description:
	Looping functinality for client

Parameters:
	none
Returns:
	nothing
Examples:
	call perf_fnc_clientLooper;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

private _loop = player getVariable ['perf_loop',nil];
if (isNil '_loop') then {
	_loop = [] spawn {

		// unpause for server
		['perf_pause',false,true] call perf_fnc_srvVar;
		waitUntil {
			// code to loop
			call perf_fnc_clientLoop;
			(player getVariable ['perf_stop',false])
		};

		// pause for server
		['perf_pause',true,true] call perf_fnc_srvVar;
		player setVariable ['perf_stop',false];

		// get arrays for uncaching all
		private _arrayB = player getVariable ['perf_arrayB',[]];
		private _array = player getVariable ['perf_array',[]];
		private _arrayAll = _array + _arrayB;

		// uncache all
		private _cachedArrRem = player getVariable ['perf_cachedArrRem',[]];
		{
			if (_x getVariable ['perf_cached',false]) then {
				private _target = _x;
				_target enableSimulation true;
				_target hideObject false;
				_target setVariable ['perf_cached',false];

				// remove from cached arrays
				private _cached = player getVariable ['perf_cachedArr',[]];
				private _cachedNew = player getVariable ['perf_cachedArrNew',[]];
				private _toCheck = player getVariable ['perf_toCheck',[]];
				_cached deleteAt (_cached find _target);
				_cachedNew deleteAt (_cachedNew find _target);
				_toCheck deleteAt (_toCheck find _target);

				_cachedArrRem pushBack _target;
			};
		} forEach _arrayAll;
		[_cachedArrRem,player,true] call perf_fnc_srvUpC;

		player setVariable ['perf_toCheck',[]];
		player setVariable ['perf_loop',nil];
	};
	player setVariable ['perf_loop',_loop];
};


if (true) exitWith {};
//


//perf_pfh = [{call perf_fnc_clientLoop},0.5] call CBA_fnc_addPerFrameHandler;