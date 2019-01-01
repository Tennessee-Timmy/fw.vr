/* ----------------------------------------------------------------------------
Function: shop_fnc_buyMenu

Description:
	Closes the buy menu display and creates a new one

Parameters:
0:	_close		- true to open false to close

Returns:
	nothing
Examples:
	// close the menu
	[true] call shop_fnc_buyMenu;
Author:
	nigel
---------------------------------------------------------------------------- */
#include "script_component.cpp"
// Code begins
disableSerialization;

params [['_close',false,[true]]];

// get the old display
private _display = uiNamespace getVariable ['mission_shop_display',displayNull];

// close the old display
_display closeDisplay 1;


// exit if only close
if (_close) exitWith {

	// nothing
};


// check the condition for using the shop
if !(missionNamespace getVariable ['mission_shop_open',false]) exitWith {
	systemChat 'The shop cannot be accessed right now.';
};

// create a new display and save it
_display = call menus_fnc_addDisplay;
uiNamespace setVariable ['mission_shop_display',_display];

// positions for UI
// left side / start
private _xPos = 3;
private _yPos = 3;

// right side / end
private _xPos2 = 37;
private _yPos2 = 22;

// add the elements
private _ctrlGroup = [[0,0,40,25],1000,_display] call menus_fnc_addGroup;
private _ctrlBG = [[0.4,0.7,0.4,1],[3,3,34,19],1001,_display,_ctrlGroup] call menus_fnc_addBackground;
private _ctrlBG2 = [[1,1,1,0.3],[0,0,40,3],1002,_display,_ctrlGroup] call menus_fnc_addBackground;
private _ctrlTitle = ["BUY MENU",[15,3,10,1.5],true,1003,_display,_ctrlGroup]call menus_fnc_addTitle;
private _ctrlButtonClose = ["X",[36,3,1,1],"[true] call shop_fnc_buyMenu",1010,_display,_ctrlGroup] call menus_fnc_addButton;

// buttons for guns


private _lasttButtonId = 1010;
private _fn_getButtonId = {_lasttButtonId = _lasttButtonId + 1;_lasttButtonId};

