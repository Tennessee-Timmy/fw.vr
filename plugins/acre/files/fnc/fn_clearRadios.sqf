/* ----------------------------------------------------------------------------
Function: acre_fnc_clearRadios

Description:
	Removes all radios

Parameters:
	none
Returns:
	nothing
Examples:
	call acre_fnc_clearRadios;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

private _radios = [
	'ACRE_PRC343',
	'ACRE_PRC148',
	'ACRE_PRC152',
	'ACRE_PRC117F',
	'ACRE_PRC77',
	'ACRE_SEM52Sl',
	'ACRE_SEM70'
];

private _nil = {
	private _item = _x;
	private _nil = {
		if (((tolower _item) find (toLower _x))> -1) then {
			player removeItem _item;
		};
		false
	} count _radios;
	false
} count (items player);