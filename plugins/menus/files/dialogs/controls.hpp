// This file contains the default / template contorls for the menus

class menus_template_display
{
  idd = 1000; // Display identification
  enableSimulation = 1; // 1 (true) to allow world simulation to be running in the background, 0 to freeze it
  enableDisplay = 1; // 1 (true) to allow scene rendering in the background
};
class menus_template_progress {
  idc = 1012;
  type = 8;
  style = 0;
  colorFrame[] = {1,0.5,0.0,1};
  colorBar[] = {1,0.6,0.2,1};
  texture = "#(argb,8,8,3)color(1,1,1,1)";
  x = 0 + (0 * GUI_GRID_W);
  y = 0 + (5.5 * GUI_GRID_H);
  w = 5  * GUI_GRID_W;
  h = 1  * GUI_GRID_H;
};
class menus_template_slider {
  idc = 1011;
  type = CT_SLIDER;
  style = SL_HORZ;
  x = 0 + (0 * GUI_GRID_W);
  y = 0 + (5.5 * GUI_GRID_H);
  w = 5  * GUI_GRID_W;
  h = 1  * GUI_GRID_H;
  color[] = {1,0.6,0.2,1};
  coloractive[] = {0.85,0.4,0,1};
  // This is an ctrlEventHandler to show you some response if you move the sliderpointer.
  onSliderPosChanged = "";
};
class menus_template_listBox
{
  idc = 1011; // Control identification (without it, the control won't be displayed)
  type = CT_LISTBOX; // Type is 5
  style = ST_LEFT + LB_TEXTURES; // Style
  default = 0; // Control selected by default (only one within a display can be used)
  blinkingPeriod = 0; // Time in which control will fade out and back in. Use 0 to disable the effect.

  x = 0 + (0 * GUI_GRID_W);
  y = 0 + (5.5 * GUI_GRID_H);
  w = 5  * GUI_GRID_W;
  h = 1  * GUI_GRID_H;

  colorBackground[] = {0,0,0,1}; // Fill color
  colorSelectBackground[] = {1,0.5,0,1}; // Selected item fill color
  colorSelectBackground2[] = {0,0,0,1}; // Selected item fill color (oscillates between this and colorSelectBackground)

  sizeEx = 1 * GUI_TEXT_SIZE_SMALL; // Text size
  font = GUI_FONT_NORMAL; // Font from CfgFontFamilies
  shadow = 1; // Shadow (0 - none, 1 - directional, color affected by colorShadow, 2 - black outline)
  colorText[] = {1,1,1,1}; // Text and frame color
  colorDisabled[] = {1,1,1,0.5}; // Disabled text color
  colorSelect[] = {1,1,1,1}; // Text selection color
  colorSelect2[] = {1,1,1,1}; // Text selection color (oscillates between this and colorSelect)
  colorShadow[] = {0,0,0,0.5}; // Text shadow color (used only when shadow is 1)

  pictureColor[] = {1,0.5,0,1}; // Picture color
  pictureColorSelect[] = {1,1,1,1}; // Selected picture color
  pictureColorDisabled[] = {1,1,1,0.5}; // Disabled picture color

  tooltip = ""; // Tooltip text
  tooltipColorShade[] = {0,0,0,1}; // Tooltip background color
  tooltipColorText[] = {1,1,1,1}; // Tooltip text color
  tooltipColorBox[] = {1,1,1,1}; // Tooltip frame color

  period = 1; // Oscillation time between colorSelect/colorSelectBackground2 and colorSelect2/colorSelectBackground when selected

  rowHeight = 0.75 * GUI_TEXT_SIZE_SMALL; // Row height
  itemSpacing = 0; // Height of empty space between items
  maxHistoryDelay = 1; // Time since last keyboard type search to reset it
  canDrag = 0; // 1 (true) to allow item dragging

  soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1}; // Sound played when an item is selected

  // Scrollbar configuration (applied only when LB_TEXTURES style is used)
  class ListScrollBar //In older games this class is "ScrollBar"
  {
    width = 0; // width of ListScrollBar
    height = 0; // height of ListScrollBar
    scrollSpeed = 0.01; // scroll speed of ListScrollBar

    arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow
    arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on
    border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa"; // Slider background (stretched vertically)
    thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa"; // Dragging element (stretched vertically)

    color[] = {1,1,1,1}; // Scrollbar color
  };
};

