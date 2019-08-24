/* ----------------------------------------------------------------------------
Function: inv_fnc_postInit

Description:
    runs everything for the inventory system

Parameters:
    none
Returns:
    nothing
Examples:
    call inv_fnc_postInit;

Author:
    nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

call {
    // crate display
    "inv_layer" cutRsc ["RscTitleDisplayEmpty", "PLAIN"];
    private _display = uiNamespace getVariable "RscTitleDisplayEmpty";

    private _ctrlBG = _display ctrlCreate ['RscPicture',-1];
    _ctrlBG ctrlSetText 'plugins\inv\files\dialogs\r2.paa';

    private _x = safeZoneX;
    private _y = safeZoneY;
    private _w = safeZoneW/40;
    private _h = safeZoneH/25;

    private _pos_ctrlBG = [
        _x + (_w * 30),
        _y + (_h * 23.5),
        _w*10,
        _h*10
    ];

    _ctrlBG ctrlSetPosition _pos_ctrlBG;
    _ctrlBG ctrlCommit 0;

    private _ctrlGrpMags = _display ctrlCreate ['RscControlsGroup',-1];
    _ctrlGrpMags ctrlSetPosition [
        _x + (_w * 35),
        _y + (_h * 23.75),
        _w*5,
        _h*1.25
    ];
    _ctrlGrpMags ctrlCommit 0;

    _display setVariable ['ctrl_inv_ui_mags_grp',_ctrlGrpMags];
    missionNamespace setVariable ['mission_inv_ui_display',_display];


    _fnc_createMag = {
        params [['_count',0,[1]],['_isBG',false,[true]]];

        // max 8 mags (0 to 7)
        if (_count > 7) exitWith {};
        
        // special case for last mag (+ sign)
        if (_count isEqualTo 7) exitWith {

        };
        //private _display = missionNamespace getVariable ['ctrl_inv_ui_display',displayNull];
        //private _ctrlGrpMags = _display setVariable ['ctrl_inv_ui_mags_grp',controlNull];
        private _ctrl = _display ctrlCreate ['RscText',-1,_ctrlGrpMags];
        private _color = [0.7,0.2,0.2,1];
        private _size = 0.25;
        private _w_mag = _w*_size;
        private _h_mag = _h*(_size*2);
        private _w_spacer = _w * 0.1;
        private _h_spacer = _h * 0.1;

        private _w_bgExtra = 0;
        private _h_bgExtra = 0;
        if (_isBG) then {
            _color = [0.592,0.588,0.569,1];
            _w_bgExtra = _w * _size*0.1;
            _h_bgExtra = _h * _size*0.1;
        };
        _ctrl ctrlSetBackgroundColor _color;

        private _countRow = floor (_count / 4);
        _count = _count mod 4;
        private _pos = [
            _w * (4.85) - _w_mag - _count * _w_mag - _count * _w_spacer - (_w_bgExtra),
            _h * (1.15) - _h_mag - _countRow * _h_mag - _countRow * _h_spacer - (_h_bgExtra),
            _w_mag + _w_bgExtra*2,
            _h_mag + _h_bgExtra*2
        ];
        _ctrl ctrlSetPosition _pos;
        _ctrl ctrlCommit 0;
        
        // save the max height of a mag ( full mag )
        //if (!_isBG) then {
            _ctrl setVariable ['ctrl_inv_mag_ui_magMaxH', _pos#3];
            _ctrl setVariable ['ctrl_inv_mag_ui_color', _color];
        //};


        _ctrl
    };

    _fnc_updateMag = {

        // _magid = mag number
        // _ammoAmt = 1 is full, 0 is empty
        // _isHidden = true to hide the magazine, def: false
        // todo only update every 10% inside ammo script (floor, so it shows effect on the first bullet)
        params ['_magID',['_ammoAmt',0],['_isHidden',nil]];

        private _magCtrlArr = missionNamespace getVariable ['mission_inv_ui_mags',[]];
        private _ctrlMag = _magCtrlArr param [_magID,controlNull];
        private _ctrlMagBG = _ctrlMag getVariable ["ctrl_inv_ui_mag_bg", controlNull];

        private _ctrlMagMaxH = _ctrlMag getVariable ['ctrl_inv_mag_ui_magMaxH',0];
        private _h = _ctrlMagMaxH * _ammoAmt;

        private _ctrlPos = ctrlPosition _ctrlMag;
        _ctrlPos set [3,_h];

        _ctrlMag ctrlSetPosition _ctrlPos;
        _ctrlMag ctrlCommit 0; // todo add delay to ammo depletion

        // update color based on amount of ammo
        private _red = (1 - ((0.7*(_ammoAmt)^2)+0.2));
        private _color = + (_ctrlMag getVariable ['ctrl_inv_mag_ui_color',[0,0,0,0]]);
        _color set [0,_red];

        // black mag if no ammo
        if (_ammoAmt isEqualTo 0) then {
            _color = [0,0,0,1];
        };

        // hide or show ctrl and bg if a change is defined
        if (isNil '_isHidden') exitWith {};
        _ctrlMag ctrlShow _isHidden;
        _ctrlMagBG ctrlShow _isHidden;
    };
    // should always create all the mags and then hide them

    //create mags
    private _magCtrlArr = [];
    for '_i' from 0 to 8 do {
        private _ctrlMagBG = [_i,true] call _fnc_createMag;
        private _ctrlMag = [_i] call _fnc_createMag;
        _ctrlMag setVariable ["ctrl_inv_ui_mag_bg", _ctrlMagBG];
        _magCtrlArr pushBack _ctrlMag;
    };
    missionNamespace setVariable ['mission_inv_ui_mags',_magCtrlArr];

    // hide mags
    {
        [_forEachIndex,0,false] call _fnc_updateMag;
        false
    } forEach _magCtrlArr;
};
/*
private _ctrlMag1BG = [0,true] call _fnc_createMag;
private _ctrlMag1 = [0] call _fnc_createMag;
_ctrlMag1 setVariable ["ctrl_inv_mag_bg", _ctrlMag1BG];

private _ctrlMag2 = [1] call _fnc_createMag;
*/


