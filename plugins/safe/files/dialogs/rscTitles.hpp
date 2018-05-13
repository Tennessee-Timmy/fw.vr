// template
class safe_template : menus_template_title
{
	idc = 5999; // Control identification (without it, the control won't be displayed)
	style = ST_CENTER + ST_VCENTER;

	x = GUI_GRID_X + (30 * GUI_CTRL_W);
	y = GUI_GRID_Y + (20 * GUI_CTRL_H);
	w = 5  * GUI_CTRL_W;
	h = 2  * GUI_CTRL_H;

	sizeEx = GUI_TEXT_SIZE_LARGE; // Text size
	size = GUI_TEXT_SIZE_LARGE; // Text size
	font = "TahomaB";

	colorBackground[] = {0.1,0.1,0.1,0.7};

	text = "SAFE PLUGIN"; // Displayed text
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

// title
class safe_rsc_hud
{
	idd = 105000; // Display identification
	enableSimulation = 1; // 1 (true) to allow world simulation to be running in the background, 0 to freeze it
	enableDisplay = 1; // 1 (true) to allow scene rendering in the background
	duration = 10e10; //show for 10 billion seconds
	movingEnable = false;
	name = "safe_rsc_hud";

	fadein = 0;
	fadeout = 0;

	onLoad = "uiNamespace setVariable ['safe_rsc_hud', (_this select 0)];";
	class controlsBackground {
		class safe_background : safe_template
		{
			idc = 5001;

			x = GUI_GRID_X + (29.75 * GUI_CTRL_W);
			y = GUI_GRID_Y + (17.75 * GUI_CTRL_H);
			w = 2.5  * GUI_CTRL_W;
			h = 2.5  * GUI_CTRL_H;

			sizeEx = GUI_TEXT_SIZE_LARGE; // Text size
			size = GUI_TEXT_SIZE_LARGE; // Text size

			colorBackground[] = {0.1,0.1,0.1,0.7};

			text = ""; // Displayed text
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
	};
	class Controls // Main controls
	{
		class safe_icon : safe_template
		{
			idc = 5002;
			type = CT_STATIC;
			style = ST_PICTURE;

			x = GUI_GRID_X + (30 * GUI_CTRL_W);
			y = GUI_GRID_Y + (18 * GUI_CTRL_H);
			//w = 5  * GUI_CTRL_W;
			//h = 2  * GUI_CTRL_H;
			w = 2* GUI_CTRL_W;
			h = 2* GUI_CTRL_H;

			sizeEx = GUI_TEXT_SIZE_LARGE; // Text size
			size = GUI_TEXT_SIZE_LARGE; // Text size

			colorBackground[] = {1.0,1.0,1.0,0.0};
			colorText[] = {1.0,1.0,1.0,1.0};

			text = ""; // icon

			lineSpacing = 0;
			fixedWidth = 0;
			onLoad = "";
		};
	};
};
