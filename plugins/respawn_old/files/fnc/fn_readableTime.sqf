/* ----------------------------------------------------------------------------
Function: respawn_fnc_readableTime

Description:
	Turns seconds into hours / minutes / seconds
Parameters:
0:	_time	- in seconds, time to be converted into readable time
Returns:
	hhmmss (as readable string)
Examples:
	9602 call respawn_fnc_readableTime;
	//will return "2 Hour(s) 40 Minutes(s) 2 second(s)"
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

params ["_time"];

// Total hours
private _totalHours = floor((_time / 60) / 60);

// Total minutes
private _totalMinutes = floor(_time / 60);

// Total seconds
private _totalSeconds = _time;

// Check absolute time
private _timeLeft = _time;

// Total hours
private _hours = floor _totalHours;

// Remove hours used from _timeLeft
if (_hours > 0) then {
	_timeLeft = _timeLeft - ((_hours * 60)*60);
};

// Minutes remaining
private _minutes = floor (_timeLeft/60);

// Remove minutes used from _timeLeft
if (_minutes > 0) then {
	_timeLeft = _timeLeft - (_minutes * 60);
};

// Seconds remaining
private _seconds = round _timeLeft;

private _hStr = "";
private _mStr = "";
private _sStr = "";
// Setup strings for all time
if (_hours > 0) then {
	_hStr = format ["%1 Hour(s) ",_hours];
};
if (_minutes > 0) then {
	_mStr = format ["%1 Minute(s) ",_minutes];
};
if (_seconds > 0) then {
	_sStr = format ["%1 Second(s)",_seconds];
};

// Return the whole string
format ["%1%2%3",_hStr,_mStr,_sStr]