/*
// crate 1 mag
private _ctrl_mag1 = _display ctrlCreate ['RscText',-1,_ctrlGrpMags];
_ctrl_mag1 ctrlSetBackgroundColor [1,0,0,1];

// mag width:
private _pos_ctrl_mag1 = [
    _w * 4.85 - _w_mag,
    _h * 1.15 - _h_mag,
    _w_mag,
    _h_mag
];
_ctrl_mag1 ctrlSetPosition _pos_ctrl_mag1;
_ctrl_mag1 ctrlCommit 0;


private _ctrl_mag2 = _display ctrlCreate ['RscText',-1,_ctrlGrpMags];
_ctrl_mag2 ctrlSetBackgroundColor [1,0,0,1];

private _pos_ctrl_mag2 = [
    _pos_ctrl_mag1#0,
    _pos_ctrl_mag1#1 - _h_mag - _h * 0.1,
    _w_mag,
    _h_mag
];

_ctrl_mag2 ctrlSetPosition _pos_ctrl_mag2;
_ctrl_mag2 ctrlCommit 0;

*/


// need HUD elements based on prior prototyping
//  - kit indicator
//  - ammo indicator (mags that show how full), like in ins/squad
//  - check ammo / inventory action
//      - shows all equipment
//      - takes a few seconds and an animation/crouch


// need a public namespace on the server for the inventories. 
//  - possible structure:
//      - global namespace which contains:
//          - list of kits and data on it
//          - a unique variable for every kit
//          - <kit>_mags etc. variabless for every kit
//              - All the data will be saved in the same global namespace, based on the unique idientifier of each kit
//  - a cleanup script
//      - delete unused variables(kit no longer exists) from list of kits, the variables themselves shoudln't matter
//      - delete abandoned kits after certain time
//  - function to update certain kit
//  - function to query data from a kit
//  - function to check all kits(or an array of data of global kits)
//  - on unit death, drop the kit
//  - on disconnect, drop the kit
//  - each kit has and ID
//      - ID has all the data for the kit
//      - Side, type, weapon, attachments, meds, perks, armor, ammo, grenades, OWNER, last position, last owner, last time used
//  - changing kits is done via Remote Exec from the server
//      - has to check if conditions are met on player, then on server, then kit is set to new state 'migration'
//      - a check after 1 seconds after migration, if kit is not taken, cancel migration and reset.
//      - player checks if possible to change -> player asks server ->
//        server checks if possible -> sets as migrating ->
//        function to change kit sent to player -> player checks if kit is still availabl ->
//        kit changed on player -> status/owner change on server
//  - kit status variable on player
//  - current kit variable on player



// kits rearm
//  - something like SQUAD, where individual parts can be rearmed for ammo points
//  - rearm from teammates(ammo carrier etc.)
//  - rearm from dead bodies
//  - rearm from vehicles / crates
//  - rearm action
//  - quick rearm (fill/take all that's left)



// magazines/ammo
//  - maybe special magazines like AP or tracer
//      - custom attributes/hit events
//        - ap shreads armor
//        - hp blocked by armor etc.
//  - ammo is tied to the kit
//  - only a few ammo types
//      - types have different dispersions and overheat ratios
//      - light (9mm/.45)
//          - blocked by armor, medium damage on health more mags, low overheat/dispersion
//      - assault/medium (556/5.45)
//          - breaks armor, medium damage on health, medium mags, medium overheat/dispersion
//      - heavy (7.62+)
//          - penetrates armor, medium damage on health, low mags, high overheat/dispersion
//      - special (rockets/missiles/grenades)
//      - special (.50)
//      - vehicle/static ammo maybe?
//      - vehicle light (mg)
//      - vehicle heavy (30mm+)
//      - vehicle special (100mm+/rocket/missile)
//  - normal reload is a fast reload, takes the next full mag
//  - reload with holding reload(or through inventory key) to have a context menu where player can choose the mag from
//  - repack magazines (in context menu)
//



// special classes
//  - special classes will be available only 1 per squad/team/map
//  - use points to buy them


// perks??
//  - fast paced kit with less armor, but guns stablizise faster


// gun stabliziation
//  - like in pr
//  - stand still and don't rotate to stay still
//  - deploying weapon will make it stable fast
//  - special equipment perks to stablizie faster
//  - smaller weapons and scopes stabilize faster
//  - zooming in destabilizes



