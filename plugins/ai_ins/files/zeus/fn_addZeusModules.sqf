/* ----------------------------------------------------------------------------
Function: ai_ins_fnc_addZeusModules

Description:
	Adds ai_ins zeus modules to the mission

Parameters:
0:	_text		- String, name that will be displayed on the button
1:	_pos		- Postion and size of the button
2:	_code		- String of code to run when button is pressed
3:	_idc		- integer, idc to use for this control
Returns:
	_control 	- control of the button
Examples:
	call ai_ins_fnc_addZeusModules;

Author:
	nigel
---------------------------------------------------------------------------- */
// Leave if achilles is not loaded
if !(isClass (configFile >> "CfgPatches" >> "achilles_modules_f_achilles")) exitWith {};	// remove not isNull getAssignedCuratorLogic player and

// player
["* AI INS", "Edit Near Groups (simple)",
{
	params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

	private _dialogResult =	[
		"Edit Near Groups (simple)",
		[
			// The last number is optional! If you want the first selection you can remove the number.
			["State:", ["Only Cached","Only Active","Any"], 2],
			["Type:", ["Garrisoned","Inf Groups","Any"], 2],
			["Distance:", "", "10"],
			["Max Groups:", "", "1"]
		]
	] call Ares_fnc_showChooseDialog;

	// If the dialog was closed.
	if (_dialogResult isEqualTo []) exitWith{};

	// Get the selected data
	_dialogResult params ["_state", "_type", "_dist", "_max"];
	_dist = call compile _dist;
	_max = call compile _max;

	// get the near groups based on data ^
	private _groups = [_position,_max,[west,east,resistance,civilian],_dist,_state,_type] call ai_ins_fnc_getNearestGroups;
	systemChat (format ["%1 groups selected",(count _groups)]);


	//--- dialog to run edit/run functions
	_dialogResult =	[
		"Run functions",
		[
			// The last number is optional! If you want the first selection you can remove the number.
			["Move waypoint to last placed WP module:", ["No","Yes"], 0],
			["Waypoint Distance:", "", ""],
			["Remove from system:", ["No","Yes"], 0],
			["Cache:", ["Unchanged","Cache","Un-Cache"], 0],
			["Caching System:", ["Unchanged","disabled","enabled"], 0],
			["Un-Garrison:", ["No","Yes"], 0],
			["Caching Distance(smaller than un-caching:", "", ""],
			["Un-Caching Distance(bigger than caching):", "", ""]
		]
	] call Ares_fnc_showChooseDialog;

	_dialogResult params ["_moveWP",["_wPDist","100"],"_remove","_cache", "_disable", "_garr", ["_cDist","0"],["_ucDist","0"]];

	// if the first one is nil, it means the dialog was closed
	if (isNil "_moveWP") exitWith {};

	// if moveWP is yes, then editGroupsSimple for them
	if (_moveWP isEqualTo 1) then {
		private _wpPos = missionNamespace getVariable ["ai_ins_curatorWPTarget",objNull];
		if (!isNil "_wpPos" && {(_wpPos isEqualType objNull && {!isNull _wpPos}) || (_wpPos isEqualType [] && {!(_wpPos isEqualTo [])})}) then {
			[_groups,'pPos',_wpPos] call ai_ins_fnc_editGroupsSimple;
			[_groups,'pWP',false] call ai_ins_fnc_editGroupsSimple;
		};
	};

	// Compile wp dist from string and check if it's a number and bigger than 10
	_wPDist = call compile _wPDist;
	if (!isNil "_wPDist" && {_wPDist isEqualType 0 && {_wPDist > 10}}) then {
		[_groups,'pDist',_wPDist] call ai_ins_fnc_editGroupsSimple;
	};

	// if remove is yes, remove group from pad and delete cached pos (should cause checker to delete the pad)
	if (_remove isEqualTo 1) then {
		[_groups,'group',false] call ai_ins_fnc_editGroupsSimple;
		[_groups,'cachedPos',false] call ai_ins_fnc_editGroupsSimple;
	};

	// if cache is cache, cache the groups
	if (_cache isEqualTo 1) then {
		[_groups,[['cache']]] call ai_ins_fnc_editFunc;
	};

	// if cache is uncache, uncache the groups
	if (_cache isEqualTo 2) then {
		[_groups,[['uncache']]] call ai_ins_fnc_editFunc;
	};

	// if ungarrison is yes, run ungarrisson for the groups
	if (_garr isEqualTo 1) then {
		[_groups,[['ungarrison']]] call ai_ins_fnc_editFunc;
	};

	// if caching system is disabled, set allowcaching to false for the groups
	if (_disable isEqualTo 1) then {
		[_groups,'allowCaching',false] call ai_ins_fnc_editGroupsSimple;
	};

	// if caching system is enabled, set allowcaching to true for the groups
	if (_disable isEqualTo 2) then {
		[_groups,'allowCaching',true] call ai_ins_fnc_editGroupsSimple;
	};

	// compile the cache distance and set it if it's a number and > 50m and uncache distance is bigger than cache distance
	_cDist = call compile _cDist;
	private _cacheDist = [];
	if (!isNil "_cDist" && {_cDist isEqualType 0 && {_cDist > 50}}) then {
		_ucDist = call compile _ucDist;
		if (!isNil "_ucDist" && {_ucDist isEqualType 0 && {_ucDist > _cDist}}) then {
			_cacheDist = [_cDist,_ucDist];
		};
	};

	// make sure cachedist is defined and update it and alter the player of errors
	if (_cacheDist isEqualTo []) then {
		systemChat "CacheDistance failed. Both Distances must be defined";
	} else {
		[_groups,'cachingRange',_cacheDist] call ai_ins_fnc_editGroupsSimple;
	};


}] call Ares_fnc_RegisterCustomModule;


