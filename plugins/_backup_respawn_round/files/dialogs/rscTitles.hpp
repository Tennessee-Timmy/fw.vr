// template
class respawn_round_template : menus_template_title
{
	idc = 9999; // Control identification (without it, the control won't be displayed)
	style = ST_CENTER + ST_VCENTER;

	x = GUI_GRID_X + (30 * GUI_CTRL_W);
	y = GUI_GRID_Y + (20 * GUI_CTRL_H);
	w = 5  * GUI_CTRL_W;
	h = 2  * GUI_CTRL_H;

	sizeEx = GUI_TEXT_SIZE_LARGE; // Text size
	size = GUI_TEXT_SIZE_LARGE; // Text size
	font = "TahomaB";

	colorBackground[] = {0.1,0.1,0.1,0.7};

	text = "RESPAWN ROUND PLUGIN"; // Displayed text
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
class respawn_round_rsc_hud
{
	idd = 109000; // Display identification
	enableSimulation = 1; // 1 (true) to allow world simulation to be running in the background, 0 to freeze it
	enableDisplay = 1; // 1 (true) to allow scene rendering in the background
	duration = 10e10; //show for 10 billion seconds
	movingEnable = false;
	name = "respawn_round_rsc_hud";

	fadein = 0;
	fadeout = 0;

	onLoad = "uiNamespace setVariable ['respawn_round_rsc_hud', (_this select 0)];";
	class controlsBackground {
		class respawn_round_background : respawn_round_template
		{
			idc = 9001;
			type = CT_STATIC;

			x = GUI_GRID_X + (0 * GUI_CTRL_W);
			y = GUI_GRID_Y + (0 * GUI_CTRL_H);
			w = 40  * GUI_CTRL_W;
			h = 25  * GUI_CTRL_H;

			sizeEx = GUI_TEXT_SIZE_LARGE; // Text size
			size = GUI_TEXT_SIZE_LARGE; // Text size

			colorBackground[] = {0.0,0.0,0.0,0.0};
			colorText[] = {1,1,1,0};

			text = ""; // Displayed text

			onLoad = "";
		};
		class respawn_round_backgroundScore : respawn_round_template
		{
			idc = 9006;
			type = CT_STATIC;
			style = ST_PICTURE;

			x = GUI_GRID_X + (0 * GUI_CTRL_W);
			y = GUI_GRID_Y + (0 * GUI_CTRL_H);
			w = 10  * GUI_CTRL_W;
			h = 8  * GUI_CTRL_H;

			sizeEx = GUI_TEXT_SIZE_LARGE; // Text size
			size = GUI_TEXT_SIZE_LARGE; // Text size

			colorBackground[] = {0,0,0,0};
			colorText[] = {1.0,1.0,1.0,0.3};

			text = "plugins\respawn_round\files\dialogs\bg.paa"; // Displayed text

			onLoad = "";
		};
	};
	class Controls // Main controls
	{
		class respawn_round_text : respawn_round_template
		{
			idc = 9002;
			type = CT_STRUCTURED_TEXT;

			x = GUI_GRID_X + (15 * GUI_CTRL_W);
			y = GUI_GRID_Y + (10.5 * GUI_CTRL_H);
			w = 10* GUI_CTRL_W;
			h = 1* GUI_CTRL_H;

			sizeEx = GUI_TEXT_SIZE_SMALL; // Text size
			size = GUI_TEXT_SIZE_SMALL; // Text size

			colorBackground[] = {1.0,1.0,1.0,0.0};
			colorText[] = {1.0,1.0,1.0,1.0};

			text = ""; // icon

			lineSpacing = 0;
			fixedWidth = 0;
			onLoad = "";
			class Attributes {
				font = "EtelkaMonospaceProBold";
				//color = "#b33333";
				color = "#ffffff";
				align = "center";
				valign = "middle";
				shadow = true;
				shadowColor = "#000000";
				size = 1;
			};
		};
		class respawn_round_numb : respawn_round_template
		{
			idc = 9003;
			type = CT_STRUCTURED_TEXT;