class menus_template_ctrlMenu
{
  idc = 1010;
  type=46;
  style=0;

  default=0;
  show=1;
  fade=0;
  blinkingPeriod=0;
  deletable=0;


  x = 0 + (4.5 * GUI_GRID_W);
  y = 0 + (3 * GUI_GRID_H);
  w = 5  * GUI_GRID_W;
  h = 1  * GUI_GRID_H;

  class Items {
    items[]= {};
    class Default {
      text="$STR_3DEN_Display3DEN_MenuBar_Default_text";
      enable=0;
    };
  };

  tooltip="";
  tooltipMaxWidth=0.5;
  tooltipColorShade[]={0,0,0,1};
  tooltipColorText[]={1,1,1,1};
  tooltipColorBox[]={0,0,0,0};

  class ScrollBar {
    width=0;
    height=0;
    scrollSpeed=0.059999999;
    arrowEmpty="\a3\3DEN\Data\Controls\ctrlDefault\arrowEmpty_ca.paa";
    arrowFull="\a3\3DEN\Data\Controls\ctrlDefault\arrowFull_ca.paa";
    border="\a3\3DEN\Data\Controls\ctrlDefault\border_ca.paa";
    thumb="\a3\3DEN\Data\Controls\ctrlDefault\thumb_ca.paa";
    color[]={1,1,1,1};
  };

  sizeEx="4.32 * (1 / (getResolution select 3)) * pixelGrid * 0.5";
  font="RobotoCondensedLight";
  shadow=1;
  colorBorder[]={0,0,0,0};
  colorBackground[]={0,0,0,1};
  colorText[]={1,1,1,1};
  colorSelect[]={0,0,0,1};
  colorSelectBackground[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",1};
  colorDisabled[]={1,1,1,0.25};
  colorPicture[]={1,1,1,1};
  colorPictureSelect[]={0,0,0,1};
  colorPictureDisabled[]={1,1,1,0.5};
  arrow="\a3\3DEN\Data\Controls\ctrlMenu\arrow_ca.paa";
  rowHeight=0;
  itemSpacingW=0.0099999998;
  itemSpacingH=0.0099999998;
  pictureCheckboxEnabled="\a3\3DEN\Data\Controls\CtrlMenu\pictureCheckboxEnabled_ca.paa";
  pictureCheckboxDisabled="#(argb,8,8,3)color(0,0,0,0)";
  pictureRadioEnabled="\a3\3DEN\Data\Controls\CtrlMenu\pictureRadioEnabled_ca.paa";
  pictureRadioDisabled="#(argb,8,8,3)color(0,0,0,0)";
};

class menus_template_editBox
{
  idc = 1009;
  type = CT_EDIT;
  style = ST_MULTI;

  x = 0 + (1 * GUI_GRID_W);
  y = 0 + (18 * GUI_GRID_H);
  w = 5  * GUI_GRID_W;
  h = 1  * GUI_GRID_H;

  maxChars = 300;
  sizeEx = GUI_TEXT_SIZE_SMALL; // Text size
  font = GUI_FONT_NORMAL;
  shadow = 2;
  autocomplete = "";
  canModify = true;
  forceDrawCaret = true;
  colorSelection[] = {0,1,0,1};
  colorText[] = {1,1,1,1};
  colorDisabled[] = {1,0,0,1};
  colorBackground[] = {0,0,0,0.5};
  text = "Line 1";
};
class menus_template_checkBox
{
  idc = 1008;
  type = CT_CHECKBOX;
  style = ST_CENTER; // ST_CENTER

