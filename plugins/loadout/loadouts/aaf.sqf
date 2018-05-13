/* ----------------------------------------------------------------------------
Name: Nato

Description:
	Vanilla based default nato loadout

Author:
	nigel
---------------------------------------------------------------------------- */
/*
--- THIS IS ONLY FOR TEMPLATE ---
// Take the array from this and replace with _faces
FACES

_faceGREEK = ["GreekHead_A3_01","GreekHead_A3_02","GreekHead_A3_03","GreekHead_A3_04","GreekHead_A3_05","GreekHead_A3_06","GreekHead_A3_07","GreekHead_A3_08","GreekHead_A3_09"];
_faceWHITE = ["WhiteHead_02","WhiteHead_03","WhiteHead_04","WhiteHead_05","WhiteHead_06","WhiteHead_07","WhiteHead_08","WhiteHead_09","WhiteHead_10","WhiteHead_11","WhiteHead_12","WhiteHead_13","WhiteHead_14","WhiteHead_15"];
_faceBLACK = ["AfricanHead_02","AfricanHead_01","AfricanHead_03"];
_faceASIAN = ["AsianHead_A3_02","AsianHead_A3_01","AsianHead_A3_02","AsianHead_A3_03", "AsianHead_A3_04", "AsianHead_A3_05", "AsianHead_A3_07", "AsianHead_A3_06"];
_facePERSIAN = ["PersianHead_A3_01","PersianHead_A3_02","PersianHead_A3_03"];
_faceTANOAN = ["TanoanHead_A3_01", "TanoanHead_A3_02", "TanoanHead_A3_03", "TanoanHead_A3_04", "TanoanHead_A3_05", "TanoanHead_A3_06", "TanoanHead_A3_07", "TanoanHead_A3_08"];

VOICES
_voiceALTIAN = ["male01gre","male02gre","male03gre"];
_voiceAMERICAN = ["male01eng","male02eng","male03eng"];
_voiceBRITISH = ["male01engb","male02engb","male03engb"];
_voiceCHINESE = ["male01chi", "male02chi", "male03chi"];
_voiceFARSI = ["male01per","male02per","male03per"];
_voiceFRENCH = ["male01fre", "male02fre", "male03fre"];
_voiceFRENCHENGLISH = ["male01engfre", "male02engfre"];

// Requires RHS
_voiceRUSSIAN = ["rhs_male01rus","rhs_male02rus","rhs_male03rus"];
_voiceCZECH = ["rhs_male01cz", "rhs_male02cz", "rhs_male03cz"];

--- THIS IS ONLY FOR TEMPLATE ---
*/

// identity
_faces = ["GreekHead_A3_01","GreekHead_A3_02","GreekHead_A3_03"];
_voices = ["male01gre","male02gre","male03gre"];

// Which side radios to get?
#define RADIOSIDE			resistance

#define RIFLE				"arifle_Mk20_F"
#define RIFLEMAG			"30Rnd_556x45_Stanag"
#define RIFLEMAG2			"30Rnd_556x45_Stanag_Tracer_Yellow"
#define CARBINE				"arifle_Mk20C_F"
#define CARBINEMAG			RIFLEMAG
#define CARBINEMAG2			RIFLEMAG2
#define RIFLEGL				"arifle_Mk20_GL_F"
#define RIFLEGLMAG			RIFLEMAG
#define RIFLEGLMAG2			RIFLEMAG2
#define RIFLEGL40MM			"1Rnd_HE_Grenade_shell"

#define LMG					"LMG_Mk200_F"
#define LMGMAG				"200Rnd_65x39_cased_Box"
#define LMGMAG2				"200Rnd_65x39_cased_Box_Tracer"
#define MMG					LMG
#define MMGMAG				LMGMAG
#define MMGMAG2				LMGMAG2

