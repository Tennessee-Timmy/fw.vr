// [_group,_vehArray] call aiMaster_fnc_createTransArray
// Creates an array for the group for caching / loops
//
params ["_transGroup","_vehArray"];

_vehArray params ["_group","_patrol","_cached","_fight",["_wave",nil],"_cachedActive","_cUnits",["_customLimit",nil],"_speaker","_side","_vehicle","_alert"];

_transArray = [
	_transGroup,												//Group				0
	_patrol,													//Patrol			1
	[false,50],													//Cache				2
	_fight,														//Fight				3
	if (isNil "_wave") then {nil} else {_wave},					//Wave				4
	[false,false],												//CacheActive		5
	[],															//cUnits			6
	if (isNil "_customLimit") then {nil} else {_customLimit},	//CustomLimit		7
	nil,														//Speak				8
	_side,														//Side				9
	[nil,nil,nil],												//buildingPatrol	10
	nil,														//Alert				11
	false														//Static			12
];
_transArray