nig_perf_arrayB = (allMissionObjects "Building");
nig_perf_array = [];
["Building", "init", {
	nig_perf_arrayB pushBack (_this param [0])
},true,[],true] call CBA_fnc_addClassEventHandler;
["AllVehicles", "init", {
	nig_perf_array append _this;
},true,[],true] call CBA_fnc_addClassEventHandler;
nig_perf_distance = 2000;
nig_perf_stop = nil;
nig_perf_pol = [0,0,0];


if (isNil 'nig_perf_loop') then {
	nig_perf_loop = [] spawn {

		_nig_uncache_all = {
			private _nil = {
				if (_x getVariable ['nig_perf_cached',false]) then {
					_x call _nig_unCache;
				};
			} count _objectsAll;
			sleep 1;
		};
		_nig_cache = {
			private _target = _this;
			_target hideObject true;
			_target enableSimulation false;
			_target setVariable ['nig_perf_cached',true];
		};
		_nig_unCache = {
			private _target = _this;
			_target enableSimulation true;
			_target hideObject false;
			_target setVariable ['nig_perf_cached',false];
		};

		private _objectslast = 0;
		private _objects = [];
		private _p3 = nil;
		private _p2 = nil;
		private _p1 = nil;
		private _p3last = [0,0,0];
		private _dlast = 0;
		private _fov = 0;
		private _zoom = 0;
		private _objectsB = [];
		private _objectsAll = [];
		private _lastfov = 0;
		nig_perf_last = 0;

		while {(isNil "nig_perf_stop")} do {

			if (count _objects < 100) then {
				sleep 0.001
			};

			call {

				if (!(positionCameraToWorld [0,0,0] inarea [player,30,30,0,false]) && {isNull curatorCamera}) exitWith {
					call _nig_uncache_all;
				};

				private _dist = nig_perf_distance;

				private _dist2 = _dist + (_dist/4);

				if (_objects isEqualTo []) then {

					if (time - nig_perf_last < 0.1) then {
						sleep 0.001;
					};

					nig_perf_last = time;

					_objects = nig_perf_array select {!isNil "_x" && {!isNull _x}};

					nig_perf_array = _objects;

					if ((time - _objectslast) > 120) then {
						_objectslast = time;
						_objectsB = allMissionObjects "building";
						nig_perf_arrayB = _objectsB;
					} else {
						_objectsB = nig_perf_arrayB;
					};

					_objectsAll = _objects + _objectsB;

					_objects = _objectsAll select {
						(
							(!isNil {_x}) && {
								(!isNull _x) &&
								{
									(!(_x getVariable ['nig_perf_cached',false]) && {!(_x inArea [player,(_dist/3),(_dist/3),0,false])}) ||

									{(_x getVariable ['nig_perf_cached',false]) && {_x inArea [player,_dist2,_dist2,0,false]}}
								}
							}
						)
					};
				};

				if (_objects isEqualTo []) exitWith {
					sleep 0.01;
				};

				_dist2 = _dist - _dist/5;

				private _dist3 = _dist;

				private _obj = _objects param [0];
				_objects = _objects - [_obj];

				if (_obj isKindOf "Air") exitWith {
					_dist2 = (_dist + 750) max 3000;

					if (_obj inArea [player,(_dist2),(_dist2),0,false]) then {
						if (_obj getVariable ['nig_perf_cached',false]) then {
							_obj call _nig_unCache;
						};
					} else {

						if !(_obj getVariable ['nig_perf_cached',false]) then {
							_obj call _nig_cache;
						};
					};
				};

				private _target = player;

				if (!isNull curatorCamera) then {
					_target = curatorCamera;
				};

				private _pos2 = getPos player;

				private _pos1 = screenToWorld [0.5,0.5];

				private _dir = ((((_pos1 select 0) - (_pos2 select 0)) atan2 ((_pos1 select 1) - (_pos2 select 1))) + 360) % 360;

				if (time - _lastfov > 0.001) then {

					_lastfov = time;
					_fov = call CBA_fnc_getFov;
					_zoom = _fov param [0];
					_fov = _fov param [1];
					_zoom = (_zoom * 55) - log _zoom;
					_fov = log(_fov * 100);
					_fov = (_dist2*_fov)/1.5;
				};

				_p3 = player getPos [(_fov),(_dir -_zoom)];
				_p2 = player getPos [(_fov),(_dir+_zoom)];
				_p1 = player getPos [(-100),_dir];

				private _pol = [
					_p1,
					_p2,
					_p3
				];

				nig_perf_pol = _pol;

				if ((getPos _obj) inPolygon _pol) then {
					if (_obj getVariable ['nig_perf_cached',false]) then {
						_obj call _nig_unCache;
					};
				} else {
					if !(_obj getVariable ['nig_perf_cached',false]) then {
						_obj call _nig_cache;
					};
				};

				if (!isNil "_p3" && {_dist == _dist3 && {(_p3 distanceSqr _p3last) > 2500}}) then {

					private _d = (_p3 distance player);

					if (_d - _dlast > 100 || {_dlast - _d > 100}) then {

						 _p3last = _p3;
						 _dlast = _d;

						 _d = _d + (_d*1.3) - log(_d*5)*400;

						 systemChat str _d;
						 setViewDistance _d;
						 setObjectViewDistance _d;
					};
				};
			};
		};

		nig_perf_stop = nil;

		private _nil = {
			if (_x getVariable ['nig_perf_cached',false]) then {
				_x call _nig_unCache;
			};
		} count _objectsAll;

		terminate nig_perf_loop;
		nig_perf_loop = nil;
	};


	findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw",{
		_this select 0 drawPolygon [nig_perf_pol,[0,0,1,1]];
	}];
};