#define LAT					"launch_NLAW_F"
#define LATMAG				""
#define LATMAG2				""
#define MAT					"launch_I_Titan_short_F"
#define MATMAG				"Titan_AT"
#define MATMAG2				"Titan_AT"
#define AA					"launch_B_Titan_F"
#define AAMAG				"Titan_AA"
#define AAMAG2				"Titan_AA"

#define MARKSMANRIFLE		"srifle_EBR_F"
#define MARKSMANRIFLEMAG	"20Rnd_762x51_Mag"
#define MARKSMANRIFLEMAG2	"ACE_20Rnd_762x51_Mag_Tracer"
#define MARKSMAN_SCOPE		"optic_DMS"
#define MARKSMAN_BIPOD		"bipod_01_F_snd"
#define SNIPER				"srifle_LRR_F"
#define SNIPERMAG			"7Rnd_408_Mag"
#define SNIPERMAG2			"7Rnd_408_Mag"
#define SNIPER_SCOPE		"optic_LRPS"
#define SNIPER_BIPOD		"bipod_01_F_snd"

#define PISTOL				"hgun_ACPC2_F"
#define PISTOLMAG			"9Rnd_45ACP_Mag"
#define PISTOLMAG2			"9Rnd_45ACP_Mag"
#define PISTOL2				"hgun_Pistol_heavy_02_F"
#define PISTOL2MAG			"6Rnd_45ACP_Cylinder"
#define PISTOL2MAG2			"6Rnd_45ACP_Cylinder"
#define SMG					""
#define SMGMAG				""

#define NVG					"NVGoggles"
#define NADE_HE				"HandGrenade"
#define NADE_SMOKE			"SmokeShell"
#define NADE_SMOKERED		"SmokeShellRed"
#define NADE_SMOKEGREEN		"SmokeShellGreen"
#define NADE_SMOKEPURPLE	"SmokeShellPurple"

#define COMMONSCOPE			"optic_Aco"
#define COMMONLASER			"acc_flashlight"
#define COMMON_BINO			""

#define HATBAG				"B_AT_01_weapon_F"
#define HATASSBAG			"B_HMG_01_support_F"
#define HMGBAG				"B_HMG_01_A_high_weapon_F"
#define HMGASSBAG			"B_HMG_01_support_F"
#define GMGBAG				""
#define GMGASSBAG			""
#define MORTARBAG			"B_Mortar_01_weapon_F"
#define MORTARASSBAG		"B_Mortar_01_support_F"

// Clothes
#define COMMON_UNI			"U_I_CombatUniform_tshirt"
#define COMMON_VEST			"V_PlateCarrierIA1_dgtl"
#define COMMON_BAG			""
#define COMMON_HELMET		"H_HelmetIA"
#define COMMON_GOGGLES		""

// Bags
#define BAGMEDIUM			"B_TacticalPack_oli"
#define BAGBIG				"B_Carryall_oli"
#define CHUTE				"B_Parachute"

// Roles
#define OFFICER_VEST		"V_BandollierB_oli"
#define OFFICER_HELMET		"H_Beret_Colonel"
#define OFFICER_GOGGLES		"G_Aviator"

#define MEDIC_HELMET		"H_Bandanna_khk"

#define POINTMAN_VEST		"V_Chestrig_oli"

// Recon
#define	RECON_HELMET		"H_Booniehat_dgtl"
#define	RECON_VEST			"V_PlateCarrierIAGL_dgtl"
#define	RECON_ATTACH		["muzzle_snds_H","acc_pointer_IR"]

// Special
#define PILOT_HELMET		"H_PilotHelmetFighter_I"
#define PILOT_BAG			""
#define PILOT_VEST			""
#define PILOT_UNI			"U_I_pilotCoveralls"

#define HELI_HELMET			"H_PilotHelmetHeli_I"
#define HELI_BAG			""
#define HELI_VEST			"V_TacVest_oli"
#define HELI_UNI			"U_I_HeliPilotCoveralls"

#define CREW_HELMET			"H_HelmetCrew_I"
#define CREW_BAG			""
#define CREW_VEST			"V_BandollierB_oli"
#define CREW_UNI			COMMON_UNI

