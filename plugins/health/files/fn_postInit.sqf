/* ----------------------------------------------------------------------------
Function: health_fnc_postInit

Description:
    runs everything for the health system

Parameters:
    none
Returns:
    nothing
Examples:
    call health_fnc_postInit;

Author:
    nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"

mission_health_fullHP = 10000;
mission_health_fullAP = 9;
mission_health_fullAPH = 1;

// reset hp on respawn
if (isServer) then {
    [[""],{
        params ["_unit"];

        // todo replace with update hp function
        [_unit,mission_health_fullHP,false] call health_fnc_hpUpdate;
        [_unit,0,false,false] call health_fnc_apUpdate;
        //[_unit,0,false,true] call health_fnc_apUpdate;
    },"onRespawnUnit",true] call respawn_fnc_scriptAdd;
};

// remove damange and all eventhandlers
["CAManBase", "init", {
    (_this # 0) removeAllEventHandlers "handleDamage";
    (_this # 0) addEventHandler ["HandleDamage", {0}];
},true,[],true] call CBA_fnc_addClassEventHandler;

// hitpart EH for handling damage
//player addEventHandler ["HitPart", {_this call health_fnc_onHitPart;}];
["CAManBase", "HitPart", {_this call health_fnc_onHitPart;}, true, [], true] call CBA_fnc_addClassEventHandler;
["CAManBase", "Fired", {_this call health_fnc_onFired;}, true, [], true] call CBA_fnc_addClassEventHandler;

health_fnc_onHitPart = {
    private _unit = (_this param [0,[]]) param [0,objNull];

    // make sure target is not a corpse/dead
    if (!alive _unit) exitWith {};

    private _totalDamage = 0;

    private _ap = _unit getVariable ['unit_health_ap',0];
    private _ap_startedAt = _ap;

    private _aph = _unit getVariable ['unit_health_aph',0];
    private _aph_startedAt = _aph;

    private _isBleeding = false;
    private _killedBy = objNull;

    // loop through all the organs/parts damaged
    private _nil = {
        _x params ["_target", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect"];


        // determine speed of the projectile at impact
        private _speed = 0;
        private _nil = {
            _speed = _speed + (abs _x);
        } count _velocity;

        _selection = _selection param [0,''];

        private _isApHit = false;
        private _isAphHit = false;

        // find modifer for the current part
        private _modifier = call {

            // indirect modifier
            if (!_isDirect) exitWith {
                0.2
            };

            // head
            if (_selection isEqualTo 'head') exitWith {
                // CHANGE FROM HELMET (_isAphHit)
                if (_ap >= 1) then {
                    _isApHit = true;
                    [_target,_position,_vector] remoteExec ['health_fnc_fxSparks'];
                } else {
                    [_target,_position,_vector] remoteExec ['health_fnc_fxBlood'];
                    _isBleeding = true;
                };
                2
            };

            // upper body
            if (_selection isEqualTo 'spine3') exitWith {
                if (_ap >= 1) then {
                    _isApHit = true;
                    [_target,_position,_vector] remoteExec ['health_fnc_fxArmor'];
                } else {
                    [_target,_position,_vector] remoteExec ['health_fnc_fxBlood'];
                    _isBleeding = true;
                };


                0.85
            };
            // lower body
            if (_selection isEqualTo 'spine1') exitWith {
                if (_ap >= 1) then {
                    _isApHit = true;
                    [_target,_position,_vector] remoteExec ['health_fnc_fxArmor'];
                } else {
                    [_target,_position,_vector] remoteExec ['health_fnc_fxBlood'];
                    _isBleeding = true;
                };
                0.7
            };

            // legs
            if (_selection isEqualTo 'rightupleg') exitWith {
                [_target,_position,_vector] remoteExec ['health_fnc_fxBlood'];
                _isBleeding = true;
                0.5
            };
            if (_selection isEqualTo 'leftupleg') exitWith {
                [_target,_position,_vector] remoteExec ['health_fnc_fxBlood'];
                _isBleeding = true;
                0.5
            };

            //[_target,_position,_vector] remoteExec ['health_fnc_fxBlood'];
            //_isBleeding = true;
            if (_selection isEqualTo 'rightleg') exitWith {
                _isBleeding = true;
                0.3
            };
            if (_selection isEqualTo 'leftleg') exitWith {
                _isBleeding = true;
                0.3
            };

            if (_selection isEqualTo 'rightfoot') exitWith {
                0.2
            };
            if (_selection isEqualTo 'leftfoot') exitWith {
                0.2
            };

            // arms
            if (_selection isEqualTo 'rightarm') exitWith {
                _isBleeding = true;
                0.4
            };
            if (_selection isEqualTo 'leftarm') exitWith {
                _isBleeding = true;
                0.4
            };

            if (_selection isEqualTo 'rightforearm') exitWith {
                0.2
            };
            if (_selection isEqualTo 'leftforearm') exitWith {
                0.2
            };

            0
        };

        // weapon modifier
        //systemChat str(health_firedNamespace getVariable [str _projectile,'no unit for this projectile']);
        private _firedFrom = health_firedNamespace getVariable [(str _projectile),[]];
        private _modifierShooter = 1;
        private _startSpeed = 0;
        private _gunDamage = _firedFrom call {
            _this params [['_unit',objNull],['_gun',''],['_mag',''],['_startVel',[0,0,0]]];

            if (!isNull _unit) then {
                _killedBy = _unit;
            };

            // get the inital speed of the projectile
            if !(_startVel isEqualTo [0,0,0]) then {

                private _nil = {
                    _startSpeed = _startSpeed + (abs _x);
                } count _startVel;
            };

            // if the shot came from a dead unit, only give 0.1 damage
            if (!(isNull _unit) && {(player call respawn_fnc_deadCheck)}) then {
                _modifierShooter = 0.1;
            };

            // if weapon used was throw, then use the magazine type instead (ex: SmokeShell)
            if (_gun isEqualTo 'Throw') then {
                _gun = _mag;
            };

            // if no gun, then exit with 0
            if (_gun isEqualTo '') then {

                // todo errors with ace shrapnel
                private _error = format ["ERROR! health_onHitPart: No gun: %1 | %2", (typeOf _projectile), _ammo];
                //systemChat _error;
                diag_log _error;
                _gun = _ammo param [4,''];
            };


            // Find damage mod for the guns
            private _gunDamage = health_gunsDamagesNamespace getVariable [_gun,-1];

            // if damage is not -1, exit with the damage
            if (_gunDamage != -1) exitWith {_gunDamage};

            // set gun toLower
            _gun = toLower _gun;

            // damage was not found, so attempt to find it
            private _foundAt = (allVariables health_gunsDamagesNamespace) findIf {
                ((_gun) find _x) != -1
            };

            // if no damage found, exit
            if (_foundAt == -1) exitWith {0};

            // matching gun was found, get the damage and save the current gun for faster search next time
            _gunDamage = health_gunsDamagesNamespace getVariable [((allVariables health_gunsDamagesNamespace) # _foundAt),0];
            health_gunsDamagesNamespace setVariable [_gun,_gunDamage];

            // return the damage
            _gunDamage
        };


        // lostSpeed is 1 if no speed was lost and 0.1 if ALL speed was lost
        private _lostSpeed = linearConversion[0,_startSpeed,(_startSpeed - _speed),1,0.2,true];

        // damage for this body part
        private _currentDamage = (((_gunDamage * _lostSpeed) * _modifier) * _modifierShooter);

        // remove ap damage if it was a ap hit
        if (_isApHit) then {
            // damage will be halved (65% now)
            // todo, based on ammo type, shread armor or absorb damage or dodge
            _currentDamage = _currentDamage*0.65;

            // ap will take 75% of the damage the hp takes
            //_ap = _ap - (_currentDamage)*0.75;
            _ap = _ap - 1;
        };

        // remove ap damage if it was a aph hit
        if (_isAphHit) then {
            // damage will be halved (50% now)
            _currentDamage = _currentDamage*0.5;

            // aph will take 50% of the damage the hp takes
            //_aph = _aph - (_currentDamage)*0.50;
            _aph = _aph - 1;
        };

        // add to total damage
        _totalDamage = _totalDamage + _currentDamage;

        //systemChat format ["%1 = %6 = %2 + %3 + %4 + %5 | AP: %7", _totalDamage, _gunDamage, _lostSpeed, _modifier, _modifierShooter,_currentDamage,_ap];
    } count _this;

    //systemChat str _totalDamage;

    // exit if less than 10 damage
    if (_totalDamage < 10) exitWith {};

    // save last damage
    if (!isNull _killedBy) then {
        _unit setVariable ['unit_health_lastDamageBy',_killedBy,true];
        _unit setVariable ['unit_health_lastDamageAt',CBA_Missiontime,true];
    };

    // todo only 1 remote exec (health update packet)

    // remoteExec the hp update to the target
    [_unit,(-_totalDamage),true,_isBleeding,_killedBy] remoteExec ['health_fnc_hpUpdate',_unit];

    // update ap on target if it's changed
    if (_ap != _ap_startedAt) then {
        [_unit,_ap,false,false] remoteExec ['health_fnc_apUpdate',_unit];
    };


    // DEPRECATED
    // update ap(helmet) on target if it's changed
    //if (_aph != _aph_startedAt) then {
    //    [_unit,_aph,false,true] remoteExec ['health_fnc_apUpdate',_unit];
    //};

    // check the current hp
    private _hp = [_unit] call health_fnc_hpGet;
    _hp = _hp - _totalDamage;

    // if target should be dead, kill them right now!
    if (_hp < 1) then {
        _unit setDamage 1;

        if (!isNull _killedBy) then {
            _unit setVariable ['unit_health_killedBy',_killedBy,true];
        };
    };
};

health_fnc_fxBlood = {
    if (!hasInterface) exitWith {};
    params ['_target','_position','_vector'];
   _object = _target;
    _bArray = [];
    _blood = "#particlesource" createVehicleLocal (_position);
    _blood setParticleClass "Default";
    private _redSplat = [
       ["\a3\Data_f\ParticleEffects\Universal\Universal", 16, 13, 1, 16],   //model name
       "",   //animation
       "billboard", //type
       0.1, 0.25, //period and lifecycle
       [0, 0, 0], //position
       [0.5 + random -1, 0.5 + random -1, 1], //movement vector
       1, 1, 0.3, 0, //rotation, weight, volume , rubbing
       [0.25, 0.45], //size transform
       [[0.1,0,0,0.001], [0.04,0,0,0.05], [1,1,1,0]],
       [0.00001],
       0.4,
       0.4,
       "",
       "",
       "",
       360, //angle
       false, //on surface
       0 //bounce on surface
    ];
    _blood setParticleParams _redSplat;
    _blood setdropinterval 0.001;
    _blood setPosASL _position;
    _bArray pushback _blood;
    _bArray spawn {
       _bArray = _this;
       sleep 0.1;
       { deleteVehicle _x } foreach _bArray;
    };
};
health_fnc_fxArmor = {
    if (!hasInterface) exitWith {};
    params ['_target','_position','_vector'];
    _object = _target;
    _bArray = [];
    _blood = "#particlesource" createVehicleLocal (_position);
    _blood setParticleClass "ImpactSmoke";
    //_blood setParticleParams _arr;
    _blood setdropinterval 0.001;
    _blood attachTo [_object,[0,0,0],"chest"];
    _blood setPosASL _position;
    _bArray pushback _blood;
    _bArray spawn {
        _bArray = _this;
        sleep 0.1;
        { deleteVehicle _x } foreach _bArray;
    };

    if (!local _target) exitWith {};

    // play sound
    playSound3D ['a3\sounds_f\weapons\hits\tyre_3.wss', _object, false, getPos _object, (2 + ((random 0.4) - 0.2)), 1,300];
};
health_fnc_fxSparks = {
    if (!hasInterface) exitWith {};
    params ['_target','_position','_vector'];
    _object = _target;
    _bArray = [];
    _blood = "#particlesource" createVehicleLocal (_position);
    _blood setParticleClass "Default";
    private _arr = selectRandom [
        [
            ["\A3\data_f\ParticleEffects\Universal\Universal", 16, 3, 12, 4],  //sprite name
            "", //animation name
            "Billboard", //type
            0.5, 1.4, //timer period and fadeout timer
            [0, 0, 0], //position
            (([_vector#0,_vector#1,((_vector#2)+1)]) vectorMultiply 3), //move velocity
            1, 1, 0.35,  0.80, //rot vel, weight, volume, rubbing
            [0.06,0.005], //size transform
            [[1,1,1,0], [0.1,0.1,0.1,-4], [0,0,0,-4],[1,1,1,1]],  //color and transperency
            [1000], //animation phase speed
            0.2,   //randomdirection period
            0.7,  //randomization intensity
            "", //onTimer
            "",  //beforeDestroy
            "",  //object
            360,  //angle
            false,  //on the surface
            0  //bounce
        ],
        [
            ["\A3\data_f\ParticleEffects\Universal\Universal", 16, 4, 11, 4],  //sprite name
            "", //animation name
            "Billboard", //type
            0.5, 1.4, //timer period and fadeout timer
            [0, 0, 0], //position
            (([_vector#0,_vector#1,((_vector#2)+1)]) vectorMultiply 3), //move velocity
            1, 1, 0.35,  0.80, //rot vel, weight, volume, rubbing
            [0.06,0.005], //size transform
            [[1,1,1,0], [0.1,0.1,0.1,-4], [0,0,0,-4],[1,1,1,1]],  //color and transperency
            [1000], //animation phase speed
            0.2,   //randomdirection period
            0.7,  //randomization intensity
            "", //onTimer
            "",  //beforeDestroy
            "",  //object
            360,  //angle
            false,  //on the surface
            0  //bounce
        ],
        [
            ["\A3\data_f\ParticleEffects\Universal\Universal", 16, 6, 0, 4],  //sprite name
            "", //animation name
            "Billboard", //type
            0.5, 1.4, //timer period and fadeout timer
            [0, 0, 0], //position
            (([_vector#0,_vector#1,((_vector#2)+1)]) vectorMultiply 3), //move velocity
            1, 1, 0.35,  0.80, //rot vel, weight, volume, rubbing
            [0.06,0.005], //size transform
            [[1,1,1,0], [0.1,0.1,0.1,-4], [0,0,0,-4],[1,1,1,1]],  //color and transperency
            [1000], //animation phase speed
            0.2,   //randomdirection period
            0.7,  //randomization intensity
            "", //onTimer
            "",  //beforeDestroy
            "",  //object
            360,  //angle
            false,  //on the surface
            0  //bounce
        ]
    ];


    _blood setParticleParams _arr;
    _blood setdropinterval 0.001;
    _blood attachTo [_object,[0,0,0],"head"];
    _blood setPosASL _position;
    _bArray pushback _blood;
    _bArray spawn {
        _bArray = _this;
        sleep 0.1;
        { deleteVehicle _x } foreach _bArray;
    };

    if (!local _target) exitWith {};

    // play sound
    //playSound3D ['a3\sounds_f\weapons\hits\metal_3.wss', _object, false, getPos _object, (3 + ((random 0.4) - 0.2)), 1,300];

    playSound3D [mission_health_fxSparkSound, _object, false, getPos _object, (2.2 + ((random 0.4) - 0.2)), 1,300];
};

health_fnc_hpUpdate = {
    // updates the hp to a new value
    // all hp change is instant
    // isAdded false means the hp is replaced to the value
    // isbleeding will cause the target to bleed after the hp has changed
    // [target,new value,isAdded,isBleeding]
    // [player,300,true,true] call health_fnc_hpUpdate;

    disableSerialization;
    params ['_unit','_value','_isAdded',['_isBleeding',false],['_damageFrom',objNull]];

    if (!local _unit) exitWith {};
    private _hp = [_unit] call health_fnc_hpGet;
    private _oldHP = _hp;

    if (_isAdded) then {
        _hp = _hp + _value;
    } else {

        // limit to max hp
        _hp = (_value min mission_health_fullHP);
    };

    // if hp is too low, kill the target
    if (_hp < 1) then {
        _unit setDamage 1;
        _hp = mission_health_fullHP;
    };

    // if more than 150 damage and unit is healing, stop healing, then stop any healing
    if (_value < -150 && {_unit getVariable ['unit_health_isHealing',0] > 0}) then {
        _unit setVariable ['unit_health_isHealing',0,true];
    };

    [_unit,_hp] call health_fnc_hpSet;


    // todo _isBleeding always true if damage higher than 300 (add armor negotion)
    if (_value < - 300) then {_isBleeding = true};

    // create damage indicators
    call {

        // only run if the unit is player
        if !(isPlayer _unit) exitWith {};

        // only do if 100 hp or more was removed
        if (_value > -100) exitWith {};
        
        private _isSourceKnown = true;

        // determine where the damage came from
        if (_damageFrom isEqualTo objNull) then {

            // make 4 markers in 4 directions
            _isSourceKnown = false;
        };


        // if damage from is an array AND it doesn't have 3 elements(position) or it is near [0,0,0], then exit
        if (_damageFrom isEqualType [] && {(count _damageFrom) != 3 || {_damageFrom inArea [[0,0,0],100,100,0,false]}}) exitWith {};

        // make an array for all the current hitmarkers
        // a single PFH to check them every frame
        // a function to make an unknown damage indicator (full circle)
        
        private _fnc_createCtrl = {
            private _ctrl = findDisplay 46 ctrlCreate ["RscPictureKeepAspect", -1];
            _ctrl ctrlSetPosition [safezoneX,safezoneY,safezoneW,safezoneH];

            // todo set this as a global variable
            imgPath = [(str missionConfigFile), 0, -15] call BIS_fnc_trimString;
            imgPath = imgPath + "plugins\health\files\dialogs\hit_";

            // set the default image
            _ctrl ctrlSetText imgPath + '3.paa';
            _ctrl ctrlCommit 0;
            
            // color and opacity for the image
            _ctrl ctrlSetTextColor [0.5,1,1,0.4];
            _ctrl
        };
        
        // create a new control for this damage indication
        private _ctrl = call _fnc_createCtrl;

        private _angle = 0;
        private _alpha = 1;
        

        // get angle based on where the damage came from, if it's known
        if (_isSourceKnown) then {
            _angle = (player getDir _damageFrom) - (getDir player);
            if (_angle < 0) then {
                _angle = 360 + _angle;
            };
        } else {
            _angle = 0;
        };
        _ctrl setVariable ['ctrl_health_hitMarker_angle',_angle];
        _ctrl setVariable ['ctrl_health_hitMarker_alpha',_alpha];
        _ctrl setVariable ['ctrl_health_hitMarker_damageFrom',_damageFrom];

        // convert the angle if it's higher than 180, so it's easier to know if it's behind or in front of the player
        private _angle2 = _angle;
        if (_angle > 180) then {_angle2 = _angle2 -360};

        // image will be:
        //      center of the screen: 5
        //      nearby center(on screen): 4
        //      behind/on edges: 3

        
        if (_isSourceKnown) then {
            _ctrl ctrlSetText (imgPath+ call {
                if (_angle2 < 20 && _angle2 > -20) exitWith {
                    '5.paa';
                };
                if (_angle2 < 60 && _angle2 > -60) exitWith {
                    '4.paa';
                };
                '3.paa';
            });
        };

        // update the array of current hitmarkers
        // also make the 4 angle markers here if there is no damagefrom
        private _hitMarkerArray = missionNamespace getVariable ['mission_health_hitmarker_array',nil];

        // if the array doesn't exist create it and link it
        if (isNil '_hitMarkerArray') then {
            _hitMarkerArray = [];
            missionNamespace setVariable ['mission_health_hitmarker_array',_hitMarkerArray];
        };

        _hitMarkerArray pushBack _ctrl;

        // todo replace with just changing the image 
        if !(_isSourceKnown) then {
            for '_i' from 1 to 3 do {
                private _ctrl2 = call _fnc_createCtrl;
                _ctrl2 setVariable ['ctrl_health_hitMarker_angle',_angle + 90 * _i];
                _ctrl2 setVariable ['ctrl_health_hitMarker_alpha',_alpha];
                _ctrl2 setVariable ['ctrl_health_hitMarker_damageFrom',_damageFrom];
                _hitMarkerArray pushBack _ctrl2;
            };
        };

        // check if the PFH exists, exit if it does
        private _hitHandle = missionNamespace getVariable ['mission_health_hitMarker_handle',nil];
        if (!isNil '_hitHandle') exitWith {};

        
        _hitHandle = [
            {
                _this params ['_args','_handle'];

                // if the hitmarker array is empty, remove the PFH and delete the handle
                private _hitMarkerArray = missionNamespace getVariable ['mission_health_hitmarker_array',[]];
                private _hitMarkerArrayCopy = + _hitMarkerArray;
                if (_hitMarkerArray isEqualTo []) exitWith {
                    [_handle] call CBA_fnc_removePerFrameHandler;
                    missionNamespace setVariable ['mission_health_hitMarker_handle',nil];
                };

                // loop thorugh all the hitmarkers
                for '_i' from 0 to ((count _hitMarkerArray)-1) do {
                    private _isDelete = (call {

                        // use hitmarker array copy so the array positions don't change
                        private _ctrl = _hitMarkerArrayCopy param [_i,controlNull];

                        // if the control doesn't exist delete it from array
                        if (isNull _ctrl) exitWith {true};

                        // get variables from ctrl
                        private _angle = _ctrl getVariable ['ctrl_health_hitMarker_angle',0];
                        private _alpha = _ctrl getVariable ['ctrl_health_hitMarker_alpha',0];
                        private _from = _ctrl getVariable ['ctrl_health_hitMarker_damageFrom',objNull];
                        if (_angle > 359) then {_angle = 0};
                        _ctrl ctrlSetAngle [_angle, 0.5, 0.5];
                        _ctrl ctrlSetTextColor [0.5,1,1,_alpha];

                        // update angle
                        // if damage didn't come from objNull, get the angle to it
                        if !(_from isEqualTo objNull) then {
                            _angle = (player getdir _from) - (getdir player);
                            if (_angle < 0) then {
                                _angle = 360 + _angle;
                            };
                        };
                        
                        // update alpha
                        _alpha = _alpha - ([0.0025,0.005] select (_alpha > 0.3));

                        // if alpha is 0, delete the ctrl
                        if (_alpha < 0) exitWith {
                            ctrlDelete _ctrl;
                            true
                        };
                        
                        // save updates
                        _ctrl setVariable ['ctrl_health_hitMarker_angle',_angle];
                        _ctrl setVariable ['ctrl_health_hitMarker_alpha',_alpha];

                        // return false (doesn't delete)
                        false
                    });

                    // delete the current element from the main array
                    if (_isDelete) then {
                        ctrlDelete (_hitMarkerArray deleteAt _i);
                    };
                };
            }, 0, []
        ] call CBA_fnc_addPerFrameHandler;
        missionNamespace setVariable ['mission_health_hitMarker_handle',_hitHandle];
    };














    // if isBleeding update, then add bleeding
    if (_isBleeding) then {
        _unit setVariable ['unit_health_isBleeding',true,true];

        _unit setVariable ['unit_health_bleedingLastUpdateHUD',nil];
        _unit setVariable ['unit_health_bleedingLastUpdate',nil];
        _unit setVariable ['unit_health_bleedingNextUpdate',nil];

        private _bleedingHandle = _unit getVariable ['unit_health_bleedingHandle',nil];
        if (!isNil '_bleedingHandle') then {
            [_bleedingHandle] call CBA_fnc_removePerFrameHandler;
        };


        private _stopAt = mission_health_fullHP/3;
        _stopAt = (floor (_hp / _stopAt)) * _stopAt;

        //private _stopAt = mission_health_fullHP / 3;
        //_stopAt = call {
        //    if (_hp > _stopAt*2) exitWith {
        //        _stopAt*2
        //    };
        //    if (_hp > _stopAt) exitWith {
        //        _stopAt
        //    };
        //    0
        //};

        _bleedingHandle = [
            {
                _this call health_fnc_bleedingPFH;
            }, 0, [_unit,(_stopAt)]
        ] call CBA_fnc_addPerFrameHandler;
        _unit setVariable ['unit_health_bleedingHandle',_bleedingHandle];
    };

    if (_unit isEqualTo player) then {

        // todo I could set a time here, so the bar looks smooth (ctrlCommit)

        if (_hp > _oldHP) then {
            // todo hp increeased
            [_hp,true] call health_fnc_hpUpdateHUDHeal;
        } else {
            [_hp,true] call health_fnc_hpUpdateHUD;
        };
    };
};

health_fnc_bleedingPFH = {
    _this params ['_args','_handle'];
    _args params ['_unit','_hpStopAt'];

    private _done = call {
        // exit if not alive or not bleeding
        if (!alive _unit || {!(_unit getVariable ['unit_health_isBleeding',false])}) exitWith {
            true
        };

        private _hp = [_unit] call health_fnc_hpGet;


        // bleeding rate per second (next update)
        private _bleedingRate = _unit getVariable ['unit_health_bleedingRate',(missionNamespace getVariable ['mission_health_bleedingRate',50])];

        private _isPlayer = player == _unit;


        // update the hud for player
        if (false) then {

            // last update is to calculate the current hp
            private _bleedingLastUpdateHUD = _unit getVariable ['unit_health_bleedingLastUpdateHUD',CBA_Missiontime];
            private _timeSinceLastUpdateHUD = CBA_Missiontime - _bleedingLastUpdateHUD;

            _hp = (_hp - (_bleedingRate*_timeSinceLastUpdateHUD));

            // update local health
            [_unit,_hp] call health_fnc_hpSet;

            _unit setVariable ['unit_health_bleedingLastUpdateHUD',CBA_Missiontime];
        };

        // next update is when the hp will be broadcasted again
        private _bleedingNextUpdate = _unit getVariable ['unit_health_bleedingNextUpdate',CBA_Missiontime];

        // non broadcast update means local hp update instead
        if (CBA_Missiontime < _bleedingNextUpdate) exitWith {

            // update the hud
            //[_hp,false] call health_fnc_hpUpdateHUD;

            false
        };


        // last update is to calculate the current hp
        private _bleedingLastUpdate = _unit getVariable ['unit_health_bleedingLastUpdate',CBA_Missiontime];
        private _timeSinceLastUpdate = CBA_Missiontime - _bleedingLastUpdate;

        // calculate the loss of hp (because sometimes the each frame handler might take more or less than an exact second)
        _bleedingRate = _bleedingRate * _timeSinceLastUpdate;
        _hp = _hp - _bleedingRate;
        //[_unit,-_bleedingRate,true,false] call health_fnc_hpUpdate;

        // make sure the hp doesn't go past the stopping point
        if (_hp < _hpStopAt) then {

            // find out how much the hp went past the limit (7000 - 6999 = 1)
            private _pastStop = _hpStopAt - _hp;

            // remove the missing hp to the bleeding rate (25 - 1 = 24) (this way the hp will be limited to the limit)
            _bleedingRate = _bleedingrate - _pastStop;
        };

        // update the hp (broadcast)
        [_unit,-_bleedingRate,true,false] call health_fnc_hpUpdate;
        if (_isPlayer) then {
            //[_hp,true] call health_fnc_hpUpdateHUD;
        };

        _unit setVariable ['unit_health_bleedingLastUpdate',CBA_Missiontime];
        _unit setVariable ['unit_health_bleedingNextUpdate',CBA_Missiontime + 1];

        // done is true if hp has reached the stopping point
        _hp < _hpStopAt
    };

    if (_done) then {
        [_handle] call CBA_fnc_removePerFrameHandler;
        _unit setVariable ['unit_health_bleedingLastUpdateHUD',nil];
        _unit setVariable ['unit_health_bleedingLastUpdate',nil];
        _unit setVariable ['unit_health_bleedingNextUpdate',nil];
        if (_unit getVariable ['unit_health_isBleeding',false]) then {
            _unit setVariable ['unit_health_isBleeding',false,true];
        };
    };
};



health_fnc_hpHealAction = {
    // action to heal
    /// [target,caller,cunsumeItem]
    // [player,player,true] call health_fnc_hpHealAction;

    params ['_target','_caller',['_consumeItem',true],['_isCheckOnly',false],['_showErrors',true]];

    // todo only use caller bandages if they are medic and target is not medic
    //private _itemsFrom = ([_caller,_caller] select {
    //    (_x getVariable ['unit_health_meds',(missionNamespace getVariable ['mission_health_meds',0])]) > 0
    //}) param [0,objNull];

    // check if target is alive and needs to be healed
    if (!alive _target) exitWith {
        if (_showErrors) then {
            systemChat (name _caller + ' cannot heal ' + name _target + ': patient is dead.');
        };
        false
    };
    if (!alive _caller) exitWith {
        if (_showErrors) then {
            systemChat (name _caller + ' cannot heal ' + name _target + ': healer is dead.');
        };
        false
    };

    // hp can't be full in order to heal
    private _hp = [_target] call health_fnc_hpGet;
    if (_hp >= mission_health_fullHP) exitWith {

        if (_showErrors) then {
            systemChat (name _caller + ' cannot heal ' + name _target + ': patient is at full health.');
        };
        false
    };

    // same vehicle or in 5 meter radius
    if ((vehicle _caller) != (vehicle _target) && {!(_target inArea [_caller,5,5,0,false,1.5])}) exitWith {

        if (_showErrors) then {
            systemChat (name _caller + ' cannot heal ' + name _target + ': patient is too far.');
        };
        false
    };

    // only allowed to heal when not currently healing *bandage
    private _isHealing = ((_target getVariable ['unit_health_isHealing',0]) > 1);
    if (_isHealing) exitWith {

        if (_showErrors) then {
            systemChat (name _caller + ' cannot heal ' + name _target + ': patient is alreading healing.');
        };
        false
    };



    // determine who gives the items to heal the target
    private _itemsFrom = objNull;

    // check if there's a bandage and the heal can be used
    private _canHeal = call {
        if (!_consumeItem) exitWith {true};

        // check caller meds
        // if the caller doesn't have any, then targets items should be used
        private _callerMeds = _caller getVariable ['unit_health_meds',(missionNamespace getVariable ['mission_health_meds',5])];
        if (_callerMeds > 0) exitWith {
            _itemsFrom = _caller;
            true
        };

        // the targets items should be used if possible
        private _targetMeds = _target getVariable ['unit_health_meds',(missionNamespace getVariable ['mission_health_meds',5])];
        if (_targetMeds > 0) exitWith {
            _itemsFrom = _target;
            true
        };


        // issue, the meds should ONLY be used where they are local
        // the healing should also run locally
        // the checks could run and remote exec the heal once they are used.
        // this could cause 2 players to heal the same target and then a bandage goes missing (both remote exec)
        // there should be a return bandage function which will check if the player is already healing, and if so, then the bandage will be returned to sender.
        false
    };

    // exit if can't heal
    if (!_canHeal) exitWith {

        if (_showErrors) then {
            systemChat (name _caller + ' cannot heal ' + name _target + ': no meds.');
        };
        false
    };

    // is check only is used to check the conditions and return the result
    if (_isCheckOnly) exitWith {
        true
    };

    if (_itemsFrom isEqualTo objNull) exitWith {
        [_target,_caller,objNull] remoteExecCall ['health_fnc_hpHealLocal',_target];
        true
    };

    [_target,_caller,_itemsFrom] remoteExecCall ['health_fnc_hpHealCall',_itemsFrom];
    true
    // update hud
    //if (player == _unit) then {
    //    call health_fnc_hpUpdateHUDItemCount;
    //};

};

health_fnc_medsUpdate = {
    params ['_unit','_value',['_isAdded',false]];

    private _meds = _unit getVariable ['unit_health_meds',0];

    if (_isAdded) then {
        _value = _meds + _value;
    };

    // if meds come from the player, update the med count on hud.
    if (isPlayer _unit && local _unit) then {
        [_value] call health_fnc_hpUpdateHUDItemCount;
    };

    // update meds count
    _unit setVariable ['unit_health_meds',_value, true];
};

health_fnc_hpHealCall = {
    // call for the heal, removes the medical item and remote executes the healing function
    params ['_target','_caller','_itemsFrom'];

    private _meds = _itemsFrom getVariable ['unit_health_meds',(missionNamespace getVariable ['mission_health_meds',5])];
    if (_meds < 1) exitWith {
        (name _caller + ' cannot heal ' + name _target + ': no meds.') remoteExec ['systemChat',_caller];
    };

    _meds = _meds - 1;

    [_itemsFrom,_meds,false] call health_fnc_medsUpdate;

    // remote exec the local heal function
    [_target,_caller,_itemsFrom] remoteExecCall ['health_fnc_hpHealLocal',_target];
};

health_fnc_hpHealLocal = {
    // local function for the heal, runs on the target of the heal only
    params ['_target','_caller',['_itemsFrom',objNull]];

    //private _isFailed = false;

    // isfailed will be true if the healing fails, this means the meds will be returned to the itemsFrom
    private _isFailed = call {

        // check if target is alive and needs to be healed
        if (!alive _target) exitWith {
            (name _caller + ' cannot heal ' + name _target + ': patient is dead.') remoteExec ['systemChat',_caller];
            true
        };
        if (!alive _caller) exitWith {
            (name _caller + ' cannot heal ' + name _target + ': healer is dead.') remoteExec ['systemChat',_caller];

            // items are only returned if items are not from the caller(dead)
            !(_itemsFrom isEqualTo _caller)
        };

        // hp can't be full in order to heal
        private _hp = [_target] call health_fnc_hpGet;
        if (_hp >= mission_health_fullHP) exitWith {
            (name _caller + ' cannot heal ' + name _target + ': patient is at full health.') remoteExec ['systemChat',_caller];
            true
        };


        // only allowed to heal when not currently healing
        private _isHealing = ((_target getVariable ['unit_health_isHealing',0]) > 1);
        if (_isHealing) exitWith {
            (name _caller + ' cannot heal ' + name _target + ': patient is alreading healing.') remoteExec ['systemChat',_caller];
            true
        };

        // same vehicle or in 5 meter radius
        if ((vehicle _caller) != (vehicle _target) && {!(_target inArea [_caller,5,5,0,false,1.5])}) exitWith {
            (name _caller + ' cannot heal ' + name _target + ': patient is too far.') remoteExec ['systemChat',_caller];
            true
        };

        [_target,2] call health_fnc_hpHeal;
        false
    };

    // if it didn't fail or the items came from nowehere or the items came from a dead guy, exit
    if (!_isFailed || {isNull _itemsFrom || !alive _itemsFrom}) exitWith {
        //systemChat 'cannot return items';
    };

    // return the items
    [_target,_caller,_itemsFrom] remoteExec ['health_fnc_hpHealMedsReturn',_itemsFrom];
};

health_fnc_hpHealMedsReturn = {
    params ['_target','_caller','_itemsFrom'];

    private _meds = _itemsFrom getVariable ['unit_health_meds',(missionNamespace getVariable ['mission_health_meds',5])];
    systemChat (name _caller + ' cannot heal ' + name _target + ': meds returned.');

    _meds = _meds + 1;

    [_itemsFrom,_meds,false] call health_fnc_medsUpdate;
};


health_fnc_hpUpdateHUDItemCount = {
    params ['_value'];

    private _display = uiNamespace getVariable ["health_rsc_hud",displayNull];
    if (isNull _display) exitWith {};
    private _ctrl = (_display displayCtrl 6201);
    _ctrl ctrlSetText ('x'+ str _value);
};

health_fnc_hpGet = {
    params ['_unit'];
    _unit getVariable ['unit_health_hp',mission_health_fullHP];
};
health_fnc_hpSet = {
    params ['_unit','_hp'];

    // only run on local units
    if (!local _unit) exitWith {};

    // if no hp given, reset to mission max hp
    if (isNil '_hp') then {
        _hp = mission_health_fullHP;
    };
    _unit setVariable ['unit_health_hp',_hp,true];
};


health_fnc_hpHeal = {
    // heals unit over time
    // player, state 3(full heal), 300 per second
    // [player,3,300] call health_fnc_hpHeal;
    disableSerialization;
    params ['_unit',['_healingState',2],['_healingRate',nil]];

    if (!local _unit) exitWith {};
    private _hp = [_unit] call health_fnc_hpGet;
    private _oldHP = _hp;

    // determine healing rate
    if (isNil '_healingRate') then {
        _healingRate = call {
            if (_healingState == 1) exitWith {
                (missionNamespace getVariable ['mission_health_healingRate',300])/4
            };
            if (_healingState == 2) exitWith {
                (missionNamespace getVariable ['mission_health_healingRate',300])
            };
            if (_healingState == 3) exitWith {
                (missionNamespace getVariable ['mission_health_healingRate',300])*2
            };

            // no heal
            0
        };
    };


    // healing has 3 states
    // 0 - not healing
    // 1 - bleeding stopped (very slow)
    // 2 - bandaged (1 block)
    // 3 - full heal (all blocks)
    _unit setVariable ['unit_health_isHealing',_healingState,true];

    // stop bleeding
    _unit setVariable ['unit_health_isBleeding',false,true];

    _unit setVariable ['unit_health_healingLastUpdateHUD',nil];
    _unit setVariable ['unit_health_healingLastUpdate',nil];
    _unit setVariable ['unit_health_healingNextUpdate',nil];

    private _healingHandle = _unit getVariable ['unit_health_healingHandle',nil];
    if (!isNil '_healingHandle') then {
        [_healingHandle] call CBA_fnc_removePerFrameHandler;
    };

    // stop at full hp
    private _stopAt = mission_health_fullHP;

    // if limited, then only heal until the next bar
    if (!(_healingState isEqualTo 3)) then {
        private _third = mission_health_fullHP/3;
        _stopAt = (ceil (_hp / _third)) * _third;


        // if the block is almost full, fill it to the next one
        if ((_stopAt - _hp) < _third / 10) then {

            // make sure it doesn't go past full hp
            _stopAt = (_stopAt + _third) min mission_health_fullHP;
        };
    };

    _healingHandle = [
        {
            _this call health_fnc_healingPFH;
        }, 0, [_unit,_stopAt,_healingRate]
    ] call CBA_fnc_addPerFrameHandler;
    _unit setVariable ['unit_health_healingHandle',_healingHandle];
};

health_fnc_healingPFH = {
    _this params ['_args','_handle'];
    _args params ['_unit','_hpStopAt','_healingRate'];

    // todo healing rate modifier per unit and per mission

    private _done = call {

        // exit if not alive or bleeding (healing stops if bleeding) or healing has stopped
        if (!alive _unit || {(_unit getVariable ['unit_health_isBleeding',false]) || {(_unit getVariable ['unit_health_isHealing',0]) < 1}}) exitWith {
            true
        };

        private _hp = [_unit] call health_fnc_hpGet;

        private _isPlayer = player == _unit;


        // next update is when the hp will be broadcasted again
        private _healingNextUpdate = _unit getVariable ['unit_health_healingNextUpdate',CBA_Missiontime];

        // non broadcast update means local hp update instead
        if (CBA_Missiontime < _healingNextUpdate) exitWith {

            // todo maybe simulate smooth hp bar because healing rate is a lot higher and it will look chunky

            // update the hud
            //[_hp,false] call health_fnc_hpUpdateHUD;

            false
        };


        // last update is to calculate the current hp
        private _healingLastUpdate = _unit getVariable ['unit_health_healingLastUpdate',CBA_Missiontime];
        private _timeSinceLastUpdate = CBA_Missiontime - _healingLastUpdate;

        // calculate the increase in hp (because sometimes the each frame handler might take more or less than an exact second)
        _healingRate = _healingRate * _timeSinceLastUpdate;
        _hp = _hp + _healingRate;


        // make sure the hp doesn't go past the stopping point
        if (_hp > _hpStopAt) then {


            // find out how much the hp went past the limit (7010 - 7000 = 10)
            private _pastStop = _hp - _hpStopAt;

            // remove the missing hp to the healing rate (250 - 10 = 240) (this way the hp will be limited to the limit)
            _healingRate = _healingRate - _pastStop;
        };


        // update the hp (broadcast)
        [_unit,_healingRate,true,false] call health_fnc_hpUpdate;

        _unit setVariable ['unit_health_healingLastUpdate',CBA_Missiontime];
        _unit setVariable ['unit_health_healingNextUpdate',CBA_Missiontime + 1];

        // done is true if hp has passed the stopping point
        _hp > _hpStopAt
    };

    if (_done) then {
        [_handle] call CBA_fnc_removePerFrameHandler;
        _unit setVariable ['unit_health_healingLastUpdate',nil];
        _unit setVariable ['unit_health_healingNextUpdate',nil];
        if (_unit getVariable ['unit_health_isHealing',0] > 0) then {
            _unit setVariable ['unit_health_isHealing',0,true];
        };
    };
};

health_fnc_hpUpdateHUD = {
    params ['_hp',['_makeRed',false]];

    disableSerialization;
    private _display = uiNamespace getVariable ["health_rsc_hud",displayNull];
    if (isNull _display) exitWith {};
    private _ctrl1 = (_display displayCtrl 6001);
    private _ctrl2 = (_display displayCtrl 6002);
    private _ctrl3 = (_display displayCtrl 6003);

    private _barMax = missionNamespace getVariable 'mission_health_hpBarMax';
    if (isNil '_barMax') then {
        _barMax = (ctrlPosition _ctrl1)#2;
        missionNamespace setVariable ['mission_health_hpBarMax',_barMax];
    };

    private _bar1 = 1;
    private _bar2 = 1;
    private _bar3 = 1;

    private _hpPercent = _hp / (mission_health_fullHP / 100);


    call {
        if (_hpPercent > 66) exitWith {
            _bar3 = (_hpPercent - 66)/33;
        };
        _bar3 = 0;
        if (_hpPercent > 33) exitWith {
            _bar2 = (_hpPercent - 33)/33;
        };
        _bar2 = 0;
        _bar1 = _hpPercent / 33;
    };

    private _nil = {
        _x params ['_ctrl','_value'];
        private _pos = ctrlPosition _ctrl;
        private _w = _pos # 2;
        private _newW = (_barMax * _value);

        // check if the ctrl should be updated
        if (_w != _newW) then {
            _pos set [2,_newW];
            _ctrl ctrlSetPosition _pos;
            _ctrl ctrlCommit 0;

            if (_makeRed) then {
                private _handle = _ctrl getVariable ['ctrl_health_colorHandle',nil];
                if (!isNil '_handle') then {
                    [_handle] call CBA_fnc_removePerFrameHandler;
                    _ctrl setVariable ['ctrl_health_lastUpdate',nil];
                    _ctrl setVariable ['ctrl_health_color',nil];
                };


                _handle = [
                    {
                        _this params ['_args','_handle'];
                        _args params ['_ctrl'];
                        private _color = _ctrl getVariable ['ctrl_health_color',0];
                        private _lastUpdate = _ctrl getVariable ['ctrl_health_lastUpdate',CBA_Missiontime];
                        private _timeSinceLastUpdate = CBA_Missiontime - _lastUpdate;

                        //private _colorArr = [0.8,0.8,0.8,1];
                        _color = (_color + (0.8 * _timeSinceLastUpdate))min 0.8;

                        private _colorArr = [0.8,_color,_color,1];
                        _ctrl ctrlSetBackgroundColor _colorArr;


                        _ctrl setVariable ['ctrl_health_lastUpdate',CBA_Missiontime];
                        _ctrl setVariable ['ctrl_health_color',_color];

                        if (_color == 0.8) then {
                            [_handle] call CBA_fnc_removePerFrameHandler;
                        };

                    }, 0, [_ctrl]
                ] call CBA_fnc_addPerFrameHandler;
                _ctrl setVariable ['ctrl_health_colorHandle',_handle];
            };
        };
        false
    } count [[_ctrl1,_bar1],[_ctrl2,_bar2],[_ctrl3,_bar3]];
};
health_fnc_hpUpdateHUDHeal = {
    params ['_hp',['_makeGreen',true]];

    disableSerialization;
    private _display = uiNamespace getVariable ["health_rsc_hud",displayNull];
    if (isNull _display) exitWith {};
    private _ctrl1 = (_display displayCtrl 6001);
    private _ctrl2 = (_display displayCtrl 6002);
    private _ctrl3 = (_display displayCtrl 6003);

    private _barMax = missionNamespace getVariable 'mission_health_hpBarMax';
    if (isNil '_barMax') then {
        _barMax = (ctrlPosition _ctrl1)#2;
        missionNamespace setVariable ['mission_health_hpBarMax',_barMax];
    };

    private _bar1 = 1;
    private _bar2 = 1;
    private _bar3 = 1;

    private _hpPercent = _hp / (mission_health_fullHP / 100);

    call {
        if (_hpPercent > 66) exitWith {
            _bar3 = (_hpPercent - 66)/33;
        };
        _bar3 = 0;
        if (_hpPercent > 33) exitWith {
            _bar2 = (_hpPercent - 33)/33;
        };
        _bar2 = 0;
        _bar1 = _hpPercent / 33;
    };

    private _nil = {
        _x params ['_ctrl','_value'];
        private _pos = ctrlPosition _ctrl;
        private _w = _pos # 2;
        private _newW = (_barMax * _value);

        // check if the ctrl should be updated
        if (_w != _newW) then {
            _pos set [2,_newW];
            _ctrl ctrlSetPosition _pos;
            _ctrl ctrlCommit 0;

            if (_makeGreen) then {
                private _handle = _ctrl getVariable ['ctrl_health_colorHandle',nil];
                if (!isNil '_handle') then {
                    [_handle] call CBA_fnc_removePerFrameHandler;
                    _ctrl setVariable ['ctrl_health_lastUpdate',nil];
                    _ctrl setVariable ['ctrl_health_color',nil];
                };


                _handle = [
                    {
                        _this params ['_args','_handle'];
                        _args params ['_ctrl'];
                        private _color = _ctrl getVariable ['ctrl_health_color',0];
                        private _lastUpdate = _ctrl getVariable ['ctrl_health_lastUpdate',CBA_Missiontime];
                        private _timeSinceLastUpdate = CBA_Missiontime - _lastUpdate;

                        //private _colorArr = [0.8,0.8,0.8,1];
                        _color = (_color + (0.8 * _timeSinceLastUpdate))min 0.8;

                        private _colorArr = [_color,0.8,_color,1];
                        _ctrl ctrlSetBackgroundColor _colorArr;


                        _ctrl setVariable ['ctrl_health_lastUpdate',CBA_Missiontime];
                        _ctrl setVariable ['ctrl_health_color',_color];

                        if (_color == 0.8) then {
                            [_handle] call CBA_fnc_removePerFrameHandler;
                        };

                    }, 0, [_ctrl]
                ] call CBA_fnc_addPerFrameHandler;
                _ctrl setVariable ['ctrl_health_colorHandle',_handle];
            };
        };
        false
    } count [[_ctrl1,_bar1],[_ctrl2,_bar2],[_ctrl3,_bar3]];
};

health_fnc_apUpdateHUD = {
    // updates the ap on hud to a certain value
    // [5,false,true] call health_fnc_apUpdateHUD;
    params ['_ap',['_isHelmet',false],['_makeBlue',true]];

    disableSerialization;
    private _display = uiNamespace getVariable ["health_rsc_hud",displayNull];
    if (isNull _display) exitWith {};
    private _ctrl1 = (_display displayCtrl 6005);

    private _apPercent = _ap / (mission_health_fullAP / 100);

    if (_isHelmet) then {
        _ctrl1 = (_display displayCtrl 6006);
        _apPercent = _ap / (mission_health_fullAPH / 100);
    };

    private _barMax = _ctrl1 getVariable 'mission_health_apBarMax';
    if (isNil '_barMax') then {
        _barMax = (ctrlPosition _ctrl1)#2;
        _ctrl1 setVariable ['mission_health_apBarMax',_barMax];
    };

    _bar1 = _apPercent / 100;


    private _nil = {
        _x params ['_ctrl','_value'];
        private _pos = ctrlPosition _ctrl;
        private _w = _pos # 2;
        private _newW = (_barMax * _value);

        // check if the ctrl should be updated
        if (_w != _newW) then {
            _pos set [2,_newW];
            _ctrl ctrlSetPosition _pos;
            _ctrl ctrlCommit 0;

            if (_makeBlue) then {
                private _handle = _ctrl getVariable ['ctrl_health_colorHandle',nil];
                if (!isNil '_handle') then {
                    [_handle] call CBA_fnc_removePerFrameHandler;
                    _ctrl setVariable ['ctrl_health_lastUpdate',nil];
                    _ctrl setVariable ['ctrl_health_color',nil];
                };


                _handle = [
                    {
                        _this params ['_args','_handle'];
                        _args params ['_ctrl'];
                        private _color = _ctrl getVariable ['ctrl_health_color',0];
                        private _lastUpdate = _ctrl getVariable ['ctrl_health_lastUpdate',CBA_Missiontime];
                        private _timeSinceLastUpdate = CBA_Missiontime - _lastUpdate;

                        //private _colorArr = [0.8,0.8,0.8,1];
                        _color = (_color + (0.8 * _timeSinceLastUpdate))min 0.8;

                        private _colorArr = [_color,_color,0.8,1];
                        _ctrl ctrlSetBackgroundColor _colorArr;


                        _ctrl setVariable ['ctrl_health_lastUpdate',CBA_Missiontime];
                        _ctrl setVariable ['ctrl_health_color',_color];

                        if (_color == 0.8) then {
                            [_handle] call CBA_fnc_removePerFrameHandler;
                        };

                    }, 0, [_ctrl]
                ] call CBA_fnc_addPerFrameHandler;
                _ctrl setVariable ['ctrl_health_colorHandle',_handle];
            };
        };
        false
    } count [[_ctrl1,_bar1]];
};

health_fnc_apUpdate = {
    // Update the AP points
    // max 6 Armor max 3 helmet
    // [player, -3,true,true] call health_fnc_apUpdate;
    // removes 3 points from player helmet
    params ['_unit','_value','_isAdded',['_isHelmet',false]];

    if (!local _unit) exitWith {};

    // select armor or helmet ap
    private _varName = ['unit_health_ap','unit_health_aph'] select _isHelmet;
    private _ap = _unit getVariable [_varName,0];

    // limit the value (9 for armor 0 for helmet)
    _value = (_value max 0) min ([9,0] select _isHelmet);
    

    if (_isAdded) then {
        _ap = _ap + _value;
    } else {
        _ap = _value;
    };

    _unit setVariable [_varName,_ap,true];

    if (_unit isEqualTo player) then {

        // update hud
        [_ap,_isHelmet,true] call health_fnc_apUpdateHUD;
    };
};

// todo |   this EH ^^^ must be added on all units for all clients and server/hc
// todo |   I need a function to apply the damage, If the unit is killed, he should get setDamage 1 immediately
// todo |   I need to remoteExec the damage to the client to change the hud and show damage direction
// todo |   Armor and armor modifier for damage, I'll probably determine a armor modifier and head modifier and then remove it from the normal modifier in the normal modifier call
// todo |   custom damage amounts for rifles/smgs/pistols *with modifiers for different parts/armor
// todo |

// todo https://github.com/acemod/ACE3/blob/master/addons/advanced_throwing/functions/fnc_throw.sqf#L75
// todo throw (seems to work on the onFired EH)


health_fnc_onFired = {
    params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

    private _velocity = velocity _projectile;
    _projectile setVelocity (_velocity vectorMultiply 3);

    private _varName = str _projectile;
    health_firedNamespace setVariable [_varName,[_unit,_weapon,_magazine,(velocity _projectile)]];
    health_firedNamespace_variables pushBack (_varName);

    // check if the namespace should be cleaned
    if ((missionNamespace getVariable ['health_firedNamespace_nextClean',CBA_Missiontime])> CBA_Missiontime) exitWith {};
    call {

        // set time for next clean
        missionNamespace setVariable ['health_firedNamespace_nextClean',CBA_Missiontime + 1]; // todo bigger delay

        private _variableCount = count (health_firedNamespace_variables);

        // only clean if more than 300 variables
        if (_variableCount < 300) exitWith {};

        // delete amt will be 100 less than the total amount
        private _deleteAmount = _variableCount - 100;


        // loop through the first 100 and set them to nil in the firedNamespace
        for '_i' from 0 to _deleteAmount do {
            health_firedNamespace setVariable [health_firedNamespace_variables # _i,nil];
        };

        // delete the oones that were set to nil from variables array
        health_firedNamespace_variables deleteRange [0,_deleteAmount+1];
    };
};

// create projectile namespace
private _firedNamespace = createLocation ['Invisible',[-5000,-5000],0,0];
missionNamespace setVariable ['health_firedNamespace',_firedNamespace];
health_firedNamespace_variables = [];

// create weapon data namespace
private _gunsDamagesNamespace = createLocation ['Invisible',[-5000,-5000],0,0];
missionNamespace setVariable ['health_gunsDamagesNamespace',_gunsDamagesNamespace];

{
    _x params ['_gunName','_gunDamage'];
    health_gunsDamagesNamespace setVariable [(toLower _gunName),_gunDamage];
    false
} count [
    ['srifle_LRR',8000],
    ['srifle_DMR_06_camo',3500],
    ['arifle_MX',3200],
    ['arifle_Katiba',3200],
    ['arifle_CTAR',3000],
    ['arifle_TRG',2500],
    ['arifle_Mk20',2500],
    ['arifle_SPAR',2500],
    ['hgun_ACPC2',2700],
    ['hgun_Pistol_heavy_02',3250],
    ['hgun_P07',2100],
    ['hgun_Rook40',1900],
    ['hgun_Pistol_heavy_01',2500],
    ['hgun_Pistol_01',2200],
    ['hgun_PDW2000',1700],
    ['SMG_05',1900],
    ['SMG_01',2100],
    ['SMG_02',1900],
    ['arifle_AKS',2500],
    ['arifle_AKM',3000],
    ['srifle_GM6',9000],
    ['LMG_Mk200',2750],
    ['arifle_CTARS_blk',2600],
    ['LMG_Zafir',3300],
    ['handGrenade',1700],
    ['ACE_M84',200],
    ['ace_frag_tiny_hd',800]
];

// save spark sound
private _soundPath = [(str missionConfigFile), 0, -15] call BIS_fnc_trimString;
mission_health_fxSparkSound = _soundPath + "plugins\health\files\metal_3_01.ogg";
missionNamespace setVariable ['ace_hitReactions_minDamageToTrigger',-1];


if (!hasInterface) exitWith {};

// add meds
// todo get and set functions


 // create hud
"rscLayer_health_hud" cutRsc ["health_rsc_hud", "PLAIN"];
private _display = uiNamespace getVariable "health_rsc_hud";

// meds
[player,5,false] call health_fnc_medsUpdate;

// armor
[player,mission_health_fullAP,false,false] call health_fnc_apUpdate;
// helmet
//[player,mission_health_fullAP,false,true] call health_fnc_apUpdate;

// heal action
//player addAction ["Heal Self", {[player,player,true] call health_fnc_hpHealAction}];


// stop bleeding (free)
// heal (cost 1)
// heal other (cost 1)




_healOther = [
	"health_action_healOther",
	"Heal",
	"",
	{
        private _name = name _target;
		[
			3,
			[_target],
			{
				_target = ((_this param [0]) param [0,objNull]);


                // succeeded
                [_target,player,true,false,true] call health_fnc_hpHealAction;
			},
			{
				(_this#0) params ['_target','_itemFrom','_item'];

                // failed
			},
			'Healing ' + _name, {
				_target = ((_this param [0]) param [0,objNull]);

                // condition
				//(_target inArea [player,5,5,0,false])

                [_target,player,true,true,true] call health_fnc_hpHealAction;
			}
		] call ace_common_fnc_progressBar;

        // anim
        // todo check
		[player, 'AinvPknlMstpSlayWnonDnon_medic'] call ace_common_fnc_doAnimation;
	},
	{
        // condition
		//private _canBeRevived = _target getVariable ['unit_revive_canBeRevived',false];
		//_canBeRevived && (isNull (objectParent _target))
        [_target,player,true,true,false] call health_fnc_hpHealAction;
	}
] call ace_interact_menu_fnc_createAction;
["CAManBase", 0, ["ACE_MainActions"], _healOther, true] call ace_interact_menu_fnc_addActionToClass;

// todo test
['CAManBase', 1, ["ACE_SelfActions"], _healOther,true] call ace_interact_menu_fnc_addActionToClass;




_stopBleeding = [
	"health_action_stopBleeding",
	"Stop Bleeding",
	"",
	{
        private _name = name _target;
		[
			5,
			[_target],
			{
				_target = ((_this param [0]) param [0,objNull]);

                //_target setVariable ['unit_health_isBleeding',false];
                [player,1] call health_fnc_hpHeal;
			},
			{
				(_this#0) params ['_target','_itemFrom','_item'];

                // failed
			},
			'Stopping the bleeding', {
				_target = ((_this param [0]) param [0,objNull]);

                // condition
				//(_target inArea [player,5,5,0,false])

                _target getVariable ['unit_health_isBleeding',false]
			}
		] call ace_common_fnc_progressBar;

        // anim
        // todo check
		[player, 'AinvPknlMstpSlayWnonDnon_medic'] call ace_common_fnc_doAnimation;
	},
	{
        // condition
		//private _canBeRevived = _target getVariable ['unit_revive_canBeRevived',false];
		//_canBeRevived && (isNull (objectParent _target))
        _target getVariable ['unit_health_isBleeding',false]
	}
] call ace_interact_menu_fnc_createAction;
['CAManBase', 1, ["ACE_SelfActions"], _stopBleeding,true] call ace_interact_menu_fnc_addActionToClass;








["ace_unconscious", {
    params [["_unit", objNull],["_state", false]];
    if(_unit != player) exitWith {};
    if (!_state) exitWith {};
    private _display = uiNamespace getvariable ["ace_common_dlgDisableMouse",displayNull];
    systemChat str _display;
    ['unconscious',false] call ace_common_fnc_setDisableUserInputStatus;

    systemChat '1';
    private _unconHandle = _unit getVariable ['unit_health_unconHandle',nil];
    if (!isNil '_unconHandle') then {
        [_unconHandle] call CBA_fnc_removePerFrameHandler;
    };

    _unconHandle = [
        {
            _this call {
                _this params ['_args','_handle'];
                _args params ['_unit'];

                private _isUnconscious = _unit getVariable ['unit_health_isUnconscious',true];


                if !(_isUnconscious) exitWith {
                    [_handle] call CBA_fnc_removePerFrameHandler;
                    _unit setVariable ['unit_health_unconHandle',nil];
                };

                if !('unconscious' in ace_common_DISABLE_USER_INPUT_COLLECTION) exitWith {};
                ['unconscious',false] call ace_common_fnc_setDisableUserInputStatus;

            };
        }, 0, [_unit]
    ] call CBA_fnc_addPerFrameHandler;
    _unit setVariable ['unit_health_unconHandle',_unconHandle];
}] call CBA_fnc_addEventHandler;

if (hasInterface) then {
    // remove ace actions
    _at = ace_interact_menu_ActSelfNamespace getvariable (typeOf player);
    {
        if ((toLower (_x#0#0)) in ['medical','medical_menu']) then {
            _at#0#1 deleteAt _forEachIndex;
        };
    }forEach _at#0#1;
};






if (true) exitWith {};
/*

mission_zeus_group = createGroup sideLogic;
_zeus = mission_zeus_group createUnit ["ModuleCurator_F", [0,0,0], [], 0, "NONE"];
//this setvariable ['BIS_fnc_initModules_disableAutoActivation', false, true];

"ModuleCurator_F" createUnit [[0,0,0], (mission_zeus_group), "this setvariable ['BIS_fnc_initModules_disableAutoActivation', false, true]; ten_zeus=this"];
player assignCurator (ten_zeus);





//--- unconscious test
health_fnc_onAnimChange = {
    params ["_unit","_anim"];
    systemChat str _this;
    if (((toLower _anim) find 'unconscious') == -1) exitWith {};

    private _isUnconscious = _unit getVariable ['unit_health_isUnconscious',true];
    if (_isUnconscious) then {
        systemChat '1';
        _unit setUnconscious false;
        private _unconHandle = _unit getVariable ['unit_health_unconHandle',nil];
        if (!isNil '_unconHandle') then {
            [_unconHandle] call CBA_fnc_removePerFrameHandler;
        };

        _unconHandle = [
            {
                _this call {
                    _this params ['_args','_handle'];
                    _args params ['_unit'];

                    private _isUnconscious = _unit getVariable ['unit_health_isUnconscious',true];


                    if !(_isUnconscious) exitWith {
                        [_handle] call CBA_fnc_removePerFrameHandler;
                        _unit setVariable ['unit_health_unconHandle',nil];
                    };

                    private _unconTick = _unit getVariable ['unit_health_unconTick',false];
                    _unit setUnconscious _unconTick;
                    _unit setVariable ['unit_health_unconTick',!_unconTick];

                };
            }, 0, [_unit]
        ] call CBA_fnc_addPerFrameHandler;
        _unit setVariable ['unit_health_unconHandle',_unconHandle];

    } else {
        _unit setUnconscious false;
    };
};
//player addEventHandler ["AnimChanged", {_this call health_fnc_onAnimChange;}];



// backpack test

// create units
private _group = createGroup west;
private _pos = player getPos [50,(getDir player)];
_pos set [0,(_pos#0 -10)];
_pos set [1,(_pos#1 -10)];
for '_i' from 0 to 10 do {
    for '_j' from 0 to 10 do {
        private _unit = _group createUnit ["B_RangeMaster_F", [(_pos#0+_i*2),(_pos#1+_j*2),0], [], 0, "CAN_COLLIDE"];
        _unit disableAI 'MOVE';
    };
};
[_group,2]remoteExec ['setGroupOwner',2];
{_x addWeapon "arifle_MX_ACO_pointer_F";false} count allunits;
{_x addBackpack 'B_Kitbag_rgr_AAR';false}count allunits;
{removeBackpack _x;removeAllPrimaryWeaponItems _x;false}count allunits;

function ten_dl2 (url) {
    console.log(url);
    window.location.replace(url);
};
//setTimeout(ten_dl($(this).attr('href')),ten_lastTime);


//--- click
// get all links
var ten_arr = [];
var myLinks2 = document.getElementsByClassName('postContainer replyContainer noFile');

var myLinks = document.getElementsByClassName('postContainer replyContainer');
ten_arr = ten_arr.concat(Object.values(myLinks));
ten_arr = ten_arr.concat(Object.values(myLinks2));

//
var ten_str = '';
for (i = 0;i < ten_arr.length; i++) {
    var i_obj = ten_arr[i];
    var i_text = i_obj.innerHTML.replace(/<(?:.|\n)*?>/gm, '').split('&gt;');
    i_text = i_text[i_text.length -1];
    i_split = i_text.split(' ');
    if (i_split[12] === "wait78" || i_split[12] === "wait" || i_split[13] === "wait78") {
        i_split = i_split.splice(15);
    };
    if (typeof i_text === 'string' && ((i_split.length) > 6)) {
        var i_str = i_obj.id.slice(2);
        ten_str = ten_str + '>>' + i_str + '\n';
    } else {
        //console.log('REMOVE:' + i_obj.id.slice(2) + ' TXT:' + i_text);

    };
};
console.log(ten_str);
//&gt;

//document.getElementsByClassName('postContainer replyContainer noFile')[0].outerHTML
    //var i_text = i_obj.outerHTML.split('<br>')[2];

const copyToClipboard = str => {
    const el = document.createElement('textarea');
    el.value = str;
    el.setAttribute('readonly', '');
    el.style.position = 'absolute';
    el.style.left = '-9999px';
    document.body.appendChild(el);
    el.select();
    document.execCommand('copy');
    document.body.removeChild(el);
};


var ten_nextTime = 0;

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
};

async function ten_dl (arr) {
    console.log(arr);
    for (i = 0; i < arr.length; i++) {
        await sleep(500);
                
        window.location.replace(arr[i]);
    };
};

$(document).ready(function() {
    var ten_lastTime = 0;
    var ten_arr = [];
	var doc = $(document).find('a');
	doc.each(function(){
		if($(this).text() == 'DL') {

            ten_arr.push($(this).attr('href'));
		};
	});

    ten_dl(ten_arr);
});*/
/*
```sqf

private _unit = _x;
private _pos = player worldToModelVisual (getPosVisual _unit);

private _maxX = safeZoneW/40; //width of the ctrl
private _maxY = safeZoneH/25; //height of the ctrl
private _centerX = (safeZoneX+safeZoneW)/2 + (_maxX /2); // center of the main ctrl
private _centerY = (safeZoneY+safeZoneH)/2 + (_maxY /2); // center of the main ctrl

private _startX = _centerX - (_maxX /2);
private _startY = _centerY - (_maxY /2);
private _endX = _centerX + (_maxX /2);
private _endY = _centerY + (_maxY /2);

private _x = linearConversion [-30,30,_pos#0,_startX,_endX];
private _y = linearConversion [-30,30,_pos#1,_starty,_endy];

private _ctrlPos = [_x,_y]; // position inside
```
*/

