params ["_loc","_dist"];
private _road = nil;
private _mult = 1;
waitUntil {
	_road = selectRandom ((_loc) nearRoads (_dist * _mult));
	_mult = _mult + 1;
	!(isNil "_road")
};
_road