// player
["* AI INS", "Edit Near Groups (adv)",
{
	params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

	private _dialogResult =	[
		"Edit Near Groups (adv)",
		[
			// The last number is optional! If you want the first selection you can remove the number.
			["State:", ["Only Cached","Only Active","Any"], 2],
			["Type:", ["Garrisoned","Inf Groups","Any"], 2],
			["Distance:", "", "10"],
			["Max Groups:", "", "1"]
		]
	] call Ares_fnc_showChooseDialog;

	// If the dialog was closed.
	if (_dialogResult isEqualTo []) exitWith{};

	// Get the selected data
	_dialogResult params ["_state", "_type", "_dist", "_max"];
	_dist = call compile _dist;
	_max = call compile _max;

	// get the nearest groups based on parameters
	private _groups = [_position,_max,[west,east,resistance,civilian],_dist,_state,_type] call ai_ins_fnc_getNearestGroups;
	systemChat (format ["%1 groups selected",(count _groups)]);


	// show new dialog for editing
	_dialogResult =	[
		"Advanced groups edit",
		[
			["Functions ARR:", "", "[['cache']]"],
			["Parameters ARR:", "", "[['allowCaching',false]]"]
		]
	] call Ares_fnc_showChooseDialog;

	_dialogResult params ["_func", "_param"];


	// compile the function box and run editFunc if it's a proper array
	_func = call compile _func;
	if (!isNil "_func" && {_func isEqualType [] && {!(_func isEqualTo [])}}) then {
		[_groups,_func] call ai_ins_fnc_editFunc;
		systemChat 'Groups Functions success.';
	};

	// compile the parameter change and run editGroupsAdv to add it to que if it's proper array
	_param = call compile _param;
	if (!isNil "_param" && {_param isEqualType [] && {!(_param isEqualTo [])}}) then {
		[_groups,_param] call ai_ins_fnc_editGroupsAdv;
		systemChat 'Groups Params success.';
	};

}] call Ares_fnc_RegisterCustomModule;



