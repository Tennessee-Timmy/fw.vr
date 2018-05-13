/* ----------------------------------------------------------------------------
Function: respawn_fnc_notify

Description:
	Notifies all players of respawns

Parameters:
0:	_side			- Side that is respawning
1:	_location		- Location where the units are respawning
Returns:
	nothing
Examples:
	[west,_pos] remoteExec ["respawn_fnc_notify",2];

Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"


params ["_side","_location"];

// leave it not server
if (!isServer) exitWith {
	[_side,_pos] remoteExec ["respawn_fnc_notify",2];
};

// Check last notification, so we don't repeat the same thing.
private _lastSide = missionNamespace getVariable ["mission_respawn_notifyLastSide",sideEmpty];
private _lastTime = missionNamespace getVariable ["mission_respawn_notifyLastTime",(time-5)];

// Quit if it has not been 5 seconds and side is same
if ((time - _lastTime < 5) && (_lastSide isEqualTo _side)) exitWith {};

// set new side/time
missionNamespace setVariable ["mission_respawn_notifyLastSide",_side];
missionNamespace setVariable ["mission_respawn_notifyLastTime",time];

// Check if allowed to notify
private _enabled = missionNamespace getVariable ["mission_respawn_notify",RESPAWN_SETTING_NOTIFY];
if (!_enabled) exitWith {};

private _locationName = text ((nearestLocations [_location,["NameCityCapital","NameCity","NameVillage"],3000]) select 0);
if (isNil "_locationName") then {
	_locationName = mapGridPosition _location;
};
private _text = format ["%1 Reinforcements near %2",_side,_locationName];
private _everyone = missionNamespace getVariable ["mission_respawn_notifyEveryone",RESPAWN_SETTING_NOTIFYEVERYONE];
if (_everyone) exitWith {
	["respawn_notify",[_text]] remoteExec ["BIS_fnc_showNotification"];
};
["respawn_notify",[_text]] remoteExec ["BIS_fnc_showNotification",_side];
