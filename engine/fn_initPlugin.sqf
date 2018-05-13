/* ----------------------------------------------------------------------------
Function: mission_fnc_initPlugin
Description:
	Runs in the preinit before everything in cfgFunctions
	This will load check all plugins that are loaded
	Allows for checking if a plugin is loaded
	Logs all plugins
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
private _pluginNames = [];
private _text_conflicts = [];
private _text_requirements = [];

// load all plugins
private _plugins = "true" configClasses (missionConfigFile >> "CfgPlugins");

// Loop through all the plugins
private _pluginCount = {
	// pushback the names
	_pluginNames pushBack (configName _x);
	true
} count _plugins;

// Check for conflicts
private _conflictCount = {
	private _plugin = _x;
	private _text = [];

	// get conflicts from main.cpp
	private _plugin_conflicts = getArray(missionConfigFile >> "CfgPlugins" >> _plugin >> "conflicts");

	// if conflicts array is not empty
	if !(_plugin_conflicts isEqualTo []) then {

		// Count / loop through all conflicts
		private _confirmed_conflicts = {
			private _conflict = _x;

			// Check if conflicting plugin is loaded
			if (_conflict in _pluginNames) then {
				_text pushBack _conflict;
			};
			(_conflict in _pluginNames)
		} count _plugin_conflicts;

		// Add all the conflict names from array to a single string
		_text = _text joinString ", ";

		// if there are atleast 1 conflicts make a text and save push into array
		if (_confirmed_conflicts > 0) then {
			private _textS = "";
			if (_confirmed_conflicts > 1) then {_textS = "s";};
			_text_conflicts pushback (parseText format ["<t color='#0fff00'>%1</t> plugin <t color='#fff300'>conflicts</t> with <t color='#ff0000'>%2</t> plugin%3<br/>",_plugin,_text,_textS]);

		};
		((_confirmed_conflicts > 0))
	} else {
		false
	};
} count _pluginNames;

// Check for missing requirements
private _requirementCount = {
	private _plugin = _x;
	private _text = [];

	// Get requirements from main.cpp
	private _plugin_requirements = getArray(missionConfigFile >> "CfgPlugins" >> _plugin >> "required");

	// If array containg requirements is not empty (requirements exist)
	if !(_plugin_requirements isEqualTo []) then {

		// count missing requirements / loop them
		private _missing_requirements = {
			private _requirement = _x;

			// if requirement is not loaded plugin, push back the name to array
			if (!(_requirement in _pluginNames)) then {
				_text pushBack _requirement;
			};
			!(_requirement in _pluginNames)
		} count _plugin_requirements;

		// Add all the conflict names from array to a single string
		_text = _text joinString ", ";

		// if there are missing requirements, create text for them and push them into the text_requirements (contains all text for missing plugins)
		if (_missing_requirements > 0) then {
			private _textS = "";
			if (_missing_requirements > 1) then {_textS = "s";};
			_text_requirements pushBack (parseText format ["<t color='#0fff00'>%1</t> plugin is <t color='#fff300'>missing required</t> plugin%3: <t color='#008bff'>%2</t><br/>",_plugin,_text,_textS]);
		};
		((_missing_requirements > 0))
	} else {
		false
	};
} count _pluginNames;

// Log the errors
"=== Mission Plugins ===" call debug_fnc_log;
str _conflictCount call debug_fnc_log;
str _requirementCount call debug_fnc_log;

// If we have some errors, we will display them with hintC (requires ok to be clicked)
if (_conflictCount > 0 || _requirementCount > 0) then {
	_text_conflicts call debug_fnc_log;
	_text_requirements call debug_fnc_log;

	// Spawn the hintC and sleep 1, because hintC won't work and display in preInit
	(_text_conflicts + _text_requirements) spawn {sleep 1; "Mission Plugin error!" hintC _this;};
};

// set the plugins list on server
mission_plugins = _pluginNames;

// Log the completion
diag_log format ["=== Mission Plugins ==="];
diag_log format ["%1 plugins successfully loaded",_pluginCount];