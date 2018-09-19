// Add your scripts here

// the scripts below are optional hotfixes
// anim fix (ai stuck)
["CAManBase", "init", {
    params ["_unit"];

    if (animationState _unit == "acinpknlmstpsraswrfldnon") then {
        _unit playMoveNow "amovppnemstpsraswrfldnon";
    };
    _unit addEventHandler ["AnimChanged",{
        params ["_unit","_anim"];
        if (!isPlayer _unit) then {
            if (_anim == "acinpknlmstpsraswrfldnon") then {
                _unit playMoveNow "amovppnemstpsraswrfldnon";
            };
        };
    }];
},true,[],true] call CBA_fnc_addClassEventHandler;

// [placebo] fps fixes
enableSentences false;
enableEnvironment [false,true];

//