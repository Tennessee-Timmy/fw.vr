nig_perf_array = [];
["Building", "initPost", {
	nig_perf_array append _this;
},true,[],true] call CBA_fnc_addClassEventHandler;
["AllVehicles", "initPost", {
	nig_perf_array append _this;
},true,[],true] call CBA_fnc_addClassEventHandler;
[
	"nig_perf",
	"SLIDER",
	"Client View Distance",
	"Nigel's Performance",
	[150, 15000, 2500, 0],
	nil,
	{
		if (!hasInterface) exitWith {};
		params ["_value"];
		setViewDistance (_value - 30);
		nig_perf_distance = _value;
		if (isNil 'nig_perf_loop') then {
			nig_perf_loop = [] spawn {
				private _objects = [];
				nig_perf_last = 0;
				private _p3 = nil;
				private _p3last = [0,0,0];
				private _dlast = 0;
				waitUntil {
					call {
						if !(positionCameraToWorld [0,0,0] inarea [player,10,10,0,false]) exitWith {
							private _nil = {
								if (_x getVariable ['nig_perf_cached',false]) then {
									_x spawn {
										sleep 0.01;
										_this hideObject false;
									};
									_x enableSimulation true;
									_x setVariable ['nig_perf_cached',false];
								};
							} count nig_perf_array;
							sleep 1;
						};
						private _dist = nig_perf_distance;
						private _dist2 = _dist;
						if (_objects isEqualTo []) then {
							nig_perf_last = time;
							_objects = nig_perf_array select {!isNil "_x" && {!isNull _x}};
							missionNamespace setVariable ['nig_perf_array',_objects];
						};

						private _obj = _objects param [0];
						_objects = _objects - [_obj];
						if (_obj isKindOf "Air") then {
							_dist2 = (_dist max 3000);
						};
						private _target = player;
						if (!isNull curatorCamera) then {
							_target = curatorCamera;
						};

						(call CBA_fnc_getFov) params ['_zoom','_fov'];
						private _zoom = (_zoom * 55) - log _zoom;
						private _fov = log(_fov * 100);

						private _pos1 = screenToWorld [0.5,0.5];
						private _pos2 = getPos player;
						private _dir = ((((_pos1 select 0) - (_pos2 select 0)) atan2 ((_pos1 select 1) - (_pos2 select 1))) + 360) % 360;

						_fov = (_dist2*_fov)/1.5;

						_p3 = player getPos [(_fov),(_dir -_zoom)];
						private _pol = [
							player getPos [(-200),_dir],
							player getPos [(_fov),(_dir+_zoom)],
							_p3
						];
						if ((getPos _obj) inPolygon _pol) then {
							if (_obj getVariable ['nig_perf_cached',false]) then {
								_obj enableSimulation true;
								_obj spawn {sleep 0.01;_this hideObject false;};
								_obj setVariable ['nig_perf_cached',false];
							};
						} else {
							if !(_obj getVariable ['nig_perf_cached',false]) then {
								_obj enableSimulation false;
								_obj hideObject true;
								_obj setVariable ['nig_perf_cached',true];
							};
						};


						if (!isNil "_p3" && {_dist == _dist2 && {(_p3 distanceSqr _p3last) > 10000}}) then {
								private _d = (_p3 distance player);
							if (_d - _dlast > 100 || {_dlast - _d > 100}) then {
								_p3last = _p3;
								_dlast = _d;
								_d = _d - (_d/10);
								setViewDistance _d;
								setObjectViewDistance _d;
							};
						};
					};
					!(isNil "nig_perf_stop")
				};
				nig_perf_stop = nil;
				private _nil = {
					_x spawn {
						sleep 0.1;
						_this hideObject false;
					};
					_x enableSimulation true;
					_x setVariable ['nig_perf_cached',false];
				} count nig_perf_array;
				terminate nig_perf_loop;
				nig_perf_loop = nil;
			};
		};
	}
] call CBA_Settings_fnc_init;
/*
call CBA_fnc_getFov params ['_zoom','_fov'];
_zoom = (_zoom * 55) - log _zoom;
_fov = log(_fov * 100);
_dist = 500;

m_pol = [
	player getPos [(-200),(getDir player)],
	player getPos [(_dist*_fov),((getDir player)+_zoom)],
	player getPos [(_dist*_fov),((getDir player)-_zoom)]
];
findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw",{
	_this select 0 drawPolygon [m_pol,[0,0,1,1]];
}];

*/
/*
	private _objectsFar = _objects - _objectsNear;
	_objects
	{if (_x isEqualTo player) then {_x hideObject  false;_x enableSimulation true;}}count allUnits;
	{if (_x distance player > 1000) then {_x hideObject  true;_x enableSimulation false;}}count allMissionObjects ''
	positions inAreaArray [center, a, b, angle, isRectangle, c]
	(player nearObjects 1000)+(player nearEntities 1000))


	[] spawn {sleep 5; hint str (count ((allMissionObjects '')+(allUnits)))};
	[] spawn {sleep 5; hint str (count ((player nearObjects 10000)+(player nearEntities 10000)))}
*/