/*
//v2
```sqf

private _unit = _x;
private _unitID = _unit getVariable ['unit_diw_dui_id',nil];
if (isNil '_unitID') then {
    _unitID = (missionNamespace getVariable ['mission_diw_dui_lastID',0])+1;
    missionNamespace setVariable ['mission_diw_dui_lastID',_unitID];
    _unit setVariable ['unit_diw_dui_id',_unitID];
};

private _pos = player worldToModelVisual (getPosVisual _unit);

// todo direction in relation to player direction??
private _dir = getDir _unit;

private _w = safeZoneW/40; //width of the ctrl
private _h = safeZoneH/25; //height of the ctrl

private _x = linearConversion [-30,30,_pos#0,0,_w];
private _y = linearConversion [-30,30,_pos#1,0,_h,false];

private _ctrlPos = [_x,_y]; // position inside the ctrlGroup

disableSerialization;
private _display = (findDisplay 69696969);
private _ctrlGrp = _display displayCtrl 69696969;

private _ctrl = _ctrlGrp getVariable [('ctrl_diw_unit_' + str _unitID),nil];
if (isNil '_ctrl') then {
    _ctrl = _display ctrlCreate ['RscPicture',-1,_ctrlGrp];

    // todo setText (for picture)
    //

    _ctrlGrp setVariable [('ctrl_diw_unit_' + str _unitID),_ctrl];
};

_ctrl ctrlSetPosition _ctrlPos;
_ctrl ctrlSetAngle [_dir,0.5,0.5,false];
_ctrl ctrlCommit 0;

// todo set fade if further alway
//private _fade = [25,35,abs(_pos#0 max _pos#1),1,0,true];
//_ctrl ctrlSetTextColor [1,1,1,(_fade)];

```*/