["* AI INS", "WP - Save new waypoint",
{
	params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

	// get the object as position if it exists
	if !(_objectUnderCursor isEqualTo objNull) then {
		_position = _objectUnderCursor;
	};

	// save the position
	systemChat "Waypoint Target Saved";
	missionNamespace setVariable ["ai_ins_curatorWPTarget",_position];

}] call Ares_fnc_RegisterCustomModule;



["* AI INS", "WP - Set for target",
{
	params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

	// get the pad from cursor
	private _pad = [_objectUnderCursor] call ai_ins_fnc_getGroup;

	// if pad was not found, get the nearest pad to position of the module
	if (isNil "_pad" || {_pad isEqualTo objNull}) then {
		_pad = ([_position,1,[west,east,resistance,civilian],15,2,2] call ai_ins_fnc_getNearestGroups)param [0,objNull];;
	};

	// if pad was still not found exit with a error
	if ((isNil "_pad") || {_pad isEqualTo objNull}) exitWith {
		systemChat "Group not found in system";
	};

	// get the saved waypoint
	private _wpPos = missionNamespace getVariable ["ai_ins_curatorWPTarget",objNull];

	// if waypoint is correct and either a pos or a object, update the waypoint for the pad
	if (!isNil "_wpPos" && {(_wpPos isEqualType objNull && {!isNull _wpPos}) || (_wpPos isEqualType [] && {!(_wpPos isEqualTo [])})}) exitWith {
		[[_pad],'pPos',_wpPos] call ai_ins_fnc_editGroupsSimple;
		[[_pad],'pWP',false] call ai_ins_fnc_editGroupsSimple;
		systemChat "Waypoint updated";
	};

	// show error because waypoint was broken
	systemChat "Waypoint not found, setting waypoint failed";

}] call Ares_fnc_RegisterCustomModule;




["* AI INS", "Create New Groups",
{
	params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

	// if object under the module, use the object for the target position
	if !(_objectUnderCursor isEqualTo objNull) then {
		_position = _objectUnderCursor;
	};


	// get results for the dialog
	_dialogResult =	[
		"Create New Groups",
		[
			// The last number is optional! If you want the first selection you can remove the number.
			["Amount of groups:", "", "1"],
			["Size of group:", "", "4"],
			["Side:", "SIDE", 1],
			["Start cached:", ["No","Yes"], 0],
			["Caching System:", ["default","disabled","enabled"], 0],
			["Garrison:", ["No","Yes"], 0],
			["Move waypoint to last placed WP module:", ["No","Yes"], 0],
			["Patrol distance:", "", "500"],
			["Spawn distance:", "", "100"],
			["Extra parameters:", "", "[]"]
		]
	] call Ares_fnc_showChooseDialog;


	_dialogResult params ["_amount","_size","_side", "_startCached", "_caching", "_garrison","_moveWP","_pDist","_sDist","_extra"];

	// if amount does not exist, the dialog was closed and we should exit
	if (isNil "_amount") exitWith {};

	// compile the amount from string and ceheck if it's a number
	_amount = call compile _amount;
	if !(!isNil "_amount" && {_amount isEqualType 0 && {_amount > 0}}) exitWith {
		systemChat "Error in amount, groups not created.";
	};

	// compile the size of group from string and ceheck if it's a number
	_size = call compile _size;
	if !(!isNil "_size" && {_size isEqualType 0 && {_size > 0}}) exitWith {
		systemChat "Error in size, groups not created.";
	};

	// get the side
	_side = call {
		if (_side isEqualTo 1) exitWith {
			east
		};
		if (_side isEqualTo 2) exitWith {
			west
		};
		if (_side isEqualTo 4) then {
			hint 'Civilian not available, using independent';
		};
		resistance
	};

	// Compile the extras
	_extra = call compile _extra;
	if (!isNil "_extra" && {_extra isEqualType [] && {!(_extra isEqualTo [])}}) then {
		systemChat 'Extra params correct.';
	} else {
		systemChat 'Extra params incorrect or empty.';
		_extra = [];
	};

	// check if caching should be enabled and add it to the extra
	if (_caching > 0) then {
		if (_caching isEqualTo 1) then {
			_extra pushBack ['allowCaching',false];
		};
		if (_caching isEqualTo 2) then {
			_extra pushBack ['allowCaching',true];
		};
	};

	// check if startCached is on and add it to extra
	if (_startCached isEqualTo 0) then {
		_extra pushBack ['startCached',false];
	};
	if (_startCached isEqualTo 1) then {
		_extra pushBack ['startCached',true];
	};

	// check if garrison and add it to cached
	if (_garrison isEqualTo 1) then {
		_extra pushBack ['garrison',true];
	};

	// check if waypoint should be moved to saved one
	if (_moveWP isEqualTo 1) then {
		private _wpPos = missionNamespace getVariable ["ai_ins_curatorWPTarget",objNull];
		if (!isNil "_wpPos" && {(_wpPos isEqualType objNull && {!isNull _wpPos}) || (_wpPos isEqualType [] && {!(_wpPos isEqualTo [])})}) then {
			_extra pushBack ['pPos',_wpPos];
		};
	};

	// compile the patrol distance and check if it exists
	_pDist = call compile _pDist;
	if (!isNil "_pDist" && {_pDist isEqualType 0 && {_pDist > 10}}) then {
		_extra pushBack ['pDist',_pDist];
	} else {
		systemChat 'Patrol distance failed. Using default';
	};

	// compile the spawn distance and check if it exists
	_sDist = call compile _sDist;
	if (!isNil "_sDist" && {_sDist isEqualType 0 && {_sDist > 10}}) then {
		_extra pushBack ['sDist',_sDist];
	} else {
		systemChat 'Spawn distance failed. Using default';
	};

	// loop the spawn for every group needed to spawn
	// todo multi spawn function
	for "_i" from 1 to _amount do {
		_arr = + [objNull,_position,_side,_size,_extra];
		_arr spawn ai_ins_fnc_spawn;
	};


	systemChat (format["%1 groups created",_amount]);
}] call Ares_fnc_RegisterCustomModule;


