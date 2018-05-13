//
class respawn_timer: menus_template_title
{
	idc = 1001;
	style = ST_CENTER + ST_VCENTER;

	x = GUI_GRID_X + (15 * GUI_CTRL_W);
	y = GUI_GRID_Y + (3 * GUI_CTRL_H);
	w = 10  * GUI_CTRL_W;
	h = 5  * GUI_CTRL_H;

	sizeEx = GUI_TEXT_SIZE_MEDIUM; // Text size

	colorBackground[] = {0.3,0.3,0.3,0};
	text = "";

	class Attributes {
		font = "RobotoCondensed";
		color = "#ff0000";
		align = "center";
		valign = "middle";
		shadow = true;
		shadowColor = "#ffffff";
		size = "1";
	};
};

// template
class respawn_template : respawn_timer
{
	idc = 2999; // Control identification (without it, the control won't be displayed)
	style = ST_CENTER + ST_VCENTER;

	x = GUI_GRID_X + (15 * GUI_CTRL_W);
	y = GUI_GRID_Y + (1 * GUI_CTRL_H);
	w = 10  * GUI_CTRL_W;
	h = 1.5  * GUI_CTRL_H;

	sizeEx = GUI_TEXT_SIZE_LARGE; // Text size
	size = GUI_TEXT_SIZE_LARGE; // Text size

	colorBackground[] = {0.1,0.1,0.1,0.7};

	text = "You Are Dead"; // Displayed text
	class Attributes {
		font = "TahomaB";
		color = "#ff0000";
		align = "center";
		valign = "middle";
		shadow = true;
		shadowColor = "#ffffff";
		size = "1";
	};

	onLoad = "_this spawn {sleep 1;(_this select 0) ctrlSetFade 1;(_this select 0) ctrlCommit 1;};";
};

// title
class respawn_rsc_deadTitle
{
	idd = 103000; // Display identification
	enableSimulation = 1; // 1 (true) to allow world simulation to be running in the background, 0 to freeze it
	enableDisplay = 1; // 1 (true) to allow scene rendering in the background
	duration = 10e10; //show for 10 billion seconds
	movingEnable = false;
	name = "respawn_rsc_deadTitle";

	fadein = 0;
	fadeout = 0;

	onLoad = "uiNamespace setVariable ['respawn_rsc_deadTitle', (_this select 0)];";
	class Controls // Main controls
	{
		class respawn_deadTitle : respawn_template
		{
			idc = 2001;
			x = GUI_GRID_X + (15 * GUI_CTRL_W);
			y = GUI_GRID_Y + (1 * GUI_CTRL_H);
			w = 10  * GUI_CTRL_W;
			h = 1.5  * GUI_CTRL_H;

			sizeEx = GUI_TEXT_SIZE_LARGE; // Text size
			size = GUI_TEXT_SIZE_LARGE; // Text size

			colorBackground[] = {0.1,0.1,0.1,0.7};

			text = "You Are Dead"; // Displayed text
			class Attributes {
				font = "TahomaB";
				color = "#ff0000";
				align = "center";
				valign = "middle";
				shadow = true;
				shadowColor = "#ffffff";
				size = "1";
			};

			onLoad = "_this spawn {sleep 3;(_this select 0) ctrlSetFade 1;(_this select 0) ctrlCommit 2;};";
		};
	};
};

class respawn_rsc_deadMid
{
	idd = 103001; // Display identification
	enableSimulation = 1; // 1 (true) to allow world simulation to be running in the background, 0 to freeze it
	enableDisplay = 1; // 1 (true) to allow scene rendering in the background
	duration = 10e10; //show for 10 billion seconds
	movingEnable = false;
	name = "respawn_rsc_deadMid";

	fadein = 0;
	fadeout = 0;

	onLoad = "uiNamespace setVariable ['respawn_rsc_deadMid', (_this select 0)];";
	class Controls // Main controls
	{
		class respawn_deadTextmid: respawn_template
		{
			idc = 2003;
			style = ST_CENTER + ST_VCENTER;

			x = GUI_GRID_X + (12.5 * GUI_CTRL_W);
			y = GUI_GRID_Y + (5 * GUI_CTRL_H);
			w = 15  * GUI_CTRL_W;
			h = 0  * GUI_CTRL_H;

			sizeEx = GUI_TEXT_SIZE_MEDIUM; // Text size
			size = GUI_TEXT_SIZE_MEDIUM; // Text size

			colorBackground[] = {0.1,0.1,0.1,0.7};
			text = "";
			class Attributes {
				font = "RobotoCondensed";
				color = "#ffffff";
				align = "center";
				valign = "middle";
				shadow = true;
				shadowColor = "#000000";
				size = "1";
			};

			onLoad = "_this spawn {(_this select 0) ctrlSetFade 1;(_this select 0) ctrlCommit 0;};";
		};
	};
};

class respawn_rsc_deadSide
{
	idd = 103002; // Display identification
	enableSimulation = 1; // 1 (true) to allow world simulation to be running in the background, 0 to freeze it
	enableDisplay = 1; // 1 (true) to allow scene rendering in the background
	duration = 10e10; //show for 10 billion seconds
	movingEnable = false;
	name = "respawn_rsc_deadSide";

	fadein = 0;
	fadeout = 0;

	onLoad = "uiNamespace setVariable ['respawn_rsc_deadSide', (_this select 0)];";
	class Controls // Main controls
	{
		class respawn_deadTextSide: respawn_template
		{
			idc = 2002;
			style = ST_CENTER + ST_VCENTER;

			x = GUI_GRID_X + (29.5 * GUI_CTRL_W);
			y = GUI_GRID_Y + (3 * GUI_CTRL_H);
			w = 9  * GUI_CTRL_W;
			h = 0  * GUI_CTRL_H;

			sizeEx = GUI_TEXT_SIZE_SMALL; // Text size
			size = GUI_TEXT_SIZE_SMALL; // Text size

			colorBackground[] = {0.1,0.1,0.1,0.8};
			text = "";
			class Attributes {
				font = "PuristaMedium";
				color = "#ffffff";
				align = "center";
				valign = "middle";
				shadow = true;
				shadowColor = "#000000";
				size = "1";
			};

			onLoad = "_this spawn {(_this select 0) ctrlSetFade 1;(_this select 0) ctrlCommit 0;};";
		};
	};
};

