// template
class round_template : menus_template_title
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
class round_rsc_hud
{
	idd = 109000; // Display identification
	enableSimulation = 1; // 1 (true) to allow world simulation to be running in the background, 0 to freeze it
	enableDisplay = 1; // 1 (true) to allow scene rendering in the background
	duration = 10e10; //show for 10 billion seconds
	movingEnable = false;
	name = "round_rsc_hud";

	fadein = 0;
	fadeout = 0;

	onLoad = "uiNamespace setVariable ['round_rsc_hud', (_this select 0)];";
	class controlsBackground {
		class round_background : round_template
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
		class round_backgroundScore : round_template
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

			colorBackground[] = {0.2,0.2,0.2,0.3};
			colorText[] = {1.0,1.0,1.0,0.3};

			text = "";
			//text = "plugins\round\files\dialogs\bg.paa"; // Displayed text

			onLoad = "";
		};
	};
	class Controls // Main controls
	{
		class round_text : round_template
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
		class round_text2 : round_text
		{
			idc = 9022;

			x = GUI_GRID_X + (15 * GUI_CTRL_W);
			y = GUI_GRID_Y + (16.5 * GUI_CTRL_H);

		};
		class round_numb : round_template
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
		class round_numb2 : round_numb
		{
			idc = 9023;

			x = GUI_GRID_X + (18 * GUI_CTRL_W);
			y = GUI_GRID_Y + (17.5 * GUI_CTRL_H);

		};
		class round_msg : round_template
		{
			idc = 9004;
			type = CT_STRUCTURED_TEXT;

			x = GUI_GRID_X + (15 * GUI_CTRL_W);
			y = GUI_GRID_Y + (8.5 * GUI_CTRL_H);
			w = 10* GUI_CTRL_W;
			h = 3* GUI_CTRL_H;

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
		class round_score : round_template
		{
			idc = 9005;
			type = CT_STRUCTURED_TEXT;
			style = ST_LEFT;

			x = GUI_GRID_X + (0.25 * GUI_CTRL_W);
			y = GUI_GRID_Y + (3.25 * GUI_CTRL_H);
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
		class round_time : round_template
		{
			idc = 9007;
			type = CT_STRUCTURED_TEXT;
			style = ST_RIGHT;

			// --[15]--15--|30|--10--[40]
			x = GUI_GRID_X + (5.9 * GUI_CTRL_W);
			y = GUI_GRID_Y + (0.25 * GUI_CTRL_H);
			w = 15* GUI_CTRL_W;
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

// title
class round_rsc_vote_hud
{
	idd = 108000; // Display identification
	enableSimulation = 1; // 1 (true) to allow world simulation to be running in the background, 0 to freeze it
	enableDisplay = 1; // 1 (true) to allow scene rendering in the background
	duration = 10e10; //show for 10 billion seconds
	movingEnable = false;
	name = "round_rsc_vote_hud";

	fadein = 0;
	fadeout = 0;

	onLoad = "uiNamespace setVariable ['round_rsc_vote_hud', (_this select 0)];";
	class controlsBackground {
		class round_vote_bg : round_template
		{
			idc = 9001;
			type = CT_STATIC;

			x = GUI_GRID_X + (30 * GUI_CTRL_W);
			y = GUI_GRID_Y + (0 * GUI_CTRL_H);
			w = 10  * GUI_CTRL_W;
			h = 7 * GUI_CTRL_H;

			sizeEx = GUI_TEXT_SIZE_LARGE; // Text size
			size = GUI_TEXT_SIZE_LARGE; // Text size

			colorBackground[] = {0.2,0.2,0.2,0.5};
			colorText[] = {1,1,1,0};

			text = ""; // Displayed text

			onLoad = "";
		};
	};
	class Controls // Main controls
	{
		class round_vote_title : round_template
		{
			idc = 9002;
			type = CT_STRUCTURED_TEXT;

			x = GUI_GRID_X + (30.5 * GUI_CTRL_W);
			y = GUI_GRID_Y + (0.25 * GUI_CTRL_H);
			w = 9* GUI_CTRL_W;
			h = 2* GUI_CTRL_H;

			sizeEx = GUI_TEXT_SIZE_SMALL*0.7; // Text size
			size = GUI_TEXT_SIZE_SMALL*0.7; // Text size

			colorBackground[] = {0.3,0.3,0.7,0.0};
			colorText[] = {0.3,0.3,0.7,1.0};

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
		class round_vote_text : round_vote_title
		{
			idc = 9003;

			x = GUI_GRID_X + (30.5 * GUI_CTRL_W);
			y = GUI_GRID_Y + (1.5 * GUI_CTRL_H);
			w = 9* GUI_CTRL_W;
			h = 6.5 * GUI_CTRL_H;
			colorText[] = {1,1,1,1.0};


			sizeEx = GUI_TEXT_SIZE_SMALL*0.5; // Text size
			size = GUI_TEXT_SIZE_SMALL*0.5; // Text size

		};
		class round_vote_votes : round_vote_title
		{
			idc = 9004;

			x = GUI_GRID_X + (25.5 * GUI_CTRL_W);
			y = GUI_GRID_Y + (10.5 * GUI_CTRL_H);
			w = 14 * GUI_CTRL_W;
			h = 14 * GUI_CTRL_H;
			colorText[] = {1,1,1,1.0};

		};
		class round_help : round_template
		{
			idc = 9005;
			type = CT_STRUCTURED_TEXT;

			x = GUI_GRID_X + (16 * GUI_CTRL_W);
			y = GUI_GRID_Y + (21.5 * GUI_CTRL_H);
			w = 8* GUI_CTRL_W;
			h = 3* GUI_CTRL_H;

			sizeEx = GUI_TEXT_SIZE_MEDIUM; // Text size
			size = GUI_TEXT_SIZE_SMALL; // Text size

			colorBackground[] = {1.0,1.0,1.0,0.0};
			colorText[] = {0.2,1.0,0.2,1.0};

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
	};
};