#define ENGI_HELMET			CREW_HELMET
#define ENGI_BAG			BAGBIG
#define ENGI_VEST			COMMON_VEST
#define ENGI_UNI			COMMON_UNI

#define DEMO_HELMET			CREW_HELMET
#define DEMO_BAG			BAGBIG
#define DEMO_VEST			"V_PlateCarrierIAGL_dgtl"
#define DEMO_UNI			COMMON_UNI

#define UAV_HELMET			""
#define UAV_BAG				""
#define UAV_VEST			""
#define UAV_UNI				""

#define SNIPER_HELMET		""
#define SNIPER_BAG			""
#define SNIPER_VEST			"V_Chestrig_oli"
#define SNIPER_UNI			"U_I_GhillieSuit"

#define SPOTTER_HELMET		""
#define SPOTTER_BAG			""
#define SPOTTER_VEST		SNIPER_VEST
#define SPOTTER_UNI			SNIPER_UNI

#define DIVER_HELMET		""
#define DIVER_BAG			""
#define DIVER_VEST			""
#define DIVER_UNI			""

// Extra
#define BINO_1				"Binocular"		//Officer,SL,TL,pointman,mmgass
#define RANGEFINDER			"Rangefinder"		//Spotter
#define RCO					"optic_Hamr"		//SL,TL


// SL radios (programmable) for special people
#define SPECIAL_TFR_SL		_target setVariable ["unit_tfr_SL",true,true];
#define SPECIAL_TFR_LR		_target setVariable ["unit_tfr_LR",true,true];
#define SPECIAL_ACRE_SL		_target setVariable ["unit_acre_SL",true,true];
#define SPECIAL_ACRE_LR		_target setVariable ["unit_acre_LR",true,true];


/* Weapons
You can add as many magazine types as you want
Follow this format : [rifle, [magazine,amount]]
*/
// here you can change the amount of mags/weapons for kits

_rifleKit = [RIFLE,[RIFLEMAG,4],[RIFLEMAG2,2]];
_carbineKit = [CARBINE,[CARBINEMAG,4]];
_rifleGLKit = [RIFLEGL,[RIFLEGLMAG,3],[RIFLEGLMAG2,2],[RIFLEGL40MM,5]];
_lmgKit = [LMG,[LMGMAG,2],[LMGMAG2,2]];
_mmgKit = [MMG,[MMGMAG,1],[MMGMAG2,1]];
_latKit = [LAT,[LATMAG,1],[LATMAG2,1]];
_matKit = [MAT,[MATMAG,2]];
_aaKit = [AA,[AAMAG,2]];
_marksmanKit = [MARKSMANRIFLE,[MARKSMANRIFLEMAG,2],[MARKSMANRIFLEMAG2,4]];
_sniperKit = [SNIPER,[SNIPERMAG,2],[SNIPERMAG2,4]];
_pistolKit = [PISTOL,[PISTOLMAG,2]];
_pistol2Kit = [PISTOL2,[PISTOLMAG2,2]];
_smgKit = [SMG,[SMGMAG,3]];

_primaryAttachments = [COMMONSCOPE,COMMONLASER];
_secondaryAttachments = [];
_handgunAttachments = [];

// heavy backpacks
// use _backpack = _hatKit;
_hatKit = HATBAG;
_hatAssKit = HATASSBAG;
_hmgKit = HMGBAG;
_hmgAssKit = HMGASSBAG;
_gmgKit = GMGBAG;
_gmgAssKit = GMGASSBAG;
_mortarKit = MORTARBAG;
_mortarAssKit = MORTARASSBAG;

_binoculars = COMMON_BINO;

// linkItem items like nvg,map etc.
_linkItems = ["ItemMap","ItemCompass","ItemWatch"];

