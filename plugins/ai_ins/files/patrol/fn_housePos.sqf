/* ----------------------------------------------------------------------------
Function: ai_ins_fnc_housePos

Description:
	Checks for house positions within area

Parameters:
0:	_pos			- Position from where to check
1:	_distance		- Distance from position
2:	_size			- minimum size of house
3:	_check			- Check if there are already units in that building
4:	_house			- check house for positions

Returns:
	array			- Array of house positions
Examples:
	[_pos,_distance,_size] call ai_ins_fnc_housePos;

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ['_pos',['_distance',500],['_size',5],['_check',true],'_house'];

if !(_pos isEqualType []) then {
	_pos = getposATL _pos;
};

// loop until a house has been selected
while {isNil '_house'} do {

	// get nearest houses
	private _buildingsArray = nearestObjects [_pos, ["building"], _distance];

	// loop through the houses
	while {count _buildingsArray > 0} do {

		// select a random house
		private _num = floor (random (count _buildingsArray));
		private _target = _buildingsArray param [_num];

		// does the house have enoug positions (size param)
		private _ent = count (_target buildingPos -1) >= _size;

		// if enterable and
		if (_ent &&	{

				// checking disabled or (less than 3 houses in this area OR this house not used)
				!_check || {(count _buildingsArray < 3) || {!(_target in (missionNamespace getVariable ['ai_ins_houses',[]]))}}
			} && {

				// the house is not in banned house list
				!(typeof _target in ["Land_HouseV2_03","Land_Nasypka","Land_HouseV_1L2","Land_HouseV_1L1","Land_HouseV_1I1"])
			}

			// exit with the house
		) exitWith {
			_house = _target
		};

		// remove the house we used from nearest houses
		_buildingsArray = _buildingsArray - [_target];
	};

	// add distance because we didn't get a house yet
	_distance = _distance + 15;
};

// add the house to the list of all houses
private _houses = missionNamespace getVariable ['ai_ins_houses',[]];
_houses pushBack _house;
missionNamespace setVariable ['ai_ins_houses',_houses];

// return the building positions
_house buildingPos -1