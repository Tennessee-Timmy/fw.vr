private "_Alpha";
_buildingPos = _this buildingPos -1;
_buildingPosAmount = count _buildingPos;
if (_buildingPosAmount <= 2) then {_Alpha = 0.2;} else {
	_Alpha = ((ceil(_buildingPosAmount))/10);
};
_pos = getPosATL _this;
_px = floor ((_pos select 0) / 100);
_py = floor (((_pos select 1)+40) / 100);
_nam = format["grid_%1_%2",_px,_py];
_col = format["Color%1",east];

if ( (markerShape _nam) isEqualTo "RECTANGLE" ) then {
	if ( ((markerColor _nam) isEqualTo _col) ) then {
		_nam setMarkerAlphaLocal ( (markerAlpha _nam) + _Alpha);
	} else {
		_nam setMarkerColorLocal "ColorOrange";
		_nam setMarkerAlphaLocal ( (markerAlpha _nam) + _Alpha);
	};
} else {
	createMarker[_nam,[(_px*100)+50,(_py*100)+10,0]];
	_nam setMarkerShape "RECTANGLE";
	_nam setMarkerSize [50,50];
	_nam setMarkerColor _col;
	_nam setMarkerAlpha 1;
	_nam setMarkerAlphaLocal _Alpha;
	BRM_insurgency_gridmarkers pushBack _nam;
};
true