// items to be added to inventory (will be added before everything else)
// set the third value in the array as true to put into bag
// _MedicalItems = [["FirstAidKit",5,true],["FirstAidKit",1]];	// 5 first aid kits to bag and 1 into uni/vest (or bag if those are full)
_ExtraItems = [NVG,NADE_HE,NADE_SMOKE];
_MedicalItems = [["ACE_fieldDressing",2],["ACE_morphine",1],["ACE_tourniquet",1]];


// Clothing

_uniform = COMMON_UNI;
_vest = COMMON_VEST;
_backPack = COMMON_BAG;
_helmet = COMMON_HELMET;
_goggles = COMMON_GOGGLES;

/* ----------------------------------------------------------------------------
Code blocks

Variables used in code:
_target		- the unit the script is running on (always local)
_primaryWeapon = _rifleKit;	//rifle
_handGun = "";				//pistol
_secondaryWeapon = "";		//launcher

Everything else can be used to rewrite like this:
_Binoculars = "Binoculars";

---------------------------------------------------------------------------- */

// Code for everyone:
// Currently sets the unit color in group
_commonCode = {
	if (isPlayer _target) then {
		private _playerVar = (vehicleVarName _target);
		private _playerNR = call compile(((_playerVar select [(count _playerVar)-2]) splitString "_") select 0);
		if (_playerNR < 6) then {
			_target assignTeam "RED";
		} else {
			_target assignTeam "BLUE";
		};

		if ("tfr" in mission_plugins) then {
			call tfr_fnc_addRadios;
		};

		if ("acre" in mission_plugins) then {
			call acre_fnc_addRadios;
		};
	};
};

// zero
_officerCode = {
	_vest = OFFICER_VEST;
	_LinkItems pushBack "ItemGPS";
	_primaryWeapon = "";
	_handGun = [PISTOL2,[PISTOL2MAG,5]];
	_goggles = OFFICER_GOGGLES;
	_helmet = OFFICER_HELMET;
	_binoculars = BINO_1;
	_extraItems pushBack ["ACE_microDAGR",1];
	_extraItems pushBack ["ACE_MapTools",1];
};

_medicCode = {
	_helmet = MEDIC_HELMET;
	_backPack = BAGBIG;
	_ExtraItems pushBack [NADE_SMOKE,2];
	_MedicalItems = [
		["ACE_surgicalKit",1,true],
		["ACE_personalAidKit",5,true],
		["ACE_plasmaIV_500",5,true],
		["ACE_morphine",10,true],
		["ACE_epinephrine",5,true],
		["ACE_elasticBandage",10,true],
		["ACE_tourniquet",5,true]
	];
	_target setUnitTrait ["Medic",true];
	_primaryWeapon = _carbineKit;
};

_facCode = {
	SPECIAL_TFR_LR;
	SPECIAL_ACRE_LR;
	_LinkItems pushBack "ItemGPS";
	_binoculars = "Laserdesignator";
	_ExtraItems pushBack ["Laserbatteries",2];
};

// inf
_slCode = {
	_ExtraItems pushBack [NADE_SMOKE,2];
	_LinkItems pushBack "ItemGPS";
	_binoculars = BINO_1;
	_primaryAttachments pushBack RCO;

};

_tlCode = {
	_ExtraItems pushBack [NADE_SMOKE,2];
	_binoculars = BINO_1;
	_primaryAttachments pushBack RCO;
};

_pointManCode = {
	_LinkItems pushBack "ItemGPS";
	_vest = POINTMAN_VEST;
	_binoculars = BINO_1;
	_primaryWeapon = _carbineKit;
};

_paramedicCode = {
	_backPack = BAGBIG;
	_ExtraItems pushBack [NADE_SMOKE,2];
	_ExtraItems pushBack [NADE_SMOKEPURPLE,2];
	_MedicalItems = [
		["ACE_surgicalKit",1,true],
		["ACE_personalAidKit",5,true],
		["ACE_plasmaIV_500",5,true],
		["ACE_morphine",10,true],
		["ACE_epinephrine",5,true],
		["ACE_elasticBandage",10,true],
		["ACE_tourniquet",5,true]
	];
	_primaryWeapon = _carbineKit;
	_target setUnitTrait ["Medic",true];
};

