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
_faces = ["WhiteHead_02","WhiteHead_03","WhiteHead_04","WhiteHead_05","WhiteHead_06","WhiteHead_07"];
_voices = ["male01eng","male02eng","male03eng","male04eng"];

// Which side radios to get?
#define RADIOSIDE			west

// Rifles
#define RIFLE				"rhs_weap_m4a1_carryhandle"
#define RIFLEMAG			"rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red"
#define RIFLEMAG2			"rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red"
#define CARBINE				"rhs_weap_m4a1_carryhandle"
#define CARBINEMAG			RIFLEMAG
#define CARBINEMAG2			RIFLEMAG2
#define RIFLEGL				"rhs_weap_m4a1_carryhandle_m203S"
#define RIFLEGLMAG			RIFLEMAG
#define RIFLEGLMAG2			RIFLEMAG2
#define RIFLEGL40MM			"rhs_mag_M433_HEDP"

// MGs
#define LMG					"rhs_weap_m249_pip_S"
#define LMGMAG				"rhs_200rnd_556x45_T_SAW"
#define LMGMAG2				"rhs_200rnd_556x45_T_SAW"
#define MMG					"rhs_weap_m240B"
#define MMGMAG				"rhsusf_100Rnd_762x51_m62_tracer"
#define MMGMAG2				"rhsusf_100Rnd_762x51_m62_tracer"

// AT
#define LAT					"rhs_weap_M136"
#define LATMAG				""
#define LATMAG2				""
#define MAT					"rhs_weap_smaw_green"
#define MATMAG				"rhs_mag_smaw_HEDP"
#define MATMAG2				"rhs_mag_smaw_HEAA"
#define AA					"rhs_weap_fim92"
#define AAMAG				"rhs_fim92_mag"
#define AAMAG2				"rhs_fim92_mag"

// Snipers
#define MARKSMANRIFLE		"rhs_weap_sr25_d"
#define MARKSMANRIFLEMAG	"rhsusf_20Rnd_762x51_m62_Mag"
#define MARKSMANRIFLEMAG2	"rhsusf_20Rnd_762x51_m62_Mag"
#define MARKSMAN_SCOPE		"rhsusf_acc_LEUPOLDMK4_2_d"
#define MARKSMAN_BIPOD		"rhsusf_acc_harris_bipod"
#define SNIPER				"rhs_weap_M107"
#define SNIPERMAG			"rhsusf_mag_10Rnd_STD_50BMG_mk211"
#define SNIPERMAG2			"rhsusf_mag_10Rnd_STD_50BMG_M33"
#define SNIPER_SCOPE		"rhsusf_acc_premier"
#define SNIPER_BIPOD		"bipod_01_F_snd"

// Pistols
#define PISTOL				"rhsusf_weap_m9"
#define PISTOLMAG			"rhsusf_mag_15Rnd_9x19_JHP"
#define PISTOLMAG2			"rhsusf_mag_15Rnd_9x19_JHP"
#define PISTOL2				"rhsusf_weap_m1911a1"
#define PISTOL2MAG			"rhsusf_mag_7x45acp_MHP"
#define PISTOL2MAG2			"rhsusf_mag_7x45acp_MHP"
#define SMG					"hlc_smg_mp5a3"
#define SMGMAG				"hlc_30Rnd_9x19_B_MP5"

// Extra
#define NVG					"rhsusf_ANPVS_15"
#define NADE_HE				"rhs_mag_m67"
#define NADE_SMOKE			"rhs_mag_an_m8hc"
#define NADE_SMOKERED		"rhs_mag_m18_red"
#define NADE_SMOKEGREEN		"rhs_mag_m18_green"
#define NADE_SMOKEPURPLE	"rhs_mag_m18_purple"

// Common Attachments
#define COMMONSCOPE			"rhsusf_acc_compm4"
#define COMMONLASER			"rhsusf_acc_M952V"
#define COMMON_BINO			""

