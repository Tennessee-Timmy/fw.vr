class menus_main_start
{

  idd = 303000; // Display identification
  enableSimulation = 1; // 1 (true) to allow world simulation to be running in the background, 0 to freeze it
  enableDisplay = 1; // 1 (true) to allow scene rendering in the background

  //onLoad = "_this call BRM_insurgency_respawn_fnc_openDialog;";
  //onUnload = "call BRM_insurgency_respawn_fnc_closeDialog";

  class Controls // Main controls
  {
    class menus_main_startButton : menus_template_button
    {
      idc = 3001; // Control identification (without it, the control won't be displayed)

      x = GUI_GRID_X + (33 * GUI_GRID_W);
      y = GUI_GRID_Y + (2 * GUI_GRID_H);
      w = 5  * GUI_GRID_W;
      h = 1  * GUI_GRID_H;

      text = "OPEN MENU"; // Displayed text
      tooltip = "Open mission menu"; // Tooltip text
      onButtonClick = "call menus_fnc_menusOpen;false";//removed (findDisplay 303317) closeDisplay 2; todo
    };
  };
};
class menus_main_menu
{

  idd = 304000; // Display identification
  enableSimulation = 1; // 1 (true) to allow world simulation to be running in the background, 0 to freeze it
  enableDisplay = 1; // 1 (true) to allow scene rendering in the background

  onLoad = "_this call menus_fnc_openMainMenu;";
  onUnload = "[] call menus_fnc_menusClose";

  class ControlsBackground // Main controls
  {
    class menus_main_controlGroup: menus_template_group
    {
      idc = 4100; // Control identification (without it, the control won't be displayed)

      x = GUI_GRID_X + (20 * GUI_GRID_W);
      y = GUI_GRID_Y + (2 * GUI_GRID_H);
      w = 19  * GUI_GRID_W;
      h = 21  * GUI_GRID_H;

      class controls
      {
        class menus_main_background: menus_template_background
        {
          idc = 4101;
          x = 0 + (0 * GUI_CTRL_W);
          y = 0 + (0 * GUI_CTRL_H);
          w = 18  * GUI_CTRL_W;
          h = 1  * GUI_CTRL_H;
          text = "Mission Menu";
        };
        class menus_main_background2: menus_template_background
        {
          idc = 4102;
          //style = ST_PICTURE;
          x = 0 + (0.05 * GUI_CTRL_W);
          y = 0 + (1.00 * GUI_CTRL_H);
          w = 17.95  * GUI_CTRL_W;
          h = 20.00  * GUI_CTRL_H;
          //text = "plugins\menus\files\dialogs\images\bg.paa";
          colorText[] = {1,1,1,1};
          colorBackground[] = {0.3,0.3,0.3,1};
        };
      };
    };
  };

  class Controls
  {
    class menus_main_controlGroup: menus_template_group
    {
      idc = 4100; // Control identification (without it, the control won't be displayed)

      x = GUI_GRID_X + (20 * GUI_GRID_W);
      y = GUI_GRID_Y + (2 * GUI_GRID_H);
      w = 19  * GUI_GRID_W;
      h = 21  * GUI_GRID_H;

      class controls
      {
        class menus_main_closeButton: menus_template_button
        {
          idc = 4103; // Control identification (without it, the control won't be displayed)
          type = CT_BUTTON; // Type
          style = ST_CENTER; // Style

          x = 0 + (17 * GUI_GRID_W);
          y = 0 + (0 * GUI_GRID_H);
          w = 1  * GUI_GRID_W;
          h = 1  * GUI_GRID_H;


          colorBackground[] = {0.25,0.25,0.25,1}; // Fill color
          colorBackgroundDisabled[] = {0,0,0,0.5}; // Disabled fill color
          colorBackgroundActive[] = {0,0,0,1}; // Mouse hover fill color
          colorFocused[] = {0.2,0.2,0.2,1}; // Selected fill color (oscillates between this and colorBackground)

          text = "X"; // Displayed text
          tooltip = "Close mission menu"; // Tooltip text

          borderSize = 0; // Left color width (border is a stripe of the control height on the left side)

          offsetX = 0; // Horizontal background frame offset
          offsetY = 0; // Vertical background frame offset

          onButtonClick = "true call menus_fnc_menusClose; false";
        };
        class menus_mission_list
        {

          //onLoad = "_this call menus_fnc_openMainMenu;"; //todo updatelist function
          idc = 4104; // Control identification (without it, the control won't be displayed)
          type = CT_LISTBOX; // Type is 5
          style = ST_CENTER + LB_TEXTURES; // Style
          default = 0; // Control selected by default (only one within a display can be used)
          blinkingPeriod = 0; // Time in which control will fade out and back in. Use 0 to disable the effect.
          x = 0 + (0 * GUI_CTRL_W);
          y = 0 + (1 * GUI_CTRL_H);
          w = 4  * GUI_CTRL_W;
          h = 20  * GUI_CTRL_H;
          colorBackground[] = {0.2,0.2,0.2,1}; // Fill color
          colorSelectBackground[] = {1,0.5,0,1}; // Selected item fill color
          colorSelectBackground2[] = {0,0,0,1}; // Selected item fill color (oscillates between this and colorSelectBackground)

