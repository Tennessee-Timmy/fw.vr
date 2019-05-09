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

// crate display
"inv_layer" cutRsc ["RscTitleDisplayEmpty", "PLAIN"];
private _display = uiNamespace getVariable "RscTitleDisplayEmpty";

private _ctrl_bg = _display ctrlCreate ['RscPicture',-1];
_ctrl_bg ctrlSetText 'plugins\inv\files\dialogs\r1.paa';

private _x = safeZoneX;
private _y = safeZoneY;
private _w = safeZoneW/40;
private _h = safeZoneH/25;

_ctrl_bg ctrlSetPosition [
    _x + (_w * 30),
    _y + (_h * 20),
    _w*10,
    _h*10
];
_ctrl_bg ctrlCommit 0;

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








