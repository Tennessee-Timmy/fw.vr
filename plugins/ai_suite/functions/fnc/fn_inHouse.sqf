// [_unit,_house] call aiMaster_fnc_inHouse;
// returns: bool (true == unit in house)
//
params ["_unit","_house"];

// prepare boundingbox
_obj = _house;
_bb1 = ((boundingboxReal _obj)select 0);
_bb1z = (_bb1 select 2)+1;
_bb2 = ((boundingboxReal _obj)select 1);
_bb2z = (_bb2 select 2);

// modelToWorld bounding box positions to create a rectangle
_bp01 = _obj modelToWorld [_bb1 select 0,_bb1 select 1,_bb1z];
_bp02 = _obj modelToWorld [_bb1 select 0,(_bb2 select 1),_bb1z];
_bp03 = _obj modelToWorld [_bb2 select 0,(_bb2 select 1),_bb1z];
_bp04 = _obj modelToWorld [_bb2 select 0,(_bb1 select 1),_bb1z];

// check if unit in rectangle
_area = [_bp01,_bp02,_bp03,_bp04];
_inHouse = (getPosATL _unit) inPolygon _area;

_inHouse