["* AI INS", "Toggle Group icons",
{
	// if loop is not open, run the loop for icons
	if !(missionNamespace getVariable ["ai_ins_curatorLoopOpen",false]) exitWith {
		[] spawn ai_ins_fnc_onCuratorOpen;
	};

	// stop the loop for icons
	[] spawn ai_ins_fnc_onCuratorClosed;
}] call Ares_fnc_RegisterCustomModule;


["* AI INS", "Add to system",
{
	params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

	// get the object from under the cursor to add to groups
	if (_objectUnderCursor isEqualTo objNull) exitWith {
		systemChat "no valid target";
	};

	// check if target is a man and alive
	if (_objectUnderCursor isKindOf "CAManBase" || !alive _objectUnderCursor) exitWith {
		systemChat "Target not a man or dead";
	};

	// get the groups and create it if it's empty
	private _groups = missionNamespace getVariable 'ai_ins_groups';
	if (isNil '_groups') then {
		_groups = [];
		missionNamespace setVariable ['ai_ins_groups',_groups];
	};

	// check if the group for the under cursor unit already in the groups
	// get the pad from cursor
	private _pad = [_objectUnderCursor] call ai_ins_fnc_getGroup;

	// if pad was found exit with error
	if !(isNull _pad) exitWith {
		systemChat "Group already in system";
	};

	// get pos to save and create pad
	private _pos = getPos _objectUnderCursor;

	// create the new pad
	_pad = "Land_HelipadEmpty_F" createVehicle _pos;

	// Add the neccesary extra for the new pad
	[_pad,"cached",false] call ai_ins_fnc_setParam;
	[_pad,"group",(group _objectUnderCursor)] call ai_ins_fnc_setParam;
	[_pad,"savedAmount",(count units _objectUnderCursor)] call ai_ins_fnc_setParam;
	[_pad,"savedPos",_pos] call ai_ins_fnc_setParam;
	[_pad,"savedSide",(side _objectUnderCursor)] call ai_ins_fnc_setParam;


	// in unscheduled: get the ai_ins_nr and increase it by 1
	isNil {
		private _ai_ins_nr = missionNamespace getVariable ["ai_ins_nr",0];
		_ai_ins_nr = _ai_ins_nr + 1;
		missionNamespace setVariable ["ai_ins_nr",_ai_ins_nr];
		[_pad,"nr",_ai_ins_nr] call ai_ins_fnc_setParam;
	};

	// push the pad to the back of the groups
	_groups pushBack _pad;

	systemChat "Group added to system";

}] call Ares_fnc_RegisterCustomModule;



