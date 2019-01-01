#include "script_component.cpp"
/*
 * Author: joko // Jonas
 * Read Value from config and save it in the cache Location and read and save the value if the value not exist
 * if config entry not exist return empty String
 *
 * Arguments:
 * 0: Config Path or Array with Config Path <Config, Array>
 * 1: Variable Name for Saving <String>
 *
 * Return Value:
 * Cached Value <Any>
 *
 * Example:
 * ["example"] call DS_sys_fnc_readCacheValue;
 */
params [["_config", configNull, [configNull, []]], ["_varName", "", [""]]];

private _var = mission_supp_variableHandler getVariable _varName;
if (isNil "_var") then {
    if (_config isEqualType []) then {
        _path = configFile;
        {
            _path = _path >> _x;
        } count _config;
        _config = _path;
    };
    _var = call {
        if (isText _config) exitWith {
            getText _config;
        };
        if (isNumber _config) exitWith {
            getNumber _config;
        };
        if (isArray _config) exitWith {
            getArray _config;
        };
        ""
    };
    mission_supp_variableHandler setVariable [_varName, _var];
};

_var