_latCode = {
	_secondaryWeapon = _latKit;
};
_matCode = {
	_secondaryWeapon = _matKit;
	_primaryWeapon = _carbineKit;
	_backPack = BAGMEDIUM;
};
_matAssCode = {
	_primaryWeapon = _carbineKit;
	_atAmmo = (_matKit select 1);
	_atAmmo set [2,true];
	_extraItems pushBack _atAmmo;
	_backPack = BAGMEDIUM;
};
_aaCode = {
	_primaryWeapon = _carbineKit;
	_secondaryWeapon = _aaKit;
	_backPack = BAGMEDIUM;
};
_aaAssCode = {
	_primaryWeapon = _carbineKit;
	_atAmmo = (_aaKit select 1);
	_atAmmo set [2,true];
	_ExtraItems pushBack _atAmmo;
	_backPack = BAGMEDIUM;
};

_hatCode = {
	_primaryWeapon = _carbineKit;
	_backpack = _hatKit;
};
_hatAssCode = {
	_primaryWeapon = _carbineKit;
	_backpack = _hatAssKit;
};
_lmgCode = {
	_backPack = BAGMEDIUM;
	_primaryWeapon = _lmgKit;
};
_lmgAssCode = {
	_backPack = BAGMEDIUM;
	_lmgTracers = (_lmgKit select 2) select 0;
	_extraItems pushBack [_lmgTracers,4,true];
};

_mmgCode = {
	_backPack = BAGMEDIUM;
	_primaryWeapon = _mmgKit;
};
_mmgAssCode = {
	_binoculars = BINO_1;
	_primaryWeapon = _carbineKit;
	_backPack = BAGMEDIUM;
	_mmgTracers = (_mmgKit select 2) select 0;
	_extraItems pushBack [_mmgTracers,3,true];
};

_marksmanCode = {
	_primaryWeapon = _marksmanKit;
	_primaryAttachments pushBack MARKSMAN_SCOPE;
	_primaryAttachments pushBack MARKSMAN_BIPOD;
};
_grenadierCode = {
	_primaryWeapon = _rifleGLKit;
	_backPack = BAGMEDIUM;
};
_riflemanCode = {

};

// Recon
_reconSlCode = {
	_binoculars = "Laserdesignator";
	_helmet = RECON_HELMET;
	_vest = RECON_VEST;
	_primaryAttachments append RECON_ATTACH;
	_primaryAttachments append [RCO];
};
_reconTlCode = {
	_helmet = RECON_HELMET;
	_vest = RECON_VEST;
	_primaryAttachments append RECON_ATTACH;
	_primaryAttachments append [RCO];
};
_reconParamedicCode = {
	_backPack = BAGBIG;
	_MedicalItems = [
		["ACE_surgicalKit",1,true],
		["ACE_personalAidKit",5,true],
		["ACE_plasmaIV_500",5,true],
		["ACE_morphine",10,true],
		["ACE_epinephrine",5,true],
		["ACE_elasticBandage",10,true],
		["ACE_tourniquet",5,true]
	];
	_helmet = RECON_HELMET;
	_vest = RECON_VEST;
	_primaryAttachments append RECON_ATTACH;
};
_reconScoutCode = {
	_binoculars = "Rangefinder";
	_helmet = RECON_HELMET;
	_vest = RECON_VEST;
	_primaryAttachments append RECON_ATTACH;
};
_reconlatCode = {
	_backPack = BAGMEDIUM;
	_secondaryWeapon = _latKit;
	_helmet = RECON_HELMET;
	_vest = RECON_VEST;
	_primaryAttachments append RECON_ATTACH;
};
_reconlmgCode = {
	_primaryWeapon = _lmgKit;
	_helmet = RECON_HELMET;
	_vest = RECON_VEST;
	_primaryAttachments append RECON_ATTACH;
};
_reconMarksmanCode = {
	_primaryWeapon = _marksmanKit;
	_helmet = RECON_HELMET;
	_vest = RECON_VEST;
	_primaryAttachments append RECON_ATTACH;
	_primaryAttachments append [MARKSMAN_SCOPE,MARKSMAN_BIPOD];
};
_reconDemoCode = {
	_helmet = RECON_HELMET;
	_vest = RECON_VEST;
	_primaryAttachments append RECON_ATTACH;
};