// Heavy bags
#define HATGUN				"rhs_weap_fgm148"
#define HATAMMO				"rhs_fgm148_magazine_AT"
#define HMGBAG				"RHS_M2_Gun_Bag"
#define HMGASSBAG			"RHS_M2_Tripod_Bag"
#define GMGBAG				"RHS_Mk19_Gun_Bag"
#define GMGASSBAG			"RHS_Mk19_Tripod_Bag"
#define MORTARBAG			"rhs_M252_Gun_Bag"
#define MORTARASSBAG		"rhs_M252_Bipod_Bag"

// Clothes
#define COMMON_UNI			"rhs_uniform_FROG01_d"
#define COMMON_VEST			"rhsusf_spc_light"
#define COMMON_BAG			""
#define COMMON_HELMET		"rhsusf_lwh_helmet_marpatd"
#define COMMON_GOGGLES		""

// Bags
#define BAGMEDIUM			"rhsusf_assault_eagleaiii_ocp"
#define BAGBIG				"B_Carryall_khk"
#define CHUTE				"B_Parachute"

// Roles
// Infantry
#define OFFICER_VEST		"VSM_CarrierRig_Gunner_AOR1"
#define OFFICER_HELMET		"rhs_8point_marpatd"
#define OFFICER_GOGGLES		"G_Aviator"

#define MEDIC_HELMET		"rhs_booniehat2_marpatd"

#define POINTMAN_VEST		"rhsusf_spc_marksman"

#define	RECON_HELMET		"rhsusf_bowman_cap"
#define	RECON_VEST			"V_PlateCarrierGL_mtp"
#define	RECON_ATTACH		["rhsusf_acc_nt4_black","rhsusf_acc_anpeq15_bk_light"]

// Special
#define PILOT_HELMET		"RHS_jetpilot_usaf"
#define PILOT_BAG			""
#define PILOT_VEST			""
#define PILOT_UNI			"U_B_PilotCoveralls"

#define HELI_HELMET			"rhsusf_hgu56p_visor_usa"
#define HELI_BAG			""
#define HELI_VEST			"V_TacVest_blk"
#define HELI_UNI			"rhs_uniform_FROG01_d"

#define CREW_HELMET			"rhsusf_cvc_alt_helmet"
#define CREW_BAG			""
#define CREW_VEST			"rhsusf_spc_crewman"
#define CREW_UNI			COMMON_UNI

#define ENGI_HELMET			"rhsusf_cvc_green_ess"
#define ENGI_BAG			BAGBIG
#define ENGI_VEST			COMMON_VEST
#define ENGI_UNI			COMMON_UNI

#define DEMO_HELMET			"rhsusf_cvc_green_ess"
#define DEMO_BAG			BAGBIG
#define DEMO_VEST			"V_PlateCarrier_Kerry"
#define DEMO_UNI			COMMON_UNI

#define UAV_HELMET			""
#define UAV_BAG				""
#define UAV_VEST			""
#define UAV_UNI				""

#define SNIPER_HELMET		""
#define SNIPER_BAG			""
#define SNIPER_VEST			"V_Chestrig_rgr"
#define SNIPER_UNI			"U_B_GhillieSuit"

#define SPOTTER_HELMET		""
#define SPOTTER_BAG			""
#define SPOTTER_VEST		SNIPER_VEST
#define SPOTTER_UNI			SNIPER_UNI

#define DIVER_HELMET		""
#define DIVER_BAG			""
#define DIVER_VEST			"V_RebreatherB"
#define DIVER_UNI			"U_B_Wetsuit"