///

// local functions
_nig_uncache_all = {
	private _nil = {
		if (_x getVariable ['nig_perf_cached',false]) then {
			_x call _nig_unCache;
		};
	} count _objectsAll;
	//sleep 1;
};
_nig_cache = {
	private _target = _this;
	_target hideObject true;
	_target enableSimulation false;
	_target setVariable ['nig_perf_cached',true];
};
_nig_unCache = {
	private _target = _this;
	_target enableSimulation true;
	_target hideObject false;
	_target setVariable ['nig_perf_cached',false];
};

// local variables
private _objectslast = 0;
private _objects = [];
private _p3 = nil;
private _p2 = nil;
private _p1 = nil;
private _p3last = [0,0,0];
private _dlast = 0;
private _fov = 0;
private _zoom = 0;
private _objectsB = [];
private _objectsAll = [];
private _lastfov = 0;
nig_perf_last = 0;

// loop this code
while {(isNil "nig_perf_stop")} do {

	// sleep if less than 100 objects
	if (count _objects < 100) then {
		//sleep 0.001
	};

	// call for exitWith
	call {

		// if player is no longer on his body or not a curator uncache
		if (!(positionCameraToWorld [0,0,0] inarea [player,30,30,0,false]) && {isNull curatorCamera}) exitWith {
			call _nig_uncache_all;
		};

		// initialize distance
		private _dist = nig_perf_distance;

		// distance 2 for quick check (1.25x normal distance)
		private _dist2 = _dist + (_dist/4);

		// if there are no objects in the list, create a new list
		if (_objects isEqualTo []) then {

			// if it last check was less than 0.1 seconds ago, wait a frame.
			if (time - nig_perf_last < 0.1) then {
				//sleep 0.001;
			};

			// time to check next time
			nig_perf_last = time;

			// get the objects that exist from perf_array
			_objects = nig_perf_array select {!isNil "_x" && {!isNull _x}};

			// save the array now that it's checked for existance
			nig_perf_array = _objects;

			// check for new buildings every 120 seconds
			if ((time - _objectslast) > 120) then {
				_objectslast = time;
				_objectsB = allMissionObjects "building";
				nig_perf_arrayB = _objectsB;
			} else {
				_objectsB = nig_perf_arrayB;
			};

			// assemble a new array
			_objectsAll = _objects + _objectsB;

			// filter objectsAll into objects
			_objects = _objectsAll select {
				(
				 	// check if it exists
					(!isNil {_x}) && {
						// check if it's not null
						(!isNull _x) &&
						{
							// if it's not cached, check if it's more than distance/3 from the player
							(!(_x getVariable ['nig_perf_cached',false]) && {!(_x inArea [player,(_dist/3),(_dist/3),0,false])}) ||

							// if it's cached, check if it's closer than distance2 from the player
							{(_x getVariable ['nig_perf_cached',false]) && {_x inArea [player,_dist2,_dist2,0,false]}}
						}
					}
				)
			};
		};

		// if there are no objects in the array, exit with sleep.
		if (_objects isEqualTo []) exitWith {
			//sleep 0.01;
		};

		// make distance2 80% of distance
		_dist2 = _dist - _dist/5;

		// save distance as distance 3
		private _dist3 = _dist;

		// get the first object
		private _obj = _objects param [0];

		// remove it from object array
		_objects = _objects - [_obj];

		// if object is an air vehicle, increase distance by 750 with minimum result 3000
		// exit with a simple check
		if (_obj isKindOf "Air") exitWith {
			_dist2 = (_dist + 750) max 3000;

			// do a simple area check around player
			// if object in area distance 2, uncache it
			if (_obj inArea [player,(_dist2),(_dist2),0,false]) then {
				if (_obj getVariable ['nig_perf_cached',false]) then {
					_obj call _nig_unCache;
				};
			} else {

				// cache the object
				if !(_obj getVariable ['nig_perf_cached',false]) then {
					_obj call _nig_cache;
				};
			};
		};

		// set player as target
		private _target = player;

		// if there's a curator camera, use it as target
		if (!isNull curatorCamera) then {
			_target = curatorCamera;
		};

		// save pos2 as player position
		private _pos2 = getPos player;

		// save pos1 as player camera pos
		private _pos1 = screenToWorld [0.5,0.5];

		// get direction
		private _dir = ((((_pos1 select 0) - (_pos2 select 0)) atan2 ((_pos1 select 1) - (_pos2 select 1))) + 360) % 360;

		// Check if it's been more than 1 frame since last fov check
		if (time - _lastfov > 0.001) then {

			// get new fov data
			_lastfov = time;
			_fov = call CBA_fnc_getFov;
			_zoom = _fov param [0];
			_fov = _fov param [1];
			_zoom = (_zoom * 55) - log _zoom;
			_fov = log(_fov * 100);
			_fov = (_dist2*_fov)/1.5;
		};

		// p3 is rear position for polygon based on fov
		_p3 = player getPos [(_fov),(_dir -_zoom)];
		_p2 = player getPos [(_fov),(_dir+_zoom)];
		_p1 = player getPos [(-100),_dir];

		// combine positions for polygon
		private _pol = [
			_p1,
			_p2,
			_p3
		];

		// save polygon in a global variable
		nig_perf_pol = _pol;

		// check if object position in polygon
		if ((getPos _obj) inPolygon _pol) then {
			if (_obj getVariable ['nig_perf_cached',false]) then {
				_obj call _nig_unCache;
			};
		} else {
			if !(_obj getVariable ['nig_perf_cached',false]) then {
				_obj call _nig_cache;
			};
		};

		// check if _p3 (based on fov) exists and has moved atleast 50 meters
		if (!isNil "_p3" && {_dist == _dist3 && {(_p3 distanceSqr _p3last) > 2500}}) then {

			// get the distance of p3 from player
			private _d = (_p3 distance player);

			// if distance changed at least 100 meters (up or down)
			if (_d - _dlast > 100 || {_dlast - _d > 100}) then {

				// save the current distance to check next time
				 _p3last = _p3;
				 _dlast = _d;

				 // calculate new distance
				 _d = _d + (_d*1.3) - log(_d*5)*400;

				 // set mew distance (this is based on fov)
				 systemChat str _d;
				 setViewDistance _d;
				 setObjectViewDistance _d;
			};
		};
	};
	if (true) exitWith {};
};