  x = 0 + (7 * GUI_GRID_W);
  y = 0 + (18 * GUI_GRID_H);
  w = 1  * GUI_GRID_W;
  h = 1  * GUI_GRID_H;
  text = "";
  sizeEx = GUI_GRID_CENTER_H;
  font = GUI_FONT_NORMAL;
  color[] = {0,1,0,1};
  colorDisabled[] = {0.4,0.4,0.4,1};
  colorText[] = {0,1,0,1};
  colorTextSelect[] = {0,1,0,1};
  colorPressed[] = {0,1,0,1};
  colorHover[] = {0,1,0,1};
  colorFocused[] = {0,1,0,1};
  colorBackground[] = {0,0,0,0};
  colorBackgroundDisabled[] = {0,0,0,0};
  colorBackgroundPressed[] = {0,0,0,0};
  colorBackgroundHover[]= {0,0,0,0};
  colorBackgroundFocused[]= {0,0,0,0};
  textureChecked = "a3\ui_f\data\GUI\RscCommon\RscCheckbox\CheckBox_checked_ca.paa";
  textureUnchecked = "a3\ui_f\data\GUI\RscCommon\RscCheckbox\CheckBox_unchecked_ca.paa";
  textureDisabledChecked = "a3\ui_f\data\GUI\RscCommon\RscCheckbox\CheckBox_checked_ca.paa";
  textureDisabledUnchecked = "a3\ui_f\data\GUI\RscCommon\RscCheckbox\CheckBox_unchecked_ca.paa";
  texturePressedChecked = "a3\ui_f\data\GUI\RscCommon\RscCheckbox\CheckBox_checked_ca.paa";
  texturePressedUnchecked = "a3\ui_f\data\GUI\RscCommon\RscCheckbox\CheckBox_unchecked_ca.paa";
  textureHoverChecked = "a3\ui_f\data\GUI\RscCommon\RscCheckbox\CheckBox_checked_ca.paa";
  textureHoverUnchecked = "a3\ui_f\data\GUI\RscCommon\RscCheckbox\CheckBox_unchecked_ca.paa";
  textureFocusedChecked = "a3\ui_f\data\GUI\RscCommon\RscCheckbox\CheckBox_checked_ca.paa";
  textureFocusedUnchecked = "a3\ui_f\data\GUI\RscCommon\RscCheckbox\CheckBox_unchecked_ca.paa";
  soundEnter[] = { "", 0, 1 };
  soundPush[] = { "", 0, 1 };
  soundClick[] = { "", 0, 1 };
  soundEscape[] = { "", 0, 1 };
  tooltipColorShade[] = {0,0,0,1};
  tooltipColorText[] = {0,1,0,1};
  tooltipColorBox[] = {0,1,0,1};
};
class menus_template_checkBoxes
{
  idc = 1007;
  type = CT_CHECKBOXES;
  style = ST_CENTER; // ST_CENTER

  x = 0 + (9 * GUI_GRID_W);
  y = 0 + (18 * GUI_GRID_H);
  w = 3  * GUI_GRID_W;
  h = 1  * GUI_GRID_H;


  colorSelectedBg[] = {0, 0, 0, 0.3}; // selected item bg color

  colorText[] = {0, 1, 0, 1};
  colorTextSelect[] = {1, 0, 0, 1};

  colorBackground[] = {0, 0, 0, 0.3}; // control generic BG color

  sizeEx = GUI_GRID_CENTER_H; // Text size
  font = GUI_FONT_NORMAL; // Font from CfgFontFamilies

  // onCheckBoxesSelChanged = "systemChat str _this"; todo

  columns = 2;
  rows = 1;
  strings[] = {"[o]","[o]"};
  checked_strings[] = {"[X]","[X]"};
};
class menus_template_background
{
  idc = 1006;
  type = CT_STATIC;
  style = ST_LEFT;
  x = 0 + (0 * GUI_CTRL_W);
  y = 0 + (0 * GUI_CTRL_H);
  w = 14  * GUI_CTRL_W;
  h = 20  * GUI_CTRL_H;

  colorBackground[] = {1,0.5,0.0,1};

  shadow = 2;

  font = GUI_FONT_NORMAL;
  size = 1; // control size
  sizeEx = GUI_TEXT_SIZE_MEDIUM; // Text size
  colorText[] = {1,1,1,1};
  text = "";
  moving = 0;
};
class menus_template_button
{
  idc = 1005; // Control identification (without it, the control won't be displayed)
  type = CT_BUTTON; // Type
  style = ST_CENTER; // Style
  default = 0; // Control selected by default (only one within a display can be used)
  blinkingPeriod = 0; // Time in which control will fade out and back in. Use 0 to disable the effect.

  x = 0 + (0 * GUI_GRID_W);
  y = 0 + (5 * GUI_GRID_H);
  w = 5  * GUI_GRID_W;
  h = 1  * GUI_GRID_H;


  colorBackground[] = {1,0.6,0.2,1}; // Fill color
  colorBackgroundDisabled[] = {0,0,0,0.5}; // Disabled fill color
  colorBackgroundActive[] = {0.85,0.4,0,1}; // Mouse hover fill color
  colorFocused[] = {1,0.5,0,1}; // Selected fill color (oscillates between this and colorBackground)