// Extra
#define BINO_1				"Binocular"				//Officer,SL,TL,pointman,mmgass
#define RANGEFINDER			"Rangefinder"			//Spotter
#define RCO					"rhsusf_acc_ACOG"		//SL,TL


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
_carbineKit = [CARBINE,[CARBINEMAG,2],[CARBINEMAG2,4]];
_rifleGLKit = [RIFLEGL,[RIFLEGLMAG,3],[RIFLEGLMAG2,2],[RIFLEGL40MM,30]];
_lmgKit = [LMG,[LMGMAG,2],[LMGMAG2,3]];
_mmgKit = [MMG,[MMGMAG,1],[MMGMAG2,2]];
_latKit = [LAT,[LATMAG,1],[LATMAG2,1]];
_matKit = [MAT,[MATMAG,2]];
_aaKit = [AA,[AAMAG,2]];
_marksmanKit = [MARKSMANRIFLE,[MARKSMANRIFLEMAG,2],[MARKSMANRIFLEMAG2,4]];
_sniperKit = [SNIPER,[SNIPERMAG,2],[SNIPERMAG2,4]];
_pistolKit = [PISTOL,[PISTOLMAG,3]];
_pistol2Kit = [PISTOL2,[PISTOLMAG2,3]];
_smgKit = [SMG,[SMGMAG,3]];

_primaryAttachments = [COMMONSCOPE,COMMONLASER];
_secondaryAttachments = [];
_handgunAttachments = [];

// heavy backpacks
// use _backpack = _hatKit;
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
_ExtraItems = [NVG,NADE_HE,NADE_SMOKE/*,'rhs_mag_mk84'*/];
_MedicalItems = [["ACE_fieldDressing",5],["ACE_morphine",3],["ACE_epinephrine",3]];


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
	_binoculars = "Laserdesignator";
	_ExtraItems pushBack ["Laserbatteries",1];
	_extraItems pushBack ["ACE_microDAGR",1];
	_extraItems pushBack ["ACE_MapTools",1];
};

