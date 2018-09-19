/* ----------------------------------------------------------------------------
Name: csat china

Description:
	Vanilla csat china faction

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
_faces = ["GreekHead_A3_01","GreekHead_A3_02","GreekHead_A3_03",'male01eng','male01gre','male01engb','male01chi'];
_voices = ["male01gre","male02gre","male03gre"];

// Which side radios to get?
#define RADIOSIDE			east

#define RIFLE				"arifle_CTAR_blk_F"
#define RIFLEMAG			"30Rnd_580x42_Mag_Tracer_F"
#define RIFLEMAG2			"30Rnd_580x42_Mag_Tracer_F"
#define CARBINE				"arifle_CTAR_blk_F"
#define CARBINEMAG			RIFLEMAG
#define CARBINEMAG2			RIFLEMAG2
#define RIFLEGL				"arifle_CTAR_GL_blk_F"
#define RIFLEGLMAG			RIFLEMAG
#define RIFLEGLMAG2			RIFLEMAG2
#define RIFLEGL40MM			"1Rnd_HE_Grenade_shell"

#define LMG					"arifle_CTARS_blk_F"
#define LMGMAG				"100Rnd_580x42_Mag_Tracer_F"
#define LMGMAG2				"100Rnd_580x42_Mag_Tracer_F"
#define MMG					"LMG_Zafir_F"
#define MMGMAG				"150Rnd_762x54_Box_Tracer"
#define MMGMAG2				"150Rnd_762x54_Box_Tracer"

#define LAT					"launch_RPG7_F"
#define LATMAG				"RPG7_F"
#define LATMAG2				"RPG7_F"
#define MAT					"launch_O_Titan_short_ghex_F"
#define MATMAG				"Titan_AT"
#define MATMAG2				"Titan_AT"
#define AA					"rhs_weap_igla"
#define AAMAG				"rhs_mag_9k38_rocket"
#define AAMAG2				"rhs_mag_9k38_rocket"

#define MARKSMANRIFLE		"srifle_DMR_07_blk_F"
#define MARKSMANRIFLEMAG	'20Rnd_650x39_Cased_Mag_F'
#define MARKSMANRIFLEMAG2	'ACE_20Rnd_65x47_Scenar_mag'
#define MARKSMAN_SCOPE		"optic_DMS"
#define MARKSMAN_BIPOD		""
#define SNIPER				"srifle_GM6_ghex_F"
#define SNIPERMAG			"5Rnd_127x108_Mag"
#define SNIPERMAG2			"5Rnd_127x108_APDS_Mag"
#define SNIPER_SCOPE		"optic_LRPS"
#define SNIPER_BIPOD		""

#define PISTOL				"hgun_Pistol_heavy_02_F"
#define PISTOLMAG			"6Rnd_45ACP_Cylinder"
#define PISTOLMAG2			"6Rnd_45ACP_Cylinder"
#define PISTOL2				"hgun_Rook40_F"
#define PISTOL2MAG			"16Rnd_9x21_Mag"
#define PISTOL2MAG2			"16Rnd_9x21_Mag"
#define SMG					"SMG_02_F"
#define SMGMAG				"30Rnd_9x21_Mag_SMG_02"

#define NVG					""
#define NADE_HE				"HandGrenade"
#define NADE_SMOKE			"SmokeShell"
#define NADE_SMOKERED		"SmokeShellRed"
#define NADE_SMOKEGREEN		"SmokeShellGreen"
#define NADE_SMOKEPURPLE	"SmokeShellPurple"

#define COMMONSCOPE			'optic_Aco'	//""
#define COMMONLASER			""	//'rhs_acc_2dpZenit' << flashlight
#define COMMON_BINO			"Binocular"

#define HATBAG				"RHS_Kornet_Gun_Bag"
#define HATASSBAG			"RHS_Kornet_Tripod_Bag"
#define HMGBAG				"RHS_DShkM_Gun_Bag"
#define HMGASSBAG			"RHS_DShkM_TripodLow_Bag"
#define GMGBAG				"RHS_AGS30_Gun_Bag"
#define GMGASSBAG			"RHS_AGS30_Tripod_Bag"
#define MORTARBAG			"RHS_Podnos_Gun_Bag"
#define MORTARASSBAG		"RHS_Podnos_Bipod_Bag"

_uniform = 'FP_Uniform_Type07Universal';
_vest = 'rhssaf_vest_md12_digital_desert';
_helmet = 'FP_Helmet_Type07UniESS';
//_goggles = _colGoggles;

// Clothes
#define COMMON_UNI			_uniform
#define COMMON_VEST			_vest
#define COMMON_BAG			""

#define COMMON_HELMET		_helmet
#define COMMON_GOGGLES		''

// Bags
#define BAGMEDIUM			'rhssaf_kitbag_digital'
#define BAGBIG				'B_Carryall_oucamo'
#define CHUTE				"B_Parachute"

// Roles
#define OFFICER_VEST		""
#define OFFICER_HELMET		"rhssaf_beret_para"
#define OFFICER_GOGGLES		"G_Aviator"

#define MEDIC_HELMET		COMMON_HELMET

#define POINTMAN_VEST		COMMON_VEST

// Recon
#define	RECON_HELMET		"H_Booniehat_khk_hs"
#define	RECON_VEST			"V_HarnessO_gry"
#define	RECON_ATTACH		["muzzle_snds_H","acc_pointer_IR"]

// Special
#define PILOT_HELMET		"rhs_zsh7a_alt"
#define PILOT_BAG			CHUTE
#define PILOT_VEST			""
#define PILOT_UNI			COMMON_UNI

#define HELI_HELMET			"rhs_zsh7a_mike_green_alt"
#define HELI_BAG			CHUTE
#define HELI_VEST			COMMON_VEST
#define HELI_UNI			COMMON_UNI

#define CREW_HELMET			"rhs_tsh4"
#define CREW_BAG			""
#define CREW_VEST			COMMON_VEST
#define CREW_UNI			COMMON_UNI

#define ENGI_HELMET			CREW_HELMET
#define ENGI_BAG			BAGBIG
#define ENGI_VEST			COMMON_VEST
#define ENGI_UNI			COMMON_UNI

#define DEMO_HELMET			CREW_HELMET
#define DEMO_BAG			BAGBIG
#define DEMO_VEST			"V_HarnessO_gry"
#define DEMO_UNI			COMMON_UNI

#define UAV_HELMET			""
#define UAV_BAG				""
#define UAV_VEST			""
#define UAV_UNI				""

#define SNIPER_HELMET		COMMON_HELMET
#define SNIPER_BAG			""
#define SNIPER_VEST			COMMON_VEST
#define SNIPER_UNI			COMMON_UNI

#define SPOTTER_HELMET		SNIPER_HELMET
#define SPOTTER_BAG			""
#define SPOTTER_VEST		SNIPER_VEST
#define SPOTTER_UNI			SNIPER_UNI

#define DIVER_HELMET		""
#define DIVER_BAG			""
#define DIVER_VEST			""
#define DIVER_UNI			""


// Extra
#define BINO_1				"Rangefinder"		//Officer,SL,TL,pointman,mmgass
#define RANGEFINDER			"Laserdesignator"		//Spotter
#define RCO					'optic_ERCO_blk_F'		//SL,TL


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

_rifleKit = [RIFLE,[RIFLEMAG,4],[RIFLEMAG2,4]];
_carbineKit = [CARBINE,[CARBINEMAG,3],[CARBINEMAG2,3]];
_rifleGLKit = [RIFLEGL,[RIFLEGLMAG,3],[RIFLEGLMAG2,2],[RIFLEGL40MM,15]];
_lmgKit = [LMG,[LMGMAG,2],[LMGMAG2,3]];
_mmgKit = [MMG,[MMGMAG,2],[MMGMAG2,2]];
_latKit = [LAT,[LATMAG,2],[LATMAG2,1]];
_matKit = [MAT,[MATMAG,2]];
_aaKit = [AA,[AAMAG,2]];
_marksmanKit = [MARKSMANRIFLE,[MARKSMANRIFLEMAG,4],[MARKSMANRIFLEMAG2,4]];
_sniperKit = [SNIPER,[SNIPERMAG,4],[SNIPERMAG2,4]];
_pistolKit = [PISTOL,[PISTOLMAG,4]];
_pistol2Kit = [PISTOL2,[PISTOLMAG2,4]];
_smgKit = [SMG,[SMGMAG,6]];

_primaryAttachments = [COMMONLASER,COMMONSCOPE];
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
_ExtraItems = [NADE_HE,NADE_SMOKE,'ACE_CableTie'];
_MedicalItems = [["ACE_fieldDressing",6],["ACE_morphine",3],["ACE_epinephrine",3]];


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
			[] spawn acre_fnc_addRadios;
		};
	};
};

// zero
_officerCode = {
	_vest = OFFICER_VEST;
	_goggles = OFFICER_GOGGLES;
	_helmet = OFFICER_HELMET;

	_primaryWeapon = '';
	_handGun = _pistolKit;
	_Binoculars = RANGEFINDER;
};

_medicCode = {
	_backpack = BAGBIG;
	_ExtraItems pushBack [NADE_SMOKE,2];
	_MedicalItems = [
		['ACE_bodyBag',5,true],
		["ACE_bloodIV",5,true],
		["ACE_morphine",10,true],
		["ACE_epinephrine",10,true],
		["ACE_fieldDressing",20,true]
	];
	_target setUnitTrait ["Medic",true];
	_primaryWeapon = _smgKit;
};

_facCode = {
};

// inf
_slCode = {
	_helmet = 'rhssaf_beret_green';
	_ExtraItems pushBack [NADE_SMOKE,2];
	_Binoculars = RANGEFINDER;
	_primaryAttachments pushBack RCO;
	_handGun = [PISTOL2,[PISTOL2MAG,5]];

};

_tlCode = {
	_ExtraItems pushBack [NADE_SMOKE,2];
	_binoculars = BINO_1;
	_primaryAttachments pushBack RCO;
	_handGun = [PISTOL2,[PISTOL2MAG,5]];
};

_pointManCode = {
	_vest = POINTMAN_VEST;
	_binoculars = BINO_1;
	_primaryWeapon = _carbineKit;
	_extraItems append ['DemoCharge_Remote_Mag','DemoCharge_Remote_Mag'];
};

_paramedicCode = {
	_backpack = BAGBIG;
	_ExtraItems pushBack [NADE_SMOKE,2];
	_MedicalItems = [
		['ACE_bodyBag',5,true],
		["ACE_bloodIV",5,true],
		["ACE_morphine",10,true],
		["ACE_epinephrine",10,true],
		["ACE_fieldDressing",20,true]
	];
	_target setUnitTrait ["Medic",true];
	_primaryWeapon = _smgKit;
};

_latCode = {
	_backpack = BAGMEDIUM;
	_secondaryWeapon = _latKit;
};
_matCode = {
	_secondaryWeapon = _matKit;
	_primaryWeapon = _smgKit;
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
	_primaryAttachments pushBack RCO;
	_backPack = BAGMEDIUM;
	_primaryWeapon = _lmgKit;
};
_lmgAssCode = {
	_backPack = BAGMEDIUM;
	_lmgTracers = (_lmgKit select 2) select 0;
	_extraItems pushBack [_lmgTracers,4,true];
	_primaryWeapon = _carbineKit;
	_Binoculars = BINO_1;
};

_mmgCode = {
	_primaryAttachments pushBack 'optic_Arco_blk_F';
	_backPack = BAGMEDIUM;
	_primaryWeapon = _mmgKit;
	_handGun = [PISTOL2,[PISTOL2MAG,5]];
};
_mmgAssCode = {
	_binoculars = BINO_1;
	_primaryWeapon = _carbineKit;
	_backPack = BAGMEDIUM;
	_mmgTracers = (_mmgKit select 2) select 0;
	_extraItems pushBack [_mmgTracers,5,true];
};

_marksmanCode = {
	_primaryWeapon = _marksmanKit;
	_primaryAttachments pushBack MARKSMAN_SCOPE;
	_primaryAttachments pushBack MARKSMAN_BIPOD;
	_handGun = [PISTOL2,[PISTOL2MAG,5]];
	_extraItems pushBack 'ACE_RangeCard';
};
_grenadierCode = {
	_primaryWeapon = _rifleGLKit;
	_backPack = BAGMEDIUM;
	_extraItems pushBack ['1Rnd_Smoke_Grenade_shell',15,true];
};
_riflemanCode = {
	_backpack = BAGBIG;
	_extraItems pushBack [LATMAG,4,true];

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
	_LinkItems pushBack "ItemGPS";
	_MedicalItems = [
		["ACE_bloodIV",10,true],
		["ACE_morphine",20,true],
		["ACE_epinephrine",20,true],
		["ACE_fieldDressing",30,true]
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
	_primaryWeapon = _smgKit;
	_backpack = HMGBAG;
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
	_primaryWeapon = _smgKit;
	_backpack = _gmgKit;
};
_gmgAssCode = {
	SPECIAL_TFR_SL;
	SPECIAL_ACRE_SL;
	_primaryWeapon = _carbineKit;
	_binoculars = BINO_1;
	_backpack = _gmgAssKit;
};
_mortarCode = {
	SPECIAL_TFR_SL;
	SPECIAL_ACRE_SL;
	_primaryWeapon = _smgKit;
	_backpack = _mortarKit;
};
_mortarAssCode = {
	SPECIAL_TFR_SL;
	SPECIAL_ACRE_SL;
	_primaryWeapon = _carbineKit;
	_backpack = _mortarAssKit;
	_binoculars = BINO_1;
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
	_primaryWeapon = '';
	_handGun = [PISTOL2,[PISTOL2MAG,4]];
	_helmet = PILOT_HELMET;
	_backpack = PILOT_BAG;
	_vest = PILOT_VEST;
	_uniform = PILOT_UNI;
};
_heliPilotCode = {
	SPECIAL_TFR_SL;
	SPECIAL_ACRE_SL;
	_primaryWeapon = '';
	_handGun = [PISTOL2,[PISTOL2MAG,4]];
	_helmet = HELI_HELMET;
	_backpack = BAGBIG;
	_vest = HELI_VEST;
	_uniform = HELI_UNI;

	_extraItems append [
		["toolKit",1]
	];
	_target setUnitTrait ["engineer",true];

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
	_primaryWeapon = _smgKit;
	_helmet = ENGI_HELMET;
	_vest = ENGI_VEST;
	_uniform = ENGI_UNI;

	_extraItems append [
		["toolKit",1]
	];
};
_demoCode = {
	_target setUnitTrait ["explosiveSpecialist",true];
	SPECIAL_TFR_SL;
	SPECIAL_ACRE_SL;
	_primaryWeapon = _smgKit;
	_helmet = DEMO_HELMET;
	_backpack = DEMO_BAG;
	_vest = DEMO_VEST;
	_uniform = DEMO_UNI;
	_extraItems append [
		["ACE_Clacker",1],
		['ACE_DefusalKit',1],
		["toolKit",1],
		["MineDetector",1],
		["DemoCharge_Remote_Mag",2]
	];
	_handGun = [PISTOL2,[PISTOL2MAG,5]];
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
	_handGun = [PISTOL2,[PISTOL2MAG,5]];
	_extraItems pushBack 'ACE_RangeCard';
};
_spotterCode = {
	SPECIAL_TFR_SL;
	SPECIAL_ACRE_SL;
	_primaryWeapon = _marksmanKit;
	_primaryAttachments append [MARKSMAN_SCOPE,MARKSMAN_BIPOD];
	_binoculars = RANGEFINDER;
	_helmet = SPOTTER_HELMET;
	_backpack = SPOTTER_BAG;
	_vest = SPOTTER_VEST;
	_uniform = SPOTTER_UNI;
	_handGun = [PISTOL2,[PISTOL2MAG,5]];
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
		["ACE_bloodIV",10,true],
		["ACE_morphine",20,true],
		["ACE_epinephrine",20,true],
		["ACE_fieldDressing",30,true]
	];
	_target setUnitTrait ["Medic",true];
	_primaryWeapon = _carbineKit;
};
_custom2Code = {
	_uniform = 'sciv_tropicshirt1';
	_vest = 'V_Rangemaster_belt';
	_backpack = 'FP_B_Carryall_Inv';
	_helmet = 'H_Cap_blu';
	_goggles = 'G_Squares_Tinted';

	_primaryWeapon = "";
	_handGun = [PISTOL,[PISTOLMAG,5]];
	_extraItems pushBack ["ACE_microDAGR",1];
	_extraItems pushBack ["ACE_MapTools",1];
};
_custom3Code = {
	_uniform = 'sciv_tropicshirt3';
	_vest = 'V_Rangemaster_belt';
	_backpack = 'FP_B_Carryall_Inv';
	_helmet = 'H_Cap_red';
	_goggles = 'G_Aviator';

	_primaryWeapon = "";
	_handGun = [PISTOL,[PISTOLMAG,5]];
	_extraItems pushBack ["ACE_microDAGR",1];
	_extraItems pushBack ["ACE_MapTools",1];

};
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
pistolCargo = [
	[PISTOL,1],
	[PISTOLMAG,3]
];

_smgCargo = [
	[SMG,1],
	[SMGMAG,6]
];



_weaponsCargo = [
	[RIFLE],
	[RIFLEMAG,6],
	[MMG],
	[MMGMAG,3],
	[_latKit select 0,1],
	//[_latKit select 1,3],
	[_matKit select 0],
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
	[RIFLEGL40MM,10],
	[((_marksmanKit select 1)select 0),10],
	[((_marksmanKit select 2)select 0),10],
	[((_pistolKit select 1)select 0),5],
	[(SMGMAG),5],
	[PISTOL2MAG,5],
	[NADE_HE,10],
	[NADE_SMOKE,10]
];

_ammoBigCargo = [
	[RIFLEMAG,50],
	[RIFLEMAG2,25],
	[SMGMAG,15],
	[LMGMAG,30],
	[LMGMAG2,15],
	[MMGMAG,20],
	[MMGMAG2,10],
	[RIFLEGL40MM,40],
	[((_marksmanKit select 1)select 0),30],
	[((_marksmanKit select 1)select 0),30],
	[((_pistolKit select 1)select 0),20],
	[PISTOLMAG,20],
	[PISTOL2MAG,20],
	[(SMGMAG),10],
	[NADE_HE,30],
	[NADE_SMOKE,30],
	[HMGBAG,1,true]
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
	['ACE_bodyBag',5],
	["ACE_bloodIV",10],
	["ACE_morphine",20],
	["ACE_epinephrine",20],
	["ACE_fieldDressing",30]
];

_medsCargo = [
	['ACE_bodyBag',15],
	["ACE_bloodIV",30],
	["ACE_morphine",100],
	["ACE_epinephrine",100],
	["ACE_fieldDressing",100]
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
_custom2Cargo = [
	['rhs_weap_m24sws',1],
	['rhsusf_5Rnd_762x51_m118_special_Mag',10],
	['optic_KHS_tan',1]
];
_custom3Cargo = [];

_emptyCargo = [];