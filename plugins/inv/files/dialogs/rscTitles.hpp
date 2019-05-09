// title
// 100 / 62.5

/*
private _display = uiNamespace getVariable ["health_rsc_hud",displayNull];
private _ctrl1 = (_display displayCtrl 6005);

_x = safezoneX;
_y = safezoneY;
_w = safezoneW/40;
_h = safezoneH/25;

_pos = [
(_x + (4.28 *_w)),
(_y + (24.15 *_h)),
(0.1 * _w),
(0.7 * _h)
];

_ctrl ctrlSetPosition _pos;
_ctrl ctrlCommit 0.3;
*/

/*

private _imgPath = [(str missionConfigFile), 0, -15] call BIS_fnc_trimString;
_imgPath = _imgPath + "plugins\health\files\dialogs\hit_12.paa";

with uiNamespace do
{
	ctrl = findDisplay 46 ctrlCreate ["RscPictureKeepAspect", -1];
	ctrl ctrlSetPosition [0,0,1,1];
	private _imgPath = [(str missionConfigFile), 0, -15] call BIS_fnc_trimString;
	_imgPath = _imgPath + "plugins\health\files\dialogs\hit_12.paa";
	ctrl ctrlSetText _imgPath;
	ctrl ctrlCommit 0;
	angle = 0;
	onEachFrame
	{
		with uiNamespace do
		{
			if (angle > 359) then {angle = 0};
			ctrl ctrlSetAngle [angle, 0.5, 0.5];
			angle = angle + 1;
		};
	};
};

ctrlDelete ctrl;
ctrl = findDisplay 46 ctrlCreate ["RscPictureKeepAspect", -1];
ctrl ctrlSetPosition [safezoneX,safezoneY,safezoneW,safezoneH];
imgPath = [(str missionConfigFile), 0, -15] call BIS_fnc_trimString;
imgPath = imgPath + "plugins\health\files\dialogs\hit_";
ctrl ctrlSetText imgPath + '3.paa';
ctrl ctrlCommit 0;
angle = 0;
alpha = 1;
ctrl ctrlSetTextColor [0.5,1,1,0.4];

angle = (player getdir car) - (getdir player);
if (angle < 0) then {
	angle = 360+angle;
};

private _angle = angle;
if (angle > 180) then {_angle = _angle -360};
ctrl ctrlSetText (imgPath+ call {
	if (_angle < 20 && _angle > -20) exitWith {
		'5.paa';
	};
	if (_angle < 60 && _angle > -60) exitWith {
		'4.paa';
	};
	'3.paa';
});

onEachFrame {
	if (angle > 359) then {angle = 0};
	ctrl ctrlSetAngle [angle, 0.5, 0.5];
	ctrl ctrlSetTextColor [0.5,1,1,alpha];
	angle = (player getdir car) - (getdir player);
	if (angle < 0) then {
		angle = 360+angle;
	};

	alpha = alpha - ([0.0025,0.005] select (alpha > 0.3));
	if (alpha < 0) then {ctrlDelete ctrl;onEachFrame {}};
};

	//private _distance = player distance2d car;
	if (_distance < 10) exitWith {
		ctrl ctrlSetText (imgPath + '3.paa');
	};
	if (_distance < 25) exitWith {
		ctrl ctrlSetText (imgPath + '4.paa');
	};
	if (_distance < 50) exitWith {
		ctrl ctrlSetText (imgPath + '6.paa');
	};


*/


/*

 
private _display = uiNamespace getVariable ["health_rsc_hud",displayNull]; 
private _ctrl = (_display displayCtrl 6005); 
 
_x = safezoneX; 
_y = safezoneY; 
_w = safezoneW/40; 
_h = safezoneH/25; 
 
_pos = [ 
(_x + (1.52 * (_w/15*10))), 
(_y + (22.80 *_h)), 
(8.6 * (_w/15*10)), 
(0.7 * _h) 
]; 
 
_ctrl ctrlSetPosition _pos; 
_ctrl ctrlCommit 0.3;

*/

#define GUI_CTRL_W2 (GUI_CTRL_W/15*10)
#define GUI_CTRL_H2 (GUI_CTRL_H/15*10)

class health_rsc_hud
{
	idd = 106000; // Display identification
	enableSimulation = 1; // 1 (true) to allow world simulation to be running in the background, 0 to freeze it
	enableDisplay = 1; // 1 (true) to allow scene rendering in the background
	duration = 10e10; //show for 10 billion seconds
	movingEnable = false;
	name = "health_rsc_hud";