// Special
_hmgCode = {
	SPECIAL_TFR_SL;
	SPECIAL_ACRE_SL;
	_primaryWeapon = _carbineKit;
	_backpack = _hmgit;
};
_hmgAssCode = {
	SPECIAL_TFR_SL;
	SPECIAL_ACRE_SL;
	_primaryWeapon = _carbineKit;
	_backpack = _hmgAssKit;
};
_gmgCode = {
	SPECIAL_TFR_SL;
	SPECIAL_ACRE_SL;
	_primaryWeapon = _carbineKit;
	_backpack = _gmgKit;
};
_gmgAssCode = {
	SPECIAL_TFR_SL;
	SPECIAL_ACRE_SL;
	_primaryWeapon = _carbineKit;
	_backpack = _gmgAssKit;
};
_mortarCode = {
	SPECIAL_TFR_SL;
	SPECIAL_ACRE_SL;
	_primaryWeapon = _carbineKit;
	_backpack = _mortarKit;
};
_mortarAssCode = {
	SPECIAL_TFR_SL;
	SPECIAL_ACRE_SL;
	_primaryWeapon = _carbineKit;
	_backpack = _mortarAssKit;
	_extraItems pushBack ["ACE_RangeTable_82mm",1];
};

// Special
_crewCode = {
	SPECIAL_TFR_SL;
	SPECIAL_ACRE_SL;
	_primaryWeapon = _carbineKit;
	_helmet = CREW_HELMET;
	_backpack = CREW_BAG;
	_vest = CREW_VEST;
	_uniform = CREW_UNI;
};
_pilotCode = {
	SPECIAL_TFR_SL;
	SPECIAL_ACRE_SL;
	_primaryWeapon = _carbineKit;
	_helmet = PILOT_HELMET;
	_backpack = PILOT_BAG;
	_vest = PILOT_VEST;
	_uniform = PILOT_UNI;
};
_heliPilotCode = {
	SPECIAL_TFR_SL;
	SPECIAL_ACRE_SL;
	_primaryWeapon = _carbineKit;
	_helmet = HELI_HELMET;
	_backpack = HELI_BAG;
	_vest = HELI_VEST;
	_uniform = HELI_UNI;
};
_engineerCode = {
	_target setUnitTrait ["engineer",true];
	if (leader (group _target) isEqualTo _target && ("tfr" in mission_plugins)) then {
		SPECIAL_TFR_LR;
	} else {
		_backpack = ENGI_BAG;
	};
	SPECIAL_TFR_SL;
	SPECIAL_ACRE_SL;
	_primaryWeapon = _carbineKit;
	_helmet = ENGI_HELMET;
	_vest = ENGI_VEST;
	_uniform = ENGI_UNI;

	_extraItems append [
		["toolKit",1,true],
		["ATMine_Range_Mag",1]
	];
};
_demoCode = {
	_target setUnitTrait ["explosiveSpecialist",true];
	SPECIAL_TFR_SL;
	SPECIAL_ACRE_SL;
	_primaryWeapon = _carbineKit;
	_helmet = DEMO_HELMET;
	_backpack = DEMO_BAG;
	_vest = DEMO_VEST;
	_uniform = DEMO_UNI;
	_extraItems append [
		["ACE_Clacker",1],
		["toolKit",1,true],
		["MineDetector",1],
		["DemoCharge_Remote_Mag",2]
	];
};
_uavCode = {
	_target setUnitTrait ["uavHacker",true];
	SPECIAL_TFR_SL;
	SPECIAL_ACRE_SL;
	_primaryWeapon = _carbineKit;
	_helmet = UAV_HELMET;
	_backpack = UAV_BAG;
	_vest = UAV_VEST;
	_uniform = UAV_UNI;
	_linkItems pushBack "I_UavTerminal";
};
_sniperCode = {
	SPECIAL_TFR_SL;
	SPECIAL_ACRE_SL;
	_primaryWeapon = _sniperKit;
	_secondaryWeapon = _pistolKit;
	_primaryAttachments append [SNIPER_SCOPE,SNIPER_BIPOD];
	_helmet = SNIPER_HELMET;
	_backpack = SNIPER_BAG;
	_vest = SNIPER_VEST;
	_uniform = SNIPER_UNI;
};
_spotterCode = {
	SPECIAL_TFR_SL;
	SPECIAL_ACRE_SL;
	SPECIAL_TFR_LR
	_primaryWeapon = _marksmanKit;
	_primaryAttachments append [MARKSMAN_SCOPE,MARKSMAN_BIPOD];
	_binoculars = RANGEFINDER;
	_helmet = SPOTTER_HELMET;
	_backpack = SPOTTER_BAG;
	_vest = SPOTTER_VEST;
	_uniform = SPOTTER_UNI;
};
_diverCode = {
	SPECIAL_TFR_SL;
	SPECIAL_ACRE_SL;
	_primaryWeapon = _carbineKit;
	_helmet = DIVER_HELMET;
	_backpack = DIVER_BAG;
	_vest = DIVER_VEST;
	_uniform = DIVER_UNI;
};

