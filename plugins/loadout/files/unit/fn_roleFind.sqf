/* ----------------------------------------------------------------------------
Function: loadout_fnc_roleFind

Description:
	Determines the role of the unit

Parameters:
0:	_target			- Unit, of which role to get
Returns:
	"role"			- string of the role the unit has
Examples:
	_target call loadout_fnc_roleFind;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
#define DESCFIND(var)		((_roleDesc find (toLower (var)))> -1)
#define DESCIF(var,var2)	if (DESCFIND(var)) exitWith {_role = var2};
//#define TYPEIF(var,var2)	if (_typeName isEqualTo (toLower (var))) exitWith {_role = var2};

#define TYPEIF(var,var2)	if (_typeName find (toLower (var))> -1) exitWith {_role = var2};
// Code begins

params ["_target"];

if (isNil "_target" || {isNull _target} || {!(_target isKindOf "CAManBase")}) exitWith {};

_role = "";
private _roleDesc = toLower (roleDescription _target);

call {
	if (_roleDesc isEqualTo "") exitWith {""};

	if DESCFIND("recon") exitWith {
		private _nil = {
			DESCIF(_x select 0,_x select 1)
			false
		} count [
			["Squad","reconSl"],
			["scout","reconScout"],
			["at","reconLat"],
			["mark","reconMarksman"],
			["demo","reconDemo"],
			["team","reconTl"],
			["para","reconParamedic"]
		];
		"reconScout"
	};

	private _nil = {
		DESCIF(_x select 0,_x select 1)
		false
	} count [
		["platoon leader","officer"],
		["platoon command","officer"],

		["platoon medic","medic"],

		["FAC","fac"],

		["squad leader","sl"],
		["team leader","tl"],

		["anti-tank ass","matAss"],
		["mata","matAss"],
		["mat a","matAss"],
		["medium at a","matAss"],
		["medium anti-tank a","matAss"],

		["anti-tank","mat"],
		["mat","mat"],
		["medium at","mat"],
		["medium anti","mat"],

		["param","paramedic"],

		["light machine gunner ass","lmgAss"],
		["light mg ass","lmgAss"],
		["lmg ass","lmgAss"],
		["lmga","lmgAss"],
		["autorifleman ass","lmgAss"],

		["light machine gunner","lmg"],
		["light machine","lmg"],
		["lmg","lmg"],
		["autorifleman","lmg"],

		["rifleman (at)","lat"],
		["rifleman(at)","lat"],
		["light anti","lat"],
		["lat","lat"],

		["mark","marksman"],

		["Gren","grenadier"],
		["gran","grenadier"],
		["GL","grenadier"],

		["pointman","pointman"],
		["rifleman","rifleman"],

		["crew","crew"],

		["pil","pilot"],

		["heli","helipilot"],

		["engi","engineer"],

		["expl","demo"],
		["demo","demo"],

		["uav","uav"],

		["snip","sniper"],
		["spot","spotter"],
		["div","diver"],

		["mortar a","mortarAss"],
		["mortar","mortar"],

		["hmg a","hmgAss"],
		["heavy mg a","hmgAss"],
		["heavy macine gun a","hmgAss"],

		["hmg","hmg"],
		["heavy mg","hmg"],
		["heavy machine gu","hmg"],

		["gmg a","gmgAss"],
		["grenade mg a","gmgAss"],
		["grenade machine gun a","gmgAss"],

		["gmg","gmg"],
		["grenade mg","gmg"],
		["grenade mac","gmg"],

		["hat a","hatAss"],
		["heavy at a","hatAss"],
		["heavy anti-tank a","hatAss"],

		["hat","hat"],
		["heavy at","hat"],
		["heavy anti","hat"],

		["anti-air a","aaAss"],
		["aa a","aaAss"],

		["aa","aa"],
		["anti-air","aa"]
	];
	"rifleman"
};

if !(_role isEqualTo "") exitWith {_role};

private _typeName = toLower (getText(configfile >> "CfgVehicles" >> typeOf _target >> "displayName"));

if (_typeName isEqualTo "") exitWith {"rifleman"};

call {
	private _nil = {
		TYPEIF(_x select 0,_x select 1)
		false
	} count [

		["uav operator","fac"],

		["recon jtac","reconsl"],
		["scout (s","reconsl"],

		["recon scout","reconscout"],
		["operator (light)","reconscout"],

		["recon scout (at)","reconlat"],
		["operator (CQB)","reconlat"],
		["scout (m136","reconlat"],

		["recon mark","reconmarksman"],
		["scout","reconmarksman"],

		["recon demo specialist","recondemo"],

		["recon team","recontl"],
		["team chief","recontl"],
		["scout (t","reconsl"],

		["recon paramedic","reconparamedic"],
		["sarc paramedic","reconparamedic"],

		["operator","reconscout"],
		["recon","reconscout"],

		["officer","officer"],
		["warlord","officer"],

		["combat life saver","medic"],
		["bonesetter","medic"],
		["medic","medic"],
		["corps","medic"],

		["fire supp","fac"],
		["joint fi","fac"],
		["jtac","fac"],

		["team leader","tl"],
		["junior sergeant","tl"],
		["efreitor","tl"],

		["squad leader","sl"],
		["sergeant","sl"],


		["missile specialist (at)","mat"],
		["rpg-7","mat"],
		["AT Specialist (j","hat"],
		["AT Spec","mat"],
		["smaw","mat"],

		["Asst. Missile Specialist (AT)","matAss"],
		["grenadier ass","matAss"],
		["anti tank ass","matAss"],
		["at assistant (j","hatAss"],

		["missile specialist (aa)","aa"],

		["Asst. Missile Specialist (aa)","aaAss"],

		["Asst. autorifleman","lmgAss"],
		["auto rifleman Ass","lmgAss"],

		["ammo bear","lmgAss"],

		["autorifleman","lmg"],
		["auto rifleman","lmg"],


		["rifleman (at)","lat"],
		["rpg-26","lat"],
		["rshg-2","lat"],
		["m136","lat"],
		["m72","lat"],

		["marksman","marksman"],
		["lee","marksman"],

		["grenadier","grenadier"],
		["gp-","grenadier"],

		["rifleman (light)","pointman"],
		["breach","pointman"],

		["rifleman","rifleman"],

		["crewman","crew"],
		["driver","crew"],

		["heli","helipilot"],
		["trans","helipilot"],

		["pilot","pilot"],

		["engineer","engineer"],
		["mechanic","engineer"],

		["explosive specialist","demo"],
		["bomber","demo"],
		["eod","demo"],

		["sniper","sniper"],

		["spotter","spotter"],

		["assault diver","diver"],

		["asst. gunner (mk6)","mortarAss"],

		["gunner (mk6)","mortar"],

		["asst. gunner (hmg/gmg)","hmgAss"],

		["gunner (hmg)","hmg"],

		["gunner (gmg)","gmg"],

		["hat a","hatAss"],

		["heavy anti","hat"],

		["machine gun","mmg"],
		["240","mmg"],

		["gunner ass","mmgAss"],

		["anti air","aa"],
		["aa","aa"]

	];
};

if (_role isEqualTo "") exitWith {"rifleman"};
_role