/* ----------------------------------------------------------------------------
Function: tfr_fnc_clearRadios

Description:
	Removes all radios

Parameters:
	none
Returns:
	nothing
Examples:
	call tfr_fnc_clearRadios;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins

_LRradios = [
	"TFAR_rt1523g",
	"TFAR_anprc155",
	"TFAR_mr3000",
	"TFAR_anarc164",
	"TFAR_mr6000l",
	"TFAR_anarc210",
	"TFAR_mr3000_multicam",
	"TFAR_anprc155_coyote",
	"TFAR_rt1523g_sage",
	"TFAR_rt1523g_green",
	"TFAR_rt1523g_fabric",
	"TFAR_rt1523g_big",
	"TFAR_rt1523g_black",
	"TFAR_rt1523g_big_bwmod",
	"TFAR_mr3000_bwmod",
	"TFAR_rt1523g_bwmod",
	"TFAR_mr3000_bwmod_tropen",
	"TFAR_rt1523g_big_bwmod_tropen",
	"TFAR_rt1523g_big_rhs",
	"TFAR_rt1523g_rhs",
	"TFAR_mr3000_rhs",
	"TFAR_bussole"
];
_SRradios = [
	"TFAR_anprc152",
	"TFAR_anprc148jem",
	"TFAR_fadak",
	"TFAR_anprc154",
	"TFAR_rf7800str",
	"TFAR_pnr1000a",
	"TFAR_microdagr"
];

if ((typeOf(unitBackpack player)) in _LRradios) then {
	removeBackpack player;
};

private _nil = {
	private _item = _x;
	player removeItems _item;
	player unlinkItem _item;
	false
} count _SRradios;