_medicCode = {
	_vest = "rhsusf_spc_corpsman";
	_helmet = MEDIC_HELMET;
	_backPack = BAGBIG;
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

_facCode = {
	SPECIAL_TFR_LR;
	SPECIAL_ACRE_LR;
	_LinkItems pushBack "ItemGPS";
	_binoculars = "Laserdesignator";
	_ExtraItems pushBack ["Laserbatteries",1];
};

// inf
_slCode = {
	_helmet = 'rhsusf_lwh_helmet_marpatd_headset';
	_vest = "rhsusf_spc_squadleader";
	_ExtraItems pushBack [NADE_SMOKE,2];
	_LinkItems pushBack "ItemGPS";
	_binoculars = "Laserdesignator";
	_ExtraItems pushBack ["Laserbatteries",1];
	_primaryAttachments pushBack RCO;

};

_tlCode = {
	_vest = "rhsusf_spc_squadleader";
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
	_vest = "rhsusf_spc_corpsman";
	_backPack = BAGBIG;
	_ExtraItems pushBack [NADE_SMOKE,2];
	_ExtraItems pushBack [NADE_SMOKEPURPLE,2];
	_MedicalItems = [
		["ACE_bloodIV",10,true],
		["ACE_morphine",20,true],
		["ACE_epinephrine",20,true],
		["ACE_fieldDressing",30,true]
	];
	_primaryWeapon = _carbineKit;
	_target setUnitTrait ["Medic",true];
};

_latCode = {
	_secondaryWeapon = _latKit;
};
_matCode = {
	_secondaryAttachments pushBack "rhs_weap_optic_smaw";
	_secondaryWeapon = _matKit;
	_primaryWeapon = _carbineKit;
	_backPack = BAGBIG;
};
_matAssCode = {
	_primaryWeapon = _carbineKit;
	_atAmmo = (_matKit select 1);
	_atAmmo set [2,true];
	_extraItems pushBack ["rhs_mag_smaw_SR",1];
	_extraItems pushBack _atAmmo;
	_backPack = BAGBIG;
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
	_backpack = BAGBIG;
	_secondaryWeapon = [HATGUN,[HATAMMO,1]];
};
_hatAssCode = {
	_primaryWeapon = _carbineKit;
	_backpack = BAGBIG;
	_extraItems pushBack [HATAMMO,1,true];
};
_lmgCode = {
	_helmet ='rhsusf_lwh_helmet_marpatd_ess';
	_backPack = BAGMEDIUM;
	_primaryWeapon = _lmgKit;
	_primaryAttachments pushBack 'rhsusf_acc_eotech_552';
};
_lmgAssCode = {
	_binoculars = BINO_1;
	_backPack = BAGMEDIUM;
	_lmgTracers = (_lmgKit select 2) select 0;
	_extraItems pushBack [_lmgTracers,4,true];
};

_mmgCode = {
	_helmet ='rhsusf_lwh_helmet_marpatd_ess';
	_backPack = BAGMEDIUM;
	_primaryWeapon = _mmgKit;
	_primaryAttachments pushBack "rhsusf_acc_ELCAN";
};
_mmgAssCode = {
	_binoculars = BINO_1;
	_primaryWeapon = _carbineKit;
	_backPack = BAGMEDIUM;
	_mmgTracers = (_mmgKit select 2) select 0;
	_extraItems pushBack [_mmgTracers,3,true];
};

_marksmanCode = {
	_handGun = _pistolKit;
	_vest = 'rhsusf_spc_rifleman';
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
	_extraItems append [
		["ACE_Clacker",1],
		["toolKit",1,true],
		["MineDetector",1],
		["DemoCharge_Remote_Mag",2]
	];
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
	_primaryWeapon = _smgKit;
	_primaryAttachments = [];
	_helmet = PILOT_HELMET;
	_backpack = PILOT_BAG;
	_vest = PILOT_VEST;
	_uniform = PILOT_UNI;
};
_heliPilotCode = {
	SPECIAL_TFR_SL;
	SPECIAL_ACRE_SL;
	_primaryWeapon = _smgKit;
	_primaryAttachments = [];
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
	_linkItems pushBack "B_UavTerminal";
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
		["ACE_bloodIV",10,true],
		["ACE_morphine",20,true],
		["ACE_epinephrine",20,true],
		["ACE_fieldDressing",30,true]
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
pistolCargo = [
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
	[RIFLEMAG,30],
	[RIFLEMAG2,20],
	[LMGMAG,10],
	[LMGMAG2,5],
	[MMGMAG,5],
	[MMGMAG2,5],
	[MARKSMANRIFLEMAG,10],
	[MARKSMANRIFLEMAG2,10],
	[((_marksmanKit select 1)select 0),10],
	[((_marksmanKit select 2)select 0),10],
	[((_pistolKit select 1)select 0),5],
	[PISTOL2MAG,5],
	[NADE_HE,10],
	[NADE_SMOKE,10],
	[HATAMMO,5]
];

_ammoBigCargo = [
	[RIFLEMAG,50],
	[RIFLEMAG2,25],
	[LMGMAG,30],
	[LMGMAG2,15],
	[MMGMAG,20],
	[MMGMAG2,10],
	[MARKSMANRIFLEMAG,10],
	[MARKSMANRIFLEMAG2,10],
	[SNIPERMAG,5],
	[SNIPERMAG2,1],
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
	["rhs_mag_an_m14_th3",10],
	["SatchelCharge_Remote_Mag",5],
	[BAGBIG,3,true]
];

_genericCargo = [
	["toolKit",1],
	[BAGMEDIUM,1,true]
];

_medsSmallCargo = [
	["ACE_bloodIV",10],
	["ACE_morphine",20],
	["ACE_epinephrine",20],
	["ACE_fieldDressing",30]
];

_medsCargo = [
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

_custom1Cargo = [
	[_latKit select 0,3]
];
_custom2Cargo = [];
_custom3Cargo = [];

_emptyCargo = [];