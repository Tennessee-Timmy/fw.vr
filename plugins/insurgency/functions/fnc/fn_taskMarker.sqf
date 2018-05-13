private ["_obj","_dis","_name","_new","_alpha","_bravo","_objq","_text","_pos"];
params ["_obj","_dis","_name",["_new",true]];
_alpha = 0;
_bravo = 0;
_objq = format ["%1",_name];
_text = format ["%2 %1m",_dis,_name];
/*
while {_alpha > _dis || _alpha < 1 || _bravo > _dis || _bravo < 1} do {
	_alpha = (ceil (random (_dis*2)));
	_bravo = (ceil (random (_dis*2)));
};
_pos = [(_obj select 0) + _dis  - (_alpha*2),(_obj select 1) + _dis - (_bravo*2), (_obj select 2)];
if (_new) then {
	while {[0,0,0] distance getMarkerPos _objq > 10} do {_objq = format ["%1_%2",_objq,random 100]};
	_mark = createMarker [_objq,_pos];
};
*/
if (_new) then {
	_pos = _obj getpos [random (_dis),random 360];
	while {[0,0,0] distance getMarkerPos _objq > 10} do {_objq = format ["%1_%2",_objq,random 100]};
	_mark = createMarker [_objq,_pos];
};
_objq setMarkerPos _pos;
_objq setMarkerType "hd_unknown";
_objq setMarkerColor "ColorRed";
_objq setMarkerText _text;
_objq