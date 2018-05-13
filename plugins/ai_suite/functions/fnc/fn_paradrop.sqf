// _transGroup spawn aiMaster_fnc_paradrop;
// paradrops all units in group
params ["_transGroup"];
_units = units _transGroup;

{
	sleep 0.5;
	removeBackpackGlobal _x;
	_x addBackpack "B_Parachute";
	_h = ((getPosATL(vehicle _x)) select 2)-1;
	_pos = (vehicle _x) getRelPos [15, 180];
	_x action ["Eject", (vehicle _X)];
	unassignVehicle _x;
	_x setPosATL [(_pos select 0),(_pos select 1),_h];
}count _units;