	fadein = 0;
	fadeout = 0;

	onLoad = "uiNamespace setVariable ['health_rsc_hud', (_this select 0)];";
	class controlsBackground {

		class health_background {
			idc = 6102;
			type = CT_STATIC;
			style = ST_PICTURE;

			x = GUI_GRID_X + (0 * GUI_CTRL_W);
			y = (GUI_GRID_Y + (23.44 * GUI_CTRL_H));
			//w = 5  * GUI_CTRL_W;
			//h = 2  * GUI_CTRL_H;
			w = 10.0* GUI_CTRL_W;
			h = 10.0* GUI_CTRL_H;

			sizeEx = GUI_TEXT_SIZE_LARGE; // Text size
			size = GUI_TEXT_SIZE_LARGE; // Text size

			colorBackground[] = {1.0,1.0,1.0,1.0};
			colorText[] = {1.0,1.0,1.0,1.0};
			font = "TahomaB";

			text = "plugins\health\files\dialogs\b3.paa"; // icon

			lineSpacing = 0;
			fixedWidth = 0;
			onLoad = "";
		};
		class health_bar_1
		{
			idc = 6001;
			type = CT_STATIC;
			style = ST_LEFT;
			x = GUI_GRID_X + (1.52 * GUI_CTRL_W2);
			y = GUI_GRID_Y + (24.45 * GUI_CTRL_H);
			//w = 4.28  * GUI_CTRL_W;
			//w = 2.77 * GUI_CTRL_W2;
			w = 2.8 * GUI_CTRL_W2;
			h = 0.7  * GUI_CTRL_H2;

			//x = GUI_GRID_X + (1.42 * GUI_CTRL_W);
			//y = GUI_GRID_Y + (24.25 * GUI_CTRL_H);
			//w = 2.5  * GUI_CTRL_W;
			//h = 1  * GUI_CTRL_H;

			sizeEx = GUI_TEXT_SIZE_LARGE; // Text size
			size = GUI_TEXT_SIZE_LARGE; // Text size

			colorBackground[] = {0.8,0.8,0.8,1};
			colorText[] = {0.8,0.8,0.8,1};

			text = "";
			font = "TahomaB";
			class Attributes {
				font = "TahomaB";
				color = "#ff0000";
				align = "center";
				valign = "middle";
				shadow = true;
				shadowColor = "#ffffff";
				size = "1";
			};

			onLoad = "";
		};
		class health_bar_2 : health_bar_1
		{
			idc = 6002;
			x = GUI_GRID_X + (4.45 * GUI_CTRL_W2);
		};
		class health_bar_3 : health_bar_1
		{
			idc = 6003;
			x = GUI_GRID_X + (7.40 * GUI_CTRL_W2);
		};
		class health_bar_4 : health_bar_1
		{
			idc = 6005;
			x = GUI_GRID_X + (1.52 * GUI_CTRL_W2);
			y = GUI_GRID_Y + (23.80 * GUI_CTRL_H);

			// from helmet
			//w = 5.7 * GUI_CTRL_W2;
			w = 8.6 * GUI_CTRL_W2;
		};
		class health_bar_5 : health_bar_4
		{
			idc = 6006;
			x = GUI_GRID_X + (7.6 * GUI_CTRL_W2);
			y = GUI_GRID_Y + (23.80 * GUI_CTRL_H);
			