["* AI INS", "Extra params copy",
{
	params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

	// get the pad for under cursor
	private _pad = [_objectUnderCursor] call ai_ins_fnc_getGroup;

	// if pad not found, find the nearest one
	if (isNil "_pad" || {_pad isEqualTo objNull}) then {
		_pad = ([_position,1,[west,east,resistance,civilian],15,2,2] call ai_ins_fnc_getNearestGroups)param [0,objNull];;
	};

	// Check if pad was found
	if ((isNil "_pad") || {_pad isEqualTo objNull}) exitWith {
		systemChat "Group not found in system";
	};

	private _extra = [_pad] call ai_ins_fnc_copyParams;

	systemChat "Extra copied successfully";
	missionNamespace setVariable ["ai_ins_curator_extraCopy",_extra];

}] call Ares_fnc_RegisterCustomModule;




["* AI INS", "Extra params paste",
{
	params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

	// check to make sure we have something copied
	private _newExtra = missionNamespace getVariable ["ai_ins_curator_extraCopy",[]];
	if (_newExtra isEqualTo []) exitWith {
		systemChat "No copy found.";
	};

	// get the pad from under cursor
	private _pad = [_objectUnderCursor] call ai_ins_fnc_getGroup;

	// if no pad found, find the nearest one
	if (isNil "_pad" || {_pad isEqualTo objNull}) then {
		_pad = ([_position,1,[west,east,resistance,civilian],15,2,2] call ai_ins_fnc_getNearestGroups)param [0,objNull];;
	};

	// if still no pad, exit
	if ((isNil "_pad") || {_pad isEqualTo objNull}) exitWith {
		systemChat "Group not found in system";
	};

	// get the ones that should never change from original pad from the pad we paste to
	private _exclude = ['nr','group','cached','cachedPos'];


	private _nil = {
		_x params ['_n','_v'];
		if !(_n in _exclude) then {
			[_pad,_n,_v] call ai_ins_fnc_setParam;
		};
		false
	} count _newExtra;

	systemChat "Extra set successfully";

}] call Ares_fnc_RegisterCustomModule;


["* AI INS", "Toggle caching",
{
	params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

	// find pad under cursor
	private _pad = [_objectUnderCursor] call ai_ins_fnc_getGroup;

	// if no pad under cursor, check nearest pad
	if (isNil "_pad" || {_pad isEqualTo objNull}) then {
		_pad = ([_position,1,[west,east,resistance,civilian],15,2,2] call ai_ins_fnc_getNearestGroups)param [0,objNull];;
	};

	// if no pad still found exit
	if ((isNil "_pad") || {_pad isEqualTo objNull}) exitWith {
		systemChat "Group not found in system";
	};

	// check if the group is cached and change accordingly
	private _cached = [_pad,"cached",false] call ai_ins_fnc_findParam;
	private _cAllowed = [_pad,"allowCaching",false] call ai_ins_fnc_findParam;

	// if caching is currently allowed, exitwith
	if (_cAllowed) exitWith {

		// if cached, uncache
		if (_cached) then {
			[[_pad],[['uncache']]] call ai_ins_fnc_editFunc;
		};

		// set allowcaching to false
		[[_pad],"allowCaching",false] call ai_ins_fnc_editGroupsSimple;
		systemChat "Caching disabled";
	};

	// enable caching
	[[_pad],"allowCaching",true] call ai_ins_fnc_editGroupsSimple;

	systemChat "Caching enabled";

}] call Ares_fnc_RegisterCustomModule;