class briefing_roster
{

	idd = 603000; // Display identification
	enableSimulation = 0; // 1 (true) to allow world simulation to be running in the background, 0 to freeze it
	enableDisplay = 1; // 1 (true) to allow scene rendering in the background

	onLoad = "_this spawn briefing_fnc_rosterOn;";
	// onUnload = "_this call briefing_fnc_rosterOn";

	class Controls // Main controls
	{
		class roster_group: menus_template_group
		{
			idc = 1000;
			x = GUI_GRID_X + (11 * GUI_GRID_W);
			y = GUI_GRID_Y + (1.5 * GUI_GRID_H);
			w = 13  * GUI_GRID_W;
			h = 15.5  * GUI_GRID_H;
			class Controls
			{
				class x_button: menus_template_button
				{
					idc = 1003;
					x = 0 + (0 * GUI_GRID_W);
					y = 0 + (0 * GUI_GRID_H);
					w = 1  * GUI_GRID_W;
					h = 1  * GUI_GRID_H;
					text = "x";
					size = 0.8 * GUI_TEXT_SIZE_SMALL;
 					onButtonClick = "(findDisplay 603000) closeDisplay 2;";
				};
				class roster_title: menus_template_title
				{
					idc = 1001;
					x = 0 + (0 * GUI_GRID_W);
					y = 0 + (0 * GUI_GRID_H);
					w = 13  * GUI_GRID_W;
					h = 1.2  * GUI_GRID_H;
					text = "Team Roster";
				};
				class roster: menus_template_text
				{
					idc = 1002;
					x = 0 + (0 * GUI_GRID_W);
					y = 0 + (1.5 * GUI_GRID_H);
					w = 13  * GUI_GRID_W;
					h = 17  * GUI_GRID_H;
					text = "Team Roster";
					size = 0.8 * GUI_TEXT_SIZE_SMALL;
				};
			};
		};
	};
	class ControlsBackground
	{
		class roster_background: menus_template_background
		{
			idc = 2001;
			colorBackground[] = {0.25,0.25,0.25, 1};
			x = GUI_GRID_X + (11 * GUI_GRID_W);
			y = GUI_GRID_Y + (1.5 * GUI_GRID_H);
			w = 13  * GUI_GRID_W;
			h = 15.5  * GUI_GRID_H;
		};
	};
};