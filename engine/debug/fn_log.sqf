// debugs in sideChat and diag_log
// (variable || string) spawn debug_fnc_log;

// quit if not server, so we don't take crap when playing mp
if (!isServer) exitWith {};
// Code begins
params ["_info"];
// turn info into string
if !(typeName _info isEqualTo "STRING") then {
	_info = str _this;
};
// Log info
diag_log _info;
// Show info in chat on host machine
if (hasInterface && isServer) then {
	systemChat _info;
};