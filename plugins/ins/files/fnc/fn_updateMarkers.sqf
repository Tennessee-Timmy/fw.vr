{
	private ["_side","_marker"];
	_side = nil;
	_marker = _x;
	_pos = getmarkerPos _marker;
	{
		if (position _x inArea _marker) exitWith {
			if (side _x isEqualTo east) then {_side = 0;};
			if (side _x isEqualTo resistance) then {_side = 0;};
			if (side _x isEqualTo west) then {_side = 2;};
		};
	}count allunits;
	if (!isNil "_side")then{
		[_side,_marker]call {
			params ["_side","_marker"];
			private ["_side","_marker"];
			if (_side isEqualTo 0) exitWith {
					_marker setMarkerColor "ColorEAST";
					_alpha = markerAlpha _marker;
					_marker setMarkerAlpha 1;
					_marker setMarkerAlphaLocal _Alpha;
				};
			if (_side isEqualTo 1) exitWith {
				_marker setMarkerColor "ColorGUER";
					_alpha = markerAlpha _marker;
					_marker setMarkerAlpha 1;
					_marker setMarkerAlphaLocal _Alpha;
			};
			if (_side isEqualTo 2) exitWith {
				_marker setMarkerColor "ColorWEST";
					_alpha = markerAlpha _marker;
					_marker setMarkerAlpha 1;
					_marker setMarkerAlphaLocal _Alpha;
			};
		};
	};
	true
} count ins_gridmarkers;