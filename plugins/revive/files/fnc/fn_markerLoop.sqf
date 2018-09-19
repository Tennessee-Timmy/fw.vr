/* ----------------------------------------------------------------------------
Function: revive_fnc_markerLoop

Description:
	Runs the loop for a dead player


	"mission_revive_wave_next" - CBA_Missiontime of the next respawn

Parameters:
	none

Returns:
	nothing
Examples:
	call revive_fnc_deadLoop;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

private _handle = missionNamespace getVariable ['mission_revive_markerHandle',scriptNull];

// restart it
if !(isNull _handle) then {
	terminate _handle;
};

_handle = [] spawn {
	waitUntil {
		private _markers = missionNamespace getVariable ['mission_revive_markers',[]];
		private _usedMarkers = [];
		call {
			private _players = allDeadMen;
			_players append (player nearEntities ["ACE_bodyBagObject",5000]);
			_players = _players select {_x getVariable ['unit_revive_canBeRevived',false]};

			{
				private _marker = _x getVariable ['unit_revive_marker',''];
				private _pos = getPos _x;
				if (_marker isEqualTo '') then {
					private _newUnit = _x getVariable ['unit_revive_newUnit',objNull];
					if (isNull _newUnit) exitWith {};
					_marker = createMarkerLocal [('marker_revive_'+ (name _newUnit)),_pos];
					_marker setMarkerShapeLocal 'ICON';
					_marker setMarkerTextLocal (name _newUnit + ' needs a revive');
					_marker setMarkerTypeLocal 'KIA';
					_marker setMarkerSizeLocal [0.5,0.5];
					_marker setMarkerColorLocal 'ColorBlue';
					_marker setMarkerAlphaLocal 0.5;
					_marker setMarkerDirLocal 0;
					_x setVariable ['unit_revive_marker',_marker];
				};
				_marker setMarkerPosLocal _pos;
				_usedMarkers pushBack _marker;
			} forEach _players;

		};
		call {
			_markers = _markers - _usedMarkers;

			{
				deleteMarkerLocal _x;
			} forEach _markers;
		};
		missionNamespace setVariable ['mission_revive_markers',_usedMarkers];
		(false)
	};
};
missionNamespace setVariable ['mission_revive_markerHandle',_handle];