// custom
// set the unit role as "custom1" etc. to use
_custom1Code = {
	_backpack = BAGBIG;
	_helmet = MEDIC_HELMET;
	_ExtraItems pushBack [NADE_SMOKE,2];
	_MedicalItems = [
		["ACE_surgicalKit",1,true],
		["ACE_personalAidKit",5,true],
		["ACE_plasmaIV_500",5,true],
		["ACE_morphine",10,true],
		["ACE_epinephrine",5,true],
		["ACE_elasticBandage",10,true],
		["ACE_tourniquet",5,true]
	];
	_target setUnitTrait ["Medic",true];
	_primaryWeapon = _carbineKit;
};
_custom2Code = {};
_custom3Code = {};
_custom4Code = {};
_custom5Code = {};


/* ----------------------------------------------------------------------------
Cargo arrays

These will be called when vehicles/boxes get cargo

To add _rifleCargo to a car:
	[
		car,
		"nato",
		["rifle"]
	] call loadout_fnc_cargo;
To add 5 instances of _rifleCargo and 1 _atCargo:
	[
		car,
		"nato",
		[["rifle",5],"at"]
	] call loadout_fnc_cargo;

---------------------------------------------------------------------------- */
_rifleCargo = [
	[RIFLE,1],
	[RIFLEMAG,5]
];
_mgCargo = [
	[MMG,1],
	[MMGMAG,3],
	[MMGMAG2,3]
];
_atCargo = [
	[_latKit select 0]
];
_pistolCargo = [
	[PISTOL,1],
	[PISTOLMAG,3]
];

_smgCargo = [
	[SMG,1],
	[SMGMAG,6]
];



_weaponsCargo = [
	RIFLE,
	[RIFLEMAG,6],
	MMG,
	[MMGMAG,3],
	[_latKit select 0,1],
	//[_latKit select 1,3],
	_matKit select 0,
	[_matKit select 1,2]
];
_weaponsbigCargo = [
	[RIFLE,5],
	[RIFLEMAG,6*5],
	[MMG,5],
	[MMGMAG,3*5],
	[_latKit select 0,3],
	//[_latKit select 1,3*5],
	[_matKit select 0,3],
	[_matKit select 1,3*5]
];

_radiosCargo = [];
_radiosSRCargo = [];
_radiosLRCargo = [];

