/* ----------------------------------------------------------------------------
Function: mission_fnc_checkFile

Description:
	Checks if file exists or not

Parameters:
0:	_file			- string,file location

Returns:
	Boolean			- true if file exists
Examples:
	"plugins\loadout\loadouts\nato" call mission_fnc_checkFile;
Author:
	KK
---------------------------------------------------------------------------- */
// Code begins
if !(hasInterface) exitWith {true};
private ["_ctrl", "_fileExists"];
disableSerialization;
_ctrl = findDisplay 0 ctrlCreate ["RscHTML", -1];
_ctrl htmlLoad _this;
_fileExists = ctrlHTMLLoaded _ctrl;
ctrlDelete _ctrl;
_fileExists