// delete the stop variable
nig_perf_stop = nil;








////

nig_perf_arrayB = (allMissionObjects "Building");
nig_perf_array = [];
["Building", "init", {
	nig_perf_arrayB pushBack (_this param [0])
},true,[],true] call CBA_fnc_addClassEventHandler;
["AllVehicles", "init", {
	nig_perf_array append _this;
},true,[],true] call CBA_fnc_addClassEventHandler;
nig_perf_distance = 2000;
nig_perf_stop = nil;
nig_perf_pol = [0,0,0];


if (isNil 'nig_perf_loop') then {
	nig_perf_loop = [] spawn {

		// local functions
		_nig_uncache_all = {
			private _nil = {
				if (_x getVariable ['nig_perf_cached',false]) then {
					_x call _nig_unCache;
				};
			} count _objectsAll;
			//sleep 1;
		};
		_nig_cache = {
			private _target = _this;
			_target hideObject true;
			_target enableSimulation false;
			_target setVariable ['nig_perf_cached',true];
		};
		_nig_unCache = {
			private _target = _this;
			_target enableSimulation true;
			_target hideObject false;
			_target setVariable ['nig_perf_cached',false];
		};

		// local variables
		private _objectslast = 0;
		private _objects = [];
		private _p3 = nil;
		private _p2 = nil;
		private _p1 = nil;
		private _p3last = [0,0,0];
		private _dlast = 0;
		private _fov = 0;
		private _zoom = 0;
		private _objectsB = [];
		private _objectsAll = [];
		private _lastfov = 0;
		nig_perf_last = 0;

		// loop this code
		while {(isNil "nig_perf_stop")} do {

			// sleep if less than 100 objects
			if (count _objects < 100) then {
				//sleep 0.001
			};

			// call for exitWith
			call {

				// if player is no longer on his body or not a curator uncache
				if (!(positionCameraToWorld [0,0,0] inarea [player,30,30,0,false]) && {isNull curatorCamera}) exitWith {
					call _nig_uncache_all;
				};

				// initialize distance
				private _dist = nig_perf_distance;

				// distance 2 for quick check (1.25x normal distance)
				private _dist2 = _dist + (_dist/4);

				// if there are no objects in the list, create a new list
				if (_objects isEqualTo []) then {

					// if it last check was less than 0.1 seconds ago, wait a frame.
					if (time - nig_perf_last < 0.1) then {
						//sleep 0.001;
					};

					// time to check next time
					nig_perf_last = time;

					// get the objects that exist from perf_array
					_objects = nig_perf_array select {!isNil "_x" && {!isNull _x}};

					// save the array now that it's checked for existance
					nig_perf_array = _objects;

					// check for new buildings every 120 seconds
					if ((time - _objectslast) > 120) then {
						_objectslast = time;
						_objectsB = allMissionObjects "building";
						nig_perf_arrayB = _objectsB;
					} else {
						_objectsB = nig_perf_arrayB;
					};

					// assemble a new array
					_objectsAll = _objects + _objectsB;

					// filter objectsAll into objects
					_objects = _objectsAll select {
						(
						 	// check if it exists
							(!isNil {_x}) && {
								// check if it's not null
								(!isNull _x) &&
								{
									// if it's not cached, check if it's more than distance/3 from the player
									(!(_x getVariable ['nig_perf_cached',false]) && {!(_x inArea [player,(_dist/3),(_dist/3),0,false])}) ||

									// if it's cached, check if it's closer than distance2 from the player
									{(_x getVariable ['nig_perf_cached',false]) && {_x inArea [player,_dist2,_dist2,0,false]}}
								}
							}
						)
					};
				};

				// if there are no objects in the array, exit with sleep.
				if (_objects isEqualTo []) exitWith {
					//sleep 0.01;
				};

				// make distance2 80% of distance
				_dist2 = _dist - _dist/5;

				// save distance as distance 3
				private _dist3 = _dist;

				// get the first object
				private _obj = _objects param [0];

				// remove it from object array
				_objects = _objects - [_obj];

				// if object is an air vehicle, increase distance by 750 with minimum result 3000
				// exit with a simple check
				if (_obj isKindOf "Air") exitWith {
					_dist2 = (_dist + 750) max 3000;

					// do a simple area check around player
					// if object in area distance 2, uncache it
					if (_obj inArea [player,(_dist2),(_dist2),0,false]) then {
						if (_obj getVariable ['nig_perf_cached',false]) then {
							_obj call _nig_unCache;
						};
					} else {

						// cache the object
						if !(_obj getVariable ['nig_perf_cached',false]) then {
							_obj call _nig_cache;
						};
					};
				};

				// set player as target
				private _target = player;

				// if there's a curator camera, use it as target
				if (!isNull curatorCamera) then {
					_target = curatorCamera;
				};

				// save pos2 as player position
				private _pos2 = getPos player;

				// save pos1 as player camera pos
				private _pos1 = screenToWorld [0.5,0.5];

				// get direction
				private _dir = ((((_pos1 select 0) - (_pos2 select 0)) atan2 ((_pos1 select 1) - (_pos2 select 1))) + 360) % 360;

				// Check if it's been more than 1 frame since last fov check
				if (time - _lastfov > 0.001) then {

					// get new fov data
					_lastfov = time;
					_fov = call CBA_fnc_getFov;
					_zoom = _fov param [0];
					_fov = _fov param [1];
					_zoom = (_zoom * 55) - log _zoom;
					_fov = log(_fov * 100);
					_fov = (_dist2*_fov)/1.5;
				};

				// p3 is rear position for polygon based on fov
				_p3 = player getPos [(_fov),(_dir -_zoom)];
				_p2 = player getPos [(_fov),(_dir+_zoom)];
				_p1 = player getPos [(-100),_dir];

				// combine positions for polygon
				private _pol = [
					_p1,
					_p2,
					_p3
				];

				// save polygon in a global variable
				nig_perf_pol = _pol;

				// check if object position in polygon
				if ((getPos _obj) inPolygon _pol) then {
					if (_obj getVariable ['nig_perf_cached',false]) then {
						_obj call _nig_unCache;
					};
				} else {
					if !(_obj getVariable ['nig_perf_cached',false]) then {
						_obj call _nig_cache;
					};
				};

				// check if _p3 (based on fov) exists and has moved atleast 50 meters
				if (!isNil "_p3" && {_dist == _dist3 && {(_p3 distanceSqr _p3last) > 2500}}) then {

					// get the distance of p3 from player
					private _d = (_p3 distance player);

					// if distance changed at least 100 meters (up or down)
					if (_d - _dlast > 100 || {_dlast - _d > 100}) then {

						// save the current distance to check next time
						 _p3last = _p3;
						 _dlast = _d;

						 // calculate new distance
						 _d = _d + (_d*1.3) - log(_d*5)*400;

						 // set mew distance (this is based on fov)
						 systemChat str _d;
						 setViewDistance _d;
						 setObjectViewDistance _d;
					};
				};
			};
		};

		// delete the stop variable
		nig_perf_stop = nil;

		// uncache all
		private _nil = {
			if (_x getVariable ['nig_perf_cached',false]) then {
				_x call _nig_unCache;
			};
		} count _objectsAll;

		// terminate the script
		terminate nig_perf_loop;
		nig_perf_loop = nil;
	};


	// draw polygon on map
	findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw",{
		_this select 0 drawPolygon [nig_perf_pol,[0,0,1,1]];
	}];
};