          sizeEx = GUI_TEXT_SIZE_SMALL; // Text size
          font = GUI_FONT_NORMAL; // Font from CfgFontFamilies
          shadow = 2; // Shadow (0 - none, 1 - directional, color affected by colorShadow, 2 - black outline)
          colorText[] = {1,1,1,1}; // Text and frame color
          colorDisabled[] = {1,1,1,0.5}; // Disabled text color
          colorSelect[] = {1,1,1,1}; // Text selection color
          colorSelect2[] = {1,1,1,1}; // Text selection color (oscillates between this and colorSelect)
          //colorShadow[] = {0,0,0,0.5}; // Text shadow color (used only when shadow is 1)
          colorShadow[] = {0,0,0,0.5};


          pictureColor[] = {1,0.5,0,1}; // Picture color
          pictureColorSelect[] = {1,1,1,1}; // Selected picture color
          pictureColorDisabled[] = {1,1,1,0.5}; // Disabled picture color

          tooltip = ""; // Tooltip text
          tooltipColorShade[] = {0,0,0,1}; // Tooltip background color
          tooltipColorText[] = {1,1,1,1}; // Tooltip text color
          tooltipColorBox[] = {1,1,1,1}; // Tooltip frame color

          period = 1; // Oscillation time between colorSelect/colorSelectBackground2 and colorSelect2/colorSelectBackground when selected

          rowHeight = 1.5 * GUI_TEXT_SIZE_SMALL; // Row height
          itemSpacing = GUI_GRID_CENTER_H/5; // Height of empty space between items
          maxHistoryDelay = 1; // Time since last keyboard type search to reset it
          canDrag = 0; // 1 (true) to allow item dragging

          soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1}; // Sound played when an item is selected

          // Scrollbar configuration (applied only when LB_TEXTURES style is used)
          class ListScrollBar //In older games this class is "ScrollBar"
          {
            width = GUI_GRID_H; // width of ListScrollBar
            height = GUI_GRID_H; // height of ListScrollBar
            scrollSpeed = 0.01; // scroll speed of ListScrollBar

            arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow
            arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on
            border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa"; // Slider background (stretched vertically)
            thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa"; // Dragging element (stretched vertically)

            color[] = {1,1,1,1}; // Scrollbar color
          };
          onLBSelChanged = "_this call menus_fnc_menuList_select";
        };
        class menus_admin_list: menus_mission_list
        {
          idc = 4105; // Control identification (without it, the control won't be displayed)
          //  onLoad = "_this call menus_fnc_openMainMenu;"; //todo updatelist function
        };
        class menus_admin_button : menus_template_button
        {
          idc = 4106; // Control identification (without it, the control won't be displayed)

          x = 0 + (5 * GUI_GRID_W);
          y = 0 + (0 * GUI_GRID_H);
          w = 5  * GUI_GRID_W;
          h = 1  * GUI_GRID_H;

          colorBackground[] = {0.9,0,0,1};

          text = "ADMIN MENU"; // Displayed text
          tooltip = "Switch to admin menu"; // Tooltip text
          onButtonClick = "call menus_fnc_switchMenusAdmin;false";
        };
        class menus_mission_button : menus_template_button
        {
          idc = 4107; // Control identification (without it, the control won't be displayed)

          x = 0 + (5 * GUI_GRID_W);
          y = 0 + (0 * GUI_GRID_H);
          w = 5  * GUI_GRID_W;
          h = 1  * GUI_GRID_H;

          text = "MISSION MENU"; // Displayed text
          tooltip = "Switch to mission menu"; // Tooltip text
          onButtonClick = "call menus_fnc_switchMenusMission;false";
        };
        class menus_main_databox
        {
          //onLoad = "systemChat 'databox ctrl group loaded';";
          idc = 4110; // Control identification (without it, the control won't be displayed)
          type = CT_CONTROLS_GROUP; // Type
          style = ST_LEFT;


          x = 0 + (4 * GUI_GRID_W);
          y = 0 + (1 * GUI_GRID_H);
          w = 14  * GUI_GRID_W;
          h = 20  * GUI_GRID_H;
          shadow=0;

          class VScrollbar
          {
            width = GUI_GRID_H/2;
            autoScrollSpeed = -1;
            autoScrollDelay = 5;
            autoScrollRewind = 0;
            shadow=1;
          };

          class HScrollbar
          {
            height = GUI_GRID_H/2;
            shadow=1;
          };

          class ScrollBar
          {
            color[] = {1,1,1,1};
            colorActive[] = {1,1,1,1};
            colorDisabled[] = {1,1,1,0.3};
            thumb = "#(argb,8,8,3)color(1,1,1,1)";
            arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
            arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
            border = "#(argb,8,8,3)color(1,1,1,1)";
          };
          class Controls
          {

          };
        };
      };
    };
  };
};
