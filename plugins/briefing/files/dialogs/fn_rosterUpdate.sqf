/* ----------------------------------------------------------------------------
Function: briefing_fnc_rosterUpdate

Description:
	Handles the showing of dead texts
	used in onload

Parameters:
	none
Returns:
	nothing
Examples:
	spawn briefing_fnc_rosterUpdate
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

// Allow saving display as variable
disableSerialization;

params ["_control"];

private _sides = call {
	if (side player isEqualTo west) exitWith {
		missionNamespace getVariable ["mission_briefing_roster_sidesWest",BRIEFING_SETTING_ROSTER_SIDESWEST];
	};
	if (side player isEqualTo east) exitWith {
		missionNamespace getVariable ["mission_briefing_roster_sidesEast",BRIEFING_SETTING_ROSTER_SIDESEAST];
	};
	if (side player isEqualTo resistance) exitWith {
		missionNamespace getVariable ["mission_briefing_roster_sidesGuer",BRIEFING_SETTING_ROSTER_SIDESGUER];
	};
	missionNamespace getVariable ["mission_briefing_roster_sidesCiv",BRIEFING_SETTING_ROSTER_SIDESCIV];
};

private _aliasAUTO = ["*", "AUTO", "ANY"];
private _traits = [
	// getUnitTrait			CfgVehicleIcons		getVariable (ACE3)
	["explosiveSpecialist",	"pictureExplosive",	"ACE_isEOD"],
	["medic",				"pictureHeal",		"ace_medical_medicClass"],
	["engineer",			"pictureRepair",	"ACE_IsEngineer"]
	//["UAVHacker",			"",					""]
];

_colorToHex = {
	private ["_ret"];
	params [["_color","white"]];
	call {
		if (_color isEqualTo "green") exitWith {"#006600"};
		if (_color isEqualTo "red") exitWith {"#e00d0d"};
		if (_color isEqualTo "blue") exitWith {"#0060ff"};
		if (_color isEqualTo "yellow") exitWith {"#ffd800"};
		if (_color isEqualTo "white") exitWith {"#FFFFFF"};
		if (_color isEqualTo "black") exitWith {"#000000"};
		"#FFFFFF"
	};
};

// get all groups
private _groupsCfg = (format ["getText(_x >> 'dataType') isEqualTo 'Group' && ((toLower(getText(_x >> 'side'))) in %1)",_sides]) configClasses (missionconfigfile >> "MissionSQM" >> "Mission" >> "Entities");


private _roster = "";
private _usedUnits = [];

{
	call {
		private _groupCfg = _x;

		// Get group variable
		private _group = (getText(_groupCfg >> "Attributes" >> "name"));
		if (_group isEqualTo '') exitWith {};
		_group = call compile _group;

		private _groupIDCfg = (("(getText(_x >> 'property')) isEqualTo 'groupID'") configClasses (_groupCfg  >> "CustomAttributes")param [0]);
		private _groupID = (getText(_groupIDCfg >> "Value" >> "data" >> "value"));

		private _inGroup = "";

		if (!isNil '_group' && {!(isNull _group)}) then {
			_groupID = groupID _group;
			_inGroup = ([""," (YOU)"]select (player in (units _group)));
		};


		private _groupSide = toLower(getText(_groupCfg >> 'side'));
		private _groupColor = call {
			if (_groupSide isEqualTo 'west') exitWith {
				'#004D99'
			};
			if (_groupSide isEqualTo 'east') exitWith {
				'#800000'
			};
			if (_groupSide isEqualTo 'independent') exitWith {
				'#008000'
			};
			'#660080'
		};

		_roster = _roster + format[
			"%1<t font='RobotoCondensedBold' size='1.2' color='%4'>%2 %3</t><br />",
			["", "<br />"] select (_forEachIndex > 0),
			_groupID,
			_inGroup,
			_groupColor
		];

		// get playable units in this group
		private _playableUnits = ("(getNumber(_x >> 'Attributes' >> 'isPlayable')) > 0" configClasses (_groupCfg >> "Entities"));

		private _nil = {
			call {
				private '_unit';
				private '_unitCfg';
				private _cfg = false;

				if (_x isEqualType objNull) then {

					// use unit
					_unit = _x;
				} else {
					_unitCfg = _x;

					// Get unit from config name/variable
					_unitVar = (getText(_unitCfg >> "Attributes" >> "name"));
					_unit = missionNamespace getVariable [_unitVar,objNull];
					/*
					if (_unit isEqualTo "") then {
						_unit = objNull;
					} else {
						_unit = compile _unit;
						if (isNil _unit) then {
							_unit = call _unit;
						} else {
							_unit = objNull;
						};
					};*/
					_cfg = true;
				};

				// if unit does not exist (slot empty)
				if (isNil '_unit' || {isNull _unit}) exitWith {

					if (_cfg) then {

						// Get unit from config name/variable
						_unit = (getText(_unitCfg >> "Attributes" >> "name"));

						// get player number
						private _playerVar = _unit;

						// exit if dude already on the roster
						if (_playerVar in _usedUnits) exitWith {};

						// add to used list
						_usedUnits pushBack _playerVar;

						private _playerNR = call compile(((_playerVar select [(count _playerVar)-2]) splitString "_") select 0);
						if (isNil "_playerNR") then {
							_playerNR = 10;
						};

						// padding for squad lead
						private _pad = if (_playerNR isEqualTo [1]) then { "        " } else { "                " };

						// get role
						private _role = (getText(_unitCfg >> "Attributes" >> "description"));

						// get rank
						private _rank = '<img image="\A3\Ui_f\data\GUI\Cfg\Ranks\private_gs.paa"/>';

						private _name = 'MIA';

						_roster = _roster + format ["%1%2<t color='%6'>%3</t> - %4%5<br />", _pad, _rank, _name, _role, "", "#000000"];
					};

				};

				// unit name
				private _name = name _unit;

				// get player number
				private _playerVar = (vehicleVarName _unit);

				// exit if dude already on the roster
				if (_playerVar in _usedUnits) exitWith {};

				// add to used list
				_usedUnits pushBack _playerVar;


				private _playerNR = call compile(((_playerVar select [(count _playerVar)-2]) splitString "_") select 0);
				if (isNil "_playerNR") then {
					_playerNR = 10;
				};

				// padding for squad lead
				private _pad = if (_playerNR isEqualTo [1]) then { "        " } else { "                " };

				// rank
				private _rank = "<img image='" + getText (configFile >> "CfgRanks" >> (str rankId _unit) >> "texture") + "' /> ";

				// Get unit description
				private _role = roleDescription _unit;
				if (_role isEqualTo "" && "loadout" in mission_plugins) then {
					_role = _unit getVariable ["unit_loadout_role",(_unit call loadout_fnc_roleFind)];
				};
				if (toUpper _role in _aliasAUTO) then {
					_role = getText (configfile >> "CfgVehicles" >> typeOf _unit >> "displayName");
				};

				private _icons = "";
				{
					_x params ["_trait", "_icon", "_var"];
					call {
						if (isNil '_unit' || isNull _unit) exitWith {};
						private _value = _unit getVariable [_var, _unit getUnitTrait _trait];
						if (isNil '_value') exitWith {};
						if (_value isEqualType 0) then { _value = _value > 0; };
						if (_value) then {
							_icons = _icons + format [" <img image='%1' />", getText (configfile >> "CfgVehicleIcons" >> _icon)];
						};
					};
				} forEach _traits;

				private _color = [toLower(assignedTeam _unit)] param [0,"MAIN"];
				_color = _color call _colorToHex;

				_roster = _roster + format ["%1%2<t color='%6'>%3</t> - %4%5<br />", _pad, _rank, _name, _role, _icons, _color];
			};
			false
		} count (_playableUnits + (units _group));
	};
} forEach _groupsCfg;