if ("tfr" in mission_plugins) then {
	// Get radio sides
	private _radioSide = RADIOSIDE;
	if (isNil {_radioSide}) then {
		private _radioSide = _side;
		if (_radioSide isEqualTo civilian) then {
			_radioSide = west;
		};
	};
	_sr = call compile format ["mission_tfr_radio_personal_%1",toLower(str _radioSide)];
	_sl = call compile format ["mission_tfr_radio_sl_%1",toLower(str _radioSide)];
	_lr = call compile format ["mission_tfr_radio_lr_%1",toLower(str _radioSide)];

	_radiosCargo = [
		[_sr,30],
		[_sl,6],
		[_lr,3,true]
	];
	_radiosSRCargo = [
		[_sr,15]
	];
	_radiosLRCargo = [
		[_lr,5,true]
	];
};

if ("acre" in mission_plugins) then {
	// Get radio sides
	private _radioSide = RADIOSIDE;
	if (isNil {_radioSide}) then {
		private _radioSide = _side;
		if (_radioSide isEqualTo civilian) then {
			_radioSide = west;
		};
	};
	_sr = call compile format ["mission_acre_radio_personal_%1",toLower(str _radioSide)];
	_sl = call compile format ["mission_acre_radio_sl_%1",toLower(str _radioSide)];
	_lr = call compile format ["mission_acre_radio_lr_%1",toLower(str _radioSide)];

	_radiosCargo = [
		[_sr,30],
		[_sl,6],
		[_lr,3],
		[BAGMEDIUM,3,true]
	];
	_radiosSRCargo = [
		[_sr,15]
	];
	_radiosLRCargo = [
		[_lr,5],
		[BAGMEDIUM,5,true]
	];
};


_ammoCargo = [
	[RIFLEMAG,20],
	[RIFLEMAG2,10],
	[LMGMAG,10],
	[LMGMAG2,5],
	[MMGMAG,5],
	[MMGMAG2,5],
	[((_marksmanKit select 1)select 0),10],
	[((_marksmanKit select 2)select 0),10],
	[((_pistolKit select 1)select 0),5],
	[PISTOL2MAG,5],
	[NADE_HE,10],
	[NADE_SMOKE,10]
];

_ammoBigCargo = [
	[RIFLEMAG,50],
	[RIFLEMAG2,25],
	[LMGMAG,30],
	[LMGMAG2,15],
	[MMGMAG,20],
	[MMGMAG2,10],
	[((_marksmanKit select 1)select 0),30],
	[((_marksmanKit select 1)select 0),30],
	[((_pistolKit select 1)select 0),20],
	[PISTOL2MAG,20],
	[NADE_HE,30],
	[NADE_SMOKE,30]
];

_explosivesCargo = [
	["ACE_Clacker",1],
	["toolKit",1],
	["MineDetector",1],
	["DemoCharge_Remote_Mag",10],
	["APERSTripMine_Wire_Mag",10],
	["SLAMDirectionalMine_Wire_Mag",10],
	["SatchelCharge_Remote_Mag",5],
	[BAGBIG,3,true]
];

_genericCargo = [
	["toolKit",1],
	[BAGMEDIUM,1,true]
];

_medsSmallCargo = [
	["ACE_personalAidKit",5],
	["ACE_plasmaIV_500",5],
	["ACE_morphine",10],
	["ACE_epinephrine",5],
	["ACE_elasticBandage",10],
	["ACE_fieldDressing",10],
	["ACE_tourniquet",5]
];

_medsCargo = [
	["ACE_surgicalKit",3],
	["ACE_personalAidKit",30],
	["ACE_plasmaIV_500",30],
	["ACE_morphine",30],
	["ACE_epinephrine",30],
	["ACE_elasticBandage",50],
	["ACE_fieldDressing",50],
	["ACE_tourniquet",30]
];

_chuteCargo = [
	[CHUTE,1,true]
];

_chutesCargo = [
	[CHUTE,10,true]
];
_bagsCargo = [
	[BAGMEDIUM,3,true]
];

_custom1Cargo = [];
_custom2Cargo = [];
_custom3Cargo = [];

_emptyCargo = [];