  text = ""; // Displayed text
  sizeEx = GUI_GRID_CENTER_H; // Text size
  font = GUI_FONT_NORMAL; // Font from CfgFontFamilies
  shadow = 1; // Shadow (0 - none, 1 - N/A, 2 - black outline)
  colorText[] = {1,1,1,1}; // Text color
  colorDisabled[] = {1,1,1,0.5}; // Disabled text color

  tooltip = ""; // Tooltip text
  tooltipColorShade[] = {0,0,0,1}; // Tooltip background color
  tooltipColorText[] = {1,1,1,1}; // Tooltip text color
  tooltipColorBox[] = {1,1,1,1}; // Tooltip frame color

  borderSize = 0.01; // Left color width (border is a stripe of the control height on the left side)
  colorBorder[] = {1,1,1,0}; // Left border color

  colorShadow[] = {0,0,0,0.2}; // Background frame color
  offsetX = 0.0025; // Horizontal background frame offset
  offsetY = 0.005; // Vertical background frame offset
  offsetPressedX = 0.0075; // Horizontal background offset when pressed
  offsetPressedY = 0.01; // Horizontal background offset when pressed

  period = 1; // Oscillation time between colorBackground and colorFocused when selected
  periodFocus = 2; // Unknown?
  periodOver = 0.5; // Unknown?

  soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1}; // Sound played after control is activated in format {file, volume, pitch}
  soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1}; // Sound played when mouse cursor enters the control
  soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1}; // Sound played when the control is pushed down
  soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1}; // Sound played when the control is released after pushing down

  //onButtonClick = "";//removed (findDisplay 303317) closeDisplay 2;
};

class menus_template_title
{
  idc = 1004;
  type = CT_STRUCTURED_TEXT;  // defined constant
  style = ST_TITLE;            // defined constant
  colorBackground[] = { 1, 1, 1, 0 };
  x = 0 + (0 * GUI_GRID_W);
  y = 0 + (0.3 * GUI_GRID_H);
  w = 14  * GUI_GRID_W;
  h = 1.5  * GUI_GRID_H;
  size = GUI_TEXT_SIZE_LARGE;
  text = "";
  shadow = 2;
  colorShadow[] = {0,0,0,0.75}; // Background frame color
  class Attributes {
    font = "RobotoCondensedBold";
    color = "#FFFF00";
    align = "center";
    valign = "middle";
    shadow = true;
    shadowColor = "#ff0000";
    size = "1";
  };
};
class menus_template_titleBar
{
  idc = 1003;
  type = CT_STRUCTURED_TEXT;  // defined constant
  style = ST_TITLE_BAR;            // defined constant
  colorBackground[] = { 1, 1, 1, 1 };
  x = 0 + (0 * GUI_GRID_W);
  y = 0 + (1.5 * GUI_GRID_H);
  w = 14  * GUI_GRID_W;
  h = 0.1  * GUI_GRID_H;
  size = GUI_TEXT_SIZE_LARGE;
  text = "";
  class Attributes {
    font = "RobotoCondensedBold";
    color = "#FFFF00";
    align = "left";
    valign = "middle";
    shadow = true;
    shadowColor = "#ff0000";
    size = "1";
  };
};
class menus_template_text
{
  idc = 1002;
  type = CT_STRUCTURED_TEXT;  // defined constant
  style = ST_LEFT;            // defined constant
  colorBackground[] = { 1, 1, 1, 0 };
  x = 0 + (0.5 * GUI_GRID_W);
  y = 0 + (2 * GUI_GRID_H);
  w = 13  * GUI_GRID_W;
  h = 14  * GUI_GRID_H;
  size = GUI_TEXT_SIZE_SMALL;
  text = "";
  shadow = 2;
  colorShadow[] = {0,0,0,0.75}; // Background frame color
  class Attributes {
    font = "RobotoCondensed";
    color = "#FFFFFF";
    align = "left";
    valign = "middle";
    shadow = true;
    shadowColor = "#ff0000";
    size = "1";
  };
};
class menus_template_group
{
  //onLoad = "systemChat 'firstItem ctrl group loaded';";
  idc = 1001; // Control identification (without it, the control won't be displayed)
  type = CT_CONTROLS_GROUP; // Type
  style = ST_MULTI;

  x = 0 + (0 * GUI_GRID_W);
  y = 0 + (0 * GUI_GRID_H);
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