			// from helmet
			//w = 2.4 * GUI_CTRL_W2;
			w = 0 * GUI_CTRL_W2;
		};
		/*
		class health_background_armor
		{
			idc = 6004;
			type = CT_STATIC;
			style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;

			x = GUI_GRID_X - (0.75 * GUI_CTRL_W);
			y = GUI_GRID_Y + (22.75 * GUI_CTRL_H);
			//w = 5  * GUI_CTRL_W;
			//h = 2  * GUI_CTRL_H;
			w = 15.0* GUI_CTRL_W;
			h = 15.0* GUI_CTRL_H;

			sizeEx = GUI_TEXT_SIZE_LARGE; // Text size
			size = GUI_TEXT_SIZE_LARGE; // Text size

			colorBackground[] = {1.0,1.0,1.0,1.0};
			colorText[] = {1.0,1.0,1.0,1.0};
			font = "TahomaB";

			text = "plugins\health\files\dialogs\a3.paa"; // icon

			lineSpacing = 0;
			fixedWidth = 0;
			onLoad = "";
		};
		*/
	};
	class Controls // Main controls
	{
		/*
		class health_text
		{
			idc = 6002;
			type = CT_STATIC;
			style = ST_CENTER;


			x = GUI_GRID_X + (0.50 * GUI_CTRL_W);
			y = GUI_GRID_Y + (22.75 * GUI_CTRL_H);
			//w = 5  * GUI_CTRL_W;
			//h = 2  * GUI_CTRL_H;
			w = 2* GUI_CTRL_W;
			h = 2* GUI_CTRL_H;

			sizeEx = GUI_TEXT_SIZE_LARGE; // Text size
			size = GUI_TEXT_SIZE_LARGE; // Text size
			font = "TahomaB";

			class Attributes {
				font = "TahomaB";
				color = "#ff0000";
				align = "center";
				valign = "middle";
				shadow = true;
				shadowColor = "#ffffff";
				size = "1";
			};

			colorBackground[] = {1.0,1.0,1.0,0.0};
			colorText[] = {1.0,1.0,1.0,1.0};

			text = "HP"; // Displayed text

			lineSpacing = 0;
			fixedWidth = 0;
			onLoad = "";
		};
		class health_text_armor : health_text
		{
			idc = 6003;

			x = GUI_GRID_X + (3.50 * GUI_CTRL_W);

			colorText[] = {1.0,1.0,1.0,1.0};

			text = "AP"; // Displayed text
		};
		*/

		class health_foreground {
			idc = 6101;
			type = CT_STATIC;
			style = ST_PICTURE;

			x = GUI_GRID_X + (0 * GUI_CTRL_W);
			y = (GUI_GRID_Y + (23.44 * GUI_CTRL_H));
			//w = 5  * GUI_CTRL_W;
			//h = 2  * GUI_CTRL_H;
			w = 10.0* GUI_CTRL_W;
			h = 10.0* GUI_CTRL_H;

			sizeEx = GUI_TEXT_SIZE_LARGE; // Text size
			size = GUI_TEXT_SIZE_LARGE; // Text size

			colorBackground[] = {1.0,1.0,1.0,1.0};
			colorText[] = {1.0,1.0,1.0,1.0};
			font = "TahomaB";

			text = "plugins\health\files\dialogs\a6.paa"; // icon

			lineSpacing = 0;
			fixedWidth = 0;
			onLoad = "";
		};
		class health_itemsText
		{
			idc = 6201;
			type = CT_STATIC;
			style = ST_LEFT;

			x = GUI_GRID_X + (8 * GUI_CTRL_W);
			y = GUI_GRID_Y + (23.39 * GUI_CTRL_H);
			//w = 5  * GUI_CTRL_W;
			//h = 2  * GUI_CTRL_H;
			w = 2* GUI_CTRL_W;
			h = 2* GUI_CTRL_H;

			sizeEx = GUI_TEXT_SIZE_MEDIUM; // Text size
			size = GUI_TEXT_SIZE_MEDIUM; // Text size
			font = "PuristaBold";

			class Attributes {
				font = "PuristaBold";
				color = "#cccccc";
				align = "center";
				valign = "middle";
				shadow = true;
				shadowColor = "#ffffff";
				size = "1";
			};

			colorBackground[] = {1.0,1.0,1.0,0.0};
			colorText[] = {0.8,0.8,0.8,1.0};

			text = "x0"; // Displayed text

			lineSpacing = 0;
			fixedWidth = 0;
			onLoad = "";
		};
		/*
		class health_bar_2
		{
			idc = 6103;
			type = CT_STATIC;
			style = ST_LEFT;
			x = GUI_GRID_X + (1.51 * GUI_CTRL_W);
			y = GUI_GRID_Y + (20 * GUI_CTRL_H);
			w = 0.1  * GUI_CTRL_W;
			h = 10  * GUI_CTRL_H;

			//x = GUI_GRID_X + (1.42 * GUI_CTRL_W);
			//y = GUI_GRID_Y + (24.25 * GUI_CTRL_H);
			//w = 2.5  * GUI_CTRL_W;
			//h = 1  * GUI_CTRL_H;

			sizeEx = GUI_TEXT_SIZE_LARGE; // Text size
			size = GUI_TEXT_SIZE_LARGE; // Text size

			colorBackground[] = {0.8,0.8,0.8,1};
			colorText[] = {0.8,0.8,0.8,1};

			text = "";
			font = "TahomaB";
			class Attributes {
				font = "TahomaB";
				color = "#ff0000";
				align = "center";
				valign = "middle";
				shadow = true;
				shadowColor = "#ffffff";
				size = "1";
			};

			onLoad = "";
		};
		*/
	};
};