private _fn_addButton = {
	params ['_name','_pos','_data','_price'];

	private _ctrl = [(_name + ' - $' + str _price),_pos,(compile ("
		[player," + (str _price) + ",{
			params [['_unit',objNull]];
			[player, '" + (_data#0) + "', '" + (_data#1) + "'," + str(_data#2) + ",true] call shop_fnc_buyWeapon;
			[player, '" + (_data#0) + "'," + (str (_data param [3,6])) + "] call shop_fnc_buyAmmo;
		}] call shop_fnc_buy;
	")),(call _fn_getButtonId),_display,_ctrlGroup] call menus_fnc_addButton;

	private _type = _data#0;
	private _condCode = call {
		_type = call {
			if (_type isEqualTo 'primary' || _type isEqualTo 'rifle') exitWith {
				"primaryWeapon"
			};

			if (_type isEqualTo 'handgun' || _type isEqualTo 'pistol') exitWith {
				"handgunWeapon"
			};

			if (_type isEqualTo 'secondary' || _type isEqualTo 'launcher') exitWith {
				"secondaryWeapon"
			};
		};

		// return string
		compile ("(" + _type + " player) isEqualTo '" + _data#1 + "'")
	};

	[_ctrl,_condCode, _price]
};

// --- pistols
private _ctrlTitlePistols = ["Pistols",[4,4.5,6,1.5],true,-1,_display,_ctrlGroup]call menus_fnc_addTitle;
private _buttonArr = [
	[

		(['MP-443','Makarov'] select (player getVariable ['unit_bomber',false])),
		[4,6,6,1],
		[
			'pistol',
			(['hgun_Rook40_F','hgun_Pistol_01_F'] select (player getVariable ['unit_bomber',false])),
			[]
		],
		200
	],
	[
		'P99',
		[4,7.5,6,1],
		['pistol','hgun_P07_F',[]],
		500
	],
	[
		'Revolver',
		[4,9,6,1],
		['pistol','hgun_Pistol_heavy_02_F',[]],
		700
	],
	[
		'.45 Tactical',
		[4,10.5,6,1],
		['pistol','hgun_Pistol_heavy_01_F',['optic_MRD']],
		800
	]
] apply {
	_x call _fn_addButton
};

// --- SMG
private _yPosSmg = 11.5;
private _fn_smgPos = {_yPosSmg = _yPosSmg + 1.5;_yPosSmg};
private _ctrlTitleSMGs = ["SMGs",[4,(call _fn_smgPos),6,1.5],true,-1,_display,_ctrlGroup]call menus_fnc_addTitle;
_buttonArr append ([
	[
		'CPW',
		[4,(call _fn_smgPos),6,1],
		['primary','hgun_PDW2000_F',['optic_ACO_grn_smg']],
		1400
	],
	[
		'MP5',
		[4,(call _fn_smgPos),6,1],
		['primary','SMG_05_F',['optic_Aco_smg']],
		1700
	],
	[
		'Vector',
		[4,(call _fn_smgPos),6,1],
		['primary','SMG_01_F',['optic_ACO_grn_smg']],
		2000
	],
	[
		'Skorpion(S)',
		[4,(call _fn_smgPos),6,1],
		['primary','SMG_02_F',['muzzle_snds_L','optic_ACO_grn_smg']],
		2200
	]
] apply {
	_x call _fn_addButton
});




// --- Rifles
private _yPosR = 3;
private _fn_rPos = {_yPosR = _yPosR + 1.5;_yPosR};
private _ctrlTitleRs = ["Rifles",[12,(call _fn_rPos),6,1.5],true,-1,_display,_ctrlGroup]call menus_fnc_addTitle;
_buttonArr append ([
	[
		(['CTAR','AKS-74U'] select (player getVariable ['unit_bomber',false])),
		[12,(call _fn_rPos),6,1],
		[
			'primary',
			(['arifle_TRG20_F','arifle_AKS_F'] select (player getVariable ['unit_bomber',false])),
			[]
		],
		2200
	],
	[
		(['M416','AKM'] select (player getVariable ['unit_bomber',false])),
		[12,(call _fn_rPos),6,1],

		([
		 	['primary','arifle_SPAR_01_blk_F',['optic_holosight_smg_khk_f']],
		 	['primary','arifle_AKS_F',[]]
		] select (player getVariable ['unit_bomber',false])),
		2700
	],
	[
		'M14(DMS)',
		[12,(call _fn_rPos),6,1],
		['primary','srifle_DMR_06_camo_F',['optic_DMS']],
		4000
	],
	[
		'GM6',
		[12,(call _fn_rPos),6,1],
		['primary','srifle_GM6_F',['optic_LRPS']],
		4700
	]
] apply {
	_x call _fn_addButton
});


// --- Armor
private _fn_addButtonA = {
	params ['_name','_pos','_data','_price'];

	private _ctrl = [(_name + ' - $' + str _price),_pos,(compile ("
		[player," + (str _price) + ",{
			params [['_unit',objNull]];
			[player, '" + (_data#1) + "', '" + (_data#2) + "'] call shop_fnc_buyArmor;
		}] call shop_fnc_buy;
	")),(call _fn_getButtonId),_display,_ctrlGroup] call menus_fnc_addButton;

	private _type = _data#0;
	private _code = call {
		private _condCode = 'false';
		private _condCode2 = 'true';
		call {
			if (_type isEqualTo 'vest') exitWith {
				_condCode = "(vest player) isEqualTo '" + _data#1 + "'";
			};

			if (_type isEqualTo 'helmet') exitWith {
				_condCode = "(headgear player) isEqualTo '" + _data#2 + "'";
			};

			if (_type isEqualTo 'both') exitWith {
				_condCode = "(vest player) isEqualTo '" + _data#1 + "'";
				_condCode2 = "(headgear player) isEqualTo '" + _data#2 + "'";
			};
		};

		// return string
		compile ("(" + _condCode + ") && (" + _condCode2 + ")")
	};

	[_ctrl,_code, _price]
};

private _yPosA = 11.5;
private _fn_aPos = {_yPosA = _yPosA + 1.5;_yPosA};
private _ctrlTitleRs = ["Armor",[12,(call _fn_aPos),6,1.5],true,-1,_display,_ctrlGroup]call menus_fnc_addTitle;

	/*[
		'Light',
		[12,(call _fn_aPos),6,1],
		['vest','V_HarnessO_brn',''],
		600
	],*/



// todo make ct armor and weapons
_buttonArr append ([
   [
		'Light',
		[12,(call _fn_aPos),6,1],
		['vest',(['V_TacVest_blk_POLICE','V_TacVest_camo'] select (player getVariable ['unit_bomber',false])),''],
		600
	],
	[
		'Medium',
		[12,(call _fn_aPos),6,1],
		[
			'both',
			(['V_TacVest_blk_POLICE','V_TacVest_camo'] select (player getVariable ['unit_bomber',false])),
			(['H_Helmet_Skate','H_HelmetIA'] select (player getVariable ['unit_bomber',false]))
			//'H_HelmetIA'
		],
		1200
	],
	[
		'Heavy',
		[12,(call _fn_aPos),6,1],
		[
			'both',
			(['V_PlateCarrier1_blk','V_PlateCarrier1_rgr'] select (player getVariable ['unit_bomber',false])),
			(['H_CrewHelmetHeli_B','H_CrewHelmetHeli_O'] select (player getVariable ['unit_bomber',false]))
		],
		2400
	],
	[
		'Special',
		[12,(call _fn_aPos),6,1],
		[
			'both',
			(['V_PlateCarrierSpec_blk','V_PlateCarrierSpec_rgr'] select (player getVariable ['unit_bomber',false])),
			(['H_HelmetSpecO_blk','H_HelmetSpecO_ocamo'] select (player getVariable ['unit_bomber',false]))
		],
		4000
	]
] apply {
	_x call _fn_addButtonA
});


// terrorist guns
//V_TacVest_blk_POLICE



// buttons for Ammo
private _xPosAmmo = _xPos2 - 7;
private _ctrlTitleAmmo = ["Ammo",[_xPosAmmo,4.5,6,1.5],true,-1,_display,_ctrlGroup]call menus_fnc_addTitle;
private _ctrlButtonAmmo1 = ["Primary - $250",[_xPosAmmo,6,6,1],{
	[player,250,{
		params [['_unit',objNull]];
		[player,'primary',6] call shop_fnc_buyAmmo;
	}] call shop_fnc_buy;
},1051,_display,_ctrlGroup] call menus_fnc_addButton;
private _ctrlButtonAmmo2 = ["Pistol - $50",[_xPosAmmo,7.5,6,1],{
	[player,50,{
		params [['_unit',objNull]];
		[player,'handgun',6] call shop_fnc_buyAmmo;
	}] call shop_fnc_buy;
},1052,_display,_ctrlGroup] call menus_fnc_addButton;

_buttonArr append [
	[_ctrlButtonAmmo1,{false},250],
	[_ctrlButtonAmmo2,{false},50]
];


// buttons for armour
// button for ammo

// money display
private _ctrlMoney = ["$0",[_xPos,_yPos,8,1.5],false,1090,_display,_ctrlGroup]call menus_fnc_addTitle;

// a bar on the top that is a wait time between transactions
// text transaction in progress

private _sliderPos = [_xPos,_yPos-1,0,1];
private _ctrlSliderTimeout = [[0.9,0.2,0.2,1],_sliderPos,1091,_display,_ctrlGroup] call menus_fnc_addBackground;
private _ctrlTitleTimeout = ["Please wait between transactions",[_xPos+10,_yPos-1,14,1.5],false,-1,_display,_ctrlGroup]call menus_fnc_addTitle;

private _GUI_GRID_W = (safezoneW / 40);
private _GUI_GRID_H = (safezoneH / 25);

// position for no bar showing
_sliderPos = [
	(0 + (_sliderPos#0 * _GUI_GRID_W)),
	(0 + (_sliderPos#1 * _GUI_GRID_H)),
	(_sliderPos#2 * _GUI_GRID_W),
	(_sliderPos#3 * _GUI_GRID_H)
];

// position for all of the bar showing
private _sliderPosHi = + _sliderPos;
_sliderPosHi set [2, (34 * _GUI_GRID_W)];

//_ctrlSliderTimeout ctrlSetPosition _sliderPosHi;


// icon test
private _ctrlPistol = [(''),[3,-0.2,4,3],false,1101,_display,_ctrlGroup]call menus_fnc_addTitle;
private _ctrlRifle = [(''),[7,-0.2,4,3],false,1102,_display,_ctrlGroup]call menus_fnc_addTitle;
private _ctrlLauncher = [(''),[11,-0.2,4,3],false,1103,_display,_ctrlGroup]call menus_fnc_addTitle;
private _ctrlVest = [(''),[14,0,4,3],false,1104,_display,_ctrlGroup]call menus_fnc_addTitle;
private _ctrlHelmet = [(''),[18,0,4,3],false,1105,_display,_ctrlGroup]call menus_fnc_addTitle;

private _ctrlItemsArr = [
	[_ctrlPistol,{handgunWeapon player}],
	[_ctrlRifle,{primaryWeapon player}],
	[_ctrlLauncher,{secondaryWeapon player}],
	[_ctrlVest,{vest player}],
	[_ctrlHelmet, {headgear player}]
];

// spawn the loop
[_display,_ctrlSliderTimeout,_sliderPos,_sliderPosHi,_buttonArr,_ctrlMoney,_ctrlItemsArr,_ctrlTitleTimeout] spawn {
	disableSerialization;

	params ['_display','_ctrlSliderTimeout','_sliderPos','_sliderPosHi','_buttonArr','_ctrlMoney','_ctrlItemsArr','_ctrlTitleTimeout'];

	private _exit = false;

	private _uid = getPlayerUID player;
	private _varName = ('mission_shop_' + _uid + '_money');
	private _lastMoney = 0;

	// run this loop every frame
	waitUntil {

		// run code in unscheduled
		isNil {

			// if the display is closed, exit the loop
			if (isNull _display) exitWith {_exit = true;};

			// check the condition for using the shop
			if !(missionNamespace getVariable ['mission_shop_open',true]) exitWith {};

			// items array
			{
				_x params ['_ctrl','_code',['_lastResult','']];
				private _result = call _code;

				if !(_result isEqualTo _lastResult) then {
					_ctrl ctrlSetStructuredText parseText ("<img image='" + getText (configFile >> 'CfgWeapons' >> _result >> 'picture') + "' align='center' valing='middle' size='1.5'/>");
					_x set [2,_result];
					_ctrlItemsArr set [_forEachIndex,_x];
				};
				false
			} forEach _ctrlItemsArr;


			// check player money (for turning buttons off)
			private _playerMoney = missionNamespace getVariable [_varName,(missionNamespace getVariable ['mission_shop_moneyDefault',800])];

			if !(_playerMoney isEqualTo _lastMoney) then {
				_ctrlMoney ctrlSetStructuredText (parseText ('<t align = "left">Money: $ '+ str _playerMoney + '</t>'));
				_lastMoney = _playerMoney;
			};

			// check buttons
			{
				_x params ['_ctrl','_cond','_price'];
				call {

					// should the ctrl be enabled?
					private _shouldBeEnabled = call {
						if (_playerMoney < _price) exitWith {false};
						if (call _cond) exitWith {false};
						true
					};

					// if ctrl is enabled
					if (ctrlEnabled _ctrl) exitWith {

						// and it should not be enabled
						if (!_shouldBeEnabled) then {
							_ctrl ctrlEnable false;
						};
					};

					// ctrl is not enabled:
					// if it should be enabled, enable it
					if (_shouldBeEnabled) then {
						_ctrl ctrlEnable true;
					};
				};
				false
			} count _buttonArr;


			// check the time for the next purchase
			private _nextBuyTime = missionNamespace getVariable ['mission_shop_nextPurchase',(CBA_Missiontime)];

			// if next buy time is equal or smaller than current time, open the buttons
			if (_nextBuyTime <= CBA_Missiontime) exitWith {


				_ctrlTitleTimeout ctrlShow false;
				//_display call shop_fnc_buyMenuOpen;
				// hint 'buy menu open';

				//_ctrlSliderTimeout ctrlSetPosition _sliderPos;
				//_ctrlSliderTimeout ctrlCommit 0;

			};

			// at this point the buy menu should be closed
			private _timeUntilOpen = _nextBuyTime - CBA_Missiontime;

			private _nextSliderAction = missionNamespace getVariable ['mission_shop_sliderNextAction',CBA_Missiontime];

			// if we have not reached the next action time, exit
			if (_nextSliderAction > CBA_Missiontime) exitWith {};

			// set the slider to the right side
			_ctrlSliderTimeout ctrlSetPosition _sliderPosHi;
			_ctrlSliderTimeout ctrlCommit 0;

			_ctrlTitleTimeout ctrlShow true;
			_ctrlTitleTimeout ctrlEnable true;


			[_ctrlSliderTimeout,_sliderPos,_timeUntilOpen] spawn {
					disableSerialization;
					params ['_ctrlSliderTimeout','_sliderPos','_timeUntilOpen'];
					// let the slider slowly come back
					_ctrlSliderTimeout ctrlSetPosition _sliderPos;
					_ctrlSliderTimeout ctrlCommit _timeUntilOpen;
			};
			missionNamespace setVariable ['mission_shop_sliderNextAction',_nextBuyTime];

		};
		(_exit)
	};
};


// a loop that checks the money and disables buttons.