			x = GUI_GRID_X + (18 * GUI_CTRL_W);
			y = GUI_GRID_Y + (11.5 * GUI_CTRL_H);
			w = 4* GUI_CTRL_W;
			h = 2* GUI_CTRL_H;

			sizeEx = GUI_TEXT_SIZE_MEDIUM; // Text size
			size = GUI_TEXT_SIZE_SMALL; // Text size

			colorBackground[] = {1.0,1.0,1.0,0.0};
			colorText[] = {1.0,1.0,1.0,1.0};

			text = ""; // icon

			lineSpacing = 0;
			fixedWidth = 0;
			onLoad = "";
			class Attributes {
				font = "EtelkaMonospaceProBold";
				color = "#e6b300";
				align = "center";
				valign = "middle";
				shadow = true;
				shadowColor = "#ffffff";
				size = 1;
			};
		};
		class respawn_round_msg : respawn_round_template
		{
			idc = 9004;
			type = CT_STRUCTURED_TEXT;

			x = GUI_GRID_X + (15 * GUI_CTRL_W);
			y = GUI_GRID_Y + (9.5 * GUI_CTRL_H);
			w = 10* GUI_CTRL_W;
			h = 1* GUI_CTRL_H;

			sizeEx = GUI_TEXT_SIZE_SMALL; // Text size
			size = GUI_TEXT_SIZE_SMALL; // Text size

			colorBackground[] = {0.1,0.1,0.1,0.0};
			colorText[] = {0.1,0.1,0.1,1.0};

			text = ""; // icon

			lineSpacing = 0;
			fixedWidth = 0;
			onLoad = "";
			class Attributes {
				font = "EtelkaMonospaceProBold";
				//color = "#b33333";
				color = "#ffffff";
				align = "center";
				valign = "middle";
				shadow = true;
				shadowColor = "#000000";
				size = 1;
			};
		};
		class respawn_round_score : respawn_round_template
		{
			idc = 9005;
			type = CT_STRUCTURED_TEXT;
			style = ST_LEFT;

			x = GUI_GRID_X + (0.25 * GUI_CTRL_W);
			y = GUI_GRID_Y + (0.25 * GUI_CTRL_H);
			w = 5* GUI_CTRL_W;
			h = 4* GUI_CTRL_H;

			sizeEx = GUI_TEXT_SIZE_SMALL; // Text size
			size = GUI_TEXT_SIZE_SMALL; // Text size

			colorBackground[] = {0.1,0.1,0.1,0.0};
			colorText[] = {0.1,0.1,0.1,0.5};

			text = ""; // icon

			lineSpacing = 0;
			fixedWidth = 0;
			onLoad = "";
			class Attributes {
				font = "EtelkaMonospaceProBold";
				//color = "#b33333";
				color = "#ffffff";
				align = "center";
				valign = "middle";
				shadow = true;
				shadowColor = "#000000";
				size = 1;
			};
		};
		class respawn_round_time : respawn_round_template
		{
			idc = 9007;
			type = CT_STRUCTURED_TEXT;
			style = ST_CENTER;

			x = GUI_GRID_X + (5.5 * GUI_CTRL_W);
			y = GUI_GRID_Y + (0.25 * GUI_CTRL_H);
			w = 3* GUI_CTRL_W;
			h = 1* GUI_CTRL_H;

			sizeEx = GUI_TEXT_SIZE_SMALL; // Text size
			size = GUI_TEXT_SIZE_SMALL; // Text size

			colorBackground[] = {0.1,0.1,0.1,0.0};
			colorText[] = {0.1,0.1,0.1,1.0};

			text = ""; // icon

			lineSpacing = 0;
			fixedWidth = 0;
			onLoad = "";
			class Attributes {
				font = "EtelkaMonospaceProBold";
				//color = "#b33333";
				color = "#ffffff";
				align = "center";
				valign = "middle";
				shadow = true;
				shadowColor = "#000000";
				size = 1;
			};
		};
	};
};