/*
private _roster = "";
{
	_roster = _roster + format["%1<t font='RobotoCondensedBold' size='1.2'>%2 %3</t><br />", ["", "<br />"] select (_forEachIndex > 0), groupID _x,([""," (YOU)"]select (player in (units _x)))];
	{
		private _unit = _x;

		private _playerVar = (vehicleVarName _unit);
		private _playerNR = call compile(((_playerVar select [(count _playerVar)-2]) splitString "_") select 0);
		if (isNil "_playerNR") then {
			_playerNR = 10;
		};

		private _pad = if (_playerNR isEqualTo [1]) then { "        " } else { "                " };

		private _rank = "<img image='" + getText (configFile >> "CfgRanks" >> (str rankId _unit) >> "texture") + "' /> ";

		private _name = name _unit;

		private _role = roleDescription _unit;
		if (_role isEqualTo "" && "loadout" in mission_plugins) then {
			_role = _unit getVariable ["unit_loadout_role",(_unit call loadout_fnc_roleFind)];
		};
		if (toUpper _role in _aliasAUTO) then {
			_role = getText (configfile >> "CfgVehicles" >> typeOf _unit >> "displayName");
		};

		private _icons = "";
		{
			_x params ["_trait", "_icon", "_var"];

			private _value = _unit getVariable [_var, _unit getUnitTrait _trait];
			if (_value isEqualType 0) then { _value = _value > 0; };
			if (_value) then {
				_icons = _icons + format [" <img image='%1' />", getText (configfile >> "CfgVehicleIcons" >> _icon)];
			};
		} forEach _traits;

		private _color = [toLower(assignedTeam _unit)] call _colorToHex;

		_roster = _roster + format ["%1%2<t color='%6'>%3</t> - %4%5<br />", _pad, _rank, _name, _role, _icons, _color];
	} forEach units _x;
} forEach (allGroups select { side _x in _sides && (!isMultiplayer || {{ isPlayer _x } count units _x > 0}) });
*/

_control ctrlSetStructuredText parseText _roster;

private _pos = ctrlPosition _control;
private _h = ctrlTextHeight _control;
_pos set [3, (_h + (safezoneH / 100))];
_control ctrlSetPosition _pos;
_control ctrlCommit 0;