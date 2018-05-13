/* ----------------------------------------------------------------------------
Function: mission_fnc_initPlayable
Description:
	Runs in the preinit before everything in cfgFunctions
	This will load all playable units into arrays
Parameters:
	none
Returns:
	nothing
Examples:
	Runs in description.ext cfgFunctions
Author:
	nigel
---------------------------------------------------------------------------- */
// code begins

// init variables
private _noNameGroupSides = [];
private _noNameUnits = 0;
private _noNameUnitSides = [];
private _garbageGroupSides = [];
private _garbageGroups = 0;

// load all groups
private _groupsCfg = "getText(_x >> 'dataType') isEqualTo 'Group'" configClasses (missionconfigfile >> "MissionSQM" >> "Mission" >> "Entities");


private _noNameGroups = {
	private _group = _x;

	private _side = (getText(_group  >> "side"));

	call {

		// Push all the units to unitsCfg
		private _playableUnits = ("(getNumber(_x >> 'Attributes' >> 'isPlayable')) > 0" configClasses (_group >> "Entities"));

		// exit if there are no playable units in this group
		if (_playableUnits isEqualTo []) exitWith {false};

		// Check all units names
		private _noNameUnitsGroup = {
			private _unit = _x;
			call {

				// Get unit name
				private _name = (getText(_unit >> "Attributes" >> "name"));

				// if name is emtpy, add side to _noNameUnitSides and return true
				if (_name isEqualTo "") exitWith {
					_noNameUnitSides pushBackUnique _side;
					true
				};
				false
			};
		} count _playableUnits;
		_noNameUnits = _noNameUnits + _noNameUnitsGroup;


		// Check if group has garbage collection enabled
		private _garbageCollectEnabled = getNumber(_group >> "Attributes" >> "garbageCollect");

		if (_garbageCollectEnabled > 0) then {
			_garbageGroupSides pushBackUnique _side;
			_garbageGroups = _garbageGroups + 1;
		};

		// Get group name
		private _name = (getText(_group >> "Attributes" >> "name"));

		// If group name is empty add the side to _noNameGroupSides and return true
		if (_name isEqualTo "") exitWith {
			_noNameGroupSides pushBackUnique _side;
			true
		};
		false
	};
} count _groupsCfg;

private _hintCtext = [(parseText format ["<t size='2' underline='true' color = '#fff300'>Dear mission maker<br/> The following problems must be fixed <t color='#ff0000'>IMMEDIATELY</t>"])];

if (_garbageGroups > 0) then {
	_garbageGroupSides = _garbageGroupSides joinString ", ";
	_hintCtext pushBack (parseText format ["%2 playable groups in <t color='#ff0000'>%1</t> are set to <t color='#008bff'>DELETE WHEN EMPTY</t>. Double click on playable groups and untick <t color='#008bff'>DELETE WHEN EMPTY</t>!",_garbageGroupSides,_garbageGroups]);
};

if (_noNameGroups > 0) then {
	_noNameGroupSides = _noNameGroupSides joinString ", ";
	_hintCtext pushBack (parseText format ["Some playable groups in <t color='#ff0000'>%1</t> are missing variable names. Double click on playable groups and set variable name to ex. 'blu_1' etc.",_noNameGroupSides]);
};

if (_noNameUnits > 0) then {
	_noNameUnitSides = _noNameUnitSides joinString ", ";
	_hintCtext pushBack (parseText format ["%2 playable units in <t color='#ff0000'>%1</t> are missing variable names. Double click on playable unit and set variable name to ex. 'blu_1_1' etc.",_noNameUnitSides,_noNameUnits]);
};

if (_noNameUnits > 0 || _noNameGroups > 0) then {
	_hintCtext spawn {sleep 0.5; "MISSION ERROR!" hintC _this};
};