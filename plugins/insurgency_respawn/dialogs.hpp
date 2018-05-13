class RscInsurgencyRespawn
{

  idd = 42069; // Display identification
  enableSimulation = 1; // 1 (true) to allow world simulation to be running in the background, 0 to freeze it
  enableDisplay = 1; // 1 (true) to allow scene rendering in the background

  onLoad = "_this call BRM_insurgency_respawn_fnc_openDialog;";
  onUnload = "call BRM_insurgency_respawn_fnc_closeDialog";

  class ControlsBackground // Background controls (placed behind Controls)
  {
    class INS_Background
    {
      idc = -1;
      type = CT_STATIC;
      style = ST_LEFT;
      x = GUI_GRID_X;
      y = GUI_GRID_Y;
      w = 7  * GUI_GRID_W;
      h = 25  * GUI_GRID_H;
      colorBackground[] = {0.2,0.2,0.2,1};
      colorText[] = {0,0,0,0};
      font = GUI_FONT_NORMAL;
      size = 1; // control size
      sizeEx = GUI_TEXT_SIZE_MEDIUM; // Text size
      text = "";
      moving = 0;
    };
  };
  class Controls // Main controls
  {
    class CT_INS_STATIC
    {
      access = 0; // Control access (0 - ReadAndWrite, 1 - ReadAndCreate, 2 - ReadOnly, 3 - ReadOnlyVerified)
      idc = 420; // Control identification (without it, the control won't be displayed)
      type = CT_STATIC; // Type
      style = ST_CENTER + ST_MULTI; // Style
      default = 0; // Control selected by default (only one within a display can be used)
      blinkingPeriod = 0; // Time in which control will fade out and back in. Use 0 to disable the effect.

      x = GUI_GRID_X;
      y = GUI_GRID_Y;
      w = 7  * GUI_GRID_W;
      h = 1  * GUI_GRID_H;


      colorBackground[] = {0.2,0.2,0.2,0}; // Fill color

      text = "RE-DEPLOY"; // Displayed text
      size = GUI_TEXT_SIZE_MEDIUM; // control size
      sizeEx = GUI_TEXT_SIZE_MEDIUM; // Text size
      font = GUI_FONT_NORMAL; // Font from CfgFontFamilies
      shadow = 1; // Shadow (0 - none, 1 - directional, color affected by colorShadow, 2 - black outline)
      lineSpacing = 1; // When ST_MULTI style is used, this defines distance between lines (1 is text height)
      fixedWidth = 0; // 1 (true) to enable monospace
      colorText[] = {1,0.1,0.1,1}; // Text color
      colorShadow[] = {0,0,0,0.5}; // Text shadow color (used only when shadow is 1)

      tooltip = ""; // Tooltip text
      tooltipColorShade[] = {0,0,0,1}; // Tooltip background color
      tooltipColorText[] = {1,1,1,1}; // Tooltip text color
      tooltipColorBox[] = {1,1,1,1}; // Tooltip frame color

      moving = 0; // 1 (true) to allow dragging the whole display by the control

      autoplay = 0; // Play video automatically (only for style ST_PICTURE with text pointing to an .ogv file)
      loops = 0; // Number of video repeats (only for style ST_PICTURE with text pointing to an .ogv file)

      tileW = 1; // Number of tiles horizontally (only for style ST_TILE_PICTURE)
      tileH = 1; // Number of tiles vertically (only for style ST_TILE_PICTURE)
    };
    class CT_INS_NAME
    {
      access = 0; // Control access (0 - ReadAndWrite, 1 - ReadAndCreate, 2 - ReadOnly, 3 - ReadOnlyVerified)
      idc = 421; // Control identification (without it, the control won't be displayed)
      type = CT_STRUCTURED_TEXT; // Type
      style = ST_CENTER; // Style
      default = 0; // Control selected by default (only one within a display can be used)
      blinkingPeriod = 0; // Time in which control will fade out and back in. Use 0 to disable the effect.


      x = GUI_GRID_X + (12.5* GUI_GRID_W);
      y = GUI_GRID_Y + (1 * GUI_GRID_H);
      w = 15  * GUI_GRID_W;
      h = 1  * GUI_GRID_H;

      colorBackground[] = {0.2,0.2,0.2,0}; // Fill color

      text = ""; // Displayed text
      size = GUI_TEXT_SIZE_MEDIUM; // control size
      sizeEx = 1; // Text size

      class Attributes
      {
        font = "TahomaB";
        align = "center"; // Text align
        valign = "middle"; // Text align
        color = "#FF0000"; // Text color
        size = 1; // Text size
        shadow = 1;
        shadowColor = "#00FF00";
      };
    };
    class CT_INS_WAIT : CT_INS_NAME
    {
      idc = 440; // Control identification (without it, the control won't be displayed)
      style = ST_CENTER; // Style


      x = GUI_GRID_X + (12.5* GUI_GRID_W);
      y = GUI_GRID_Y + (3 * GUI_GRID_H);
      w = 15  * GUI_GRID_W;
      h = 5  * GUI_GRID_H;


      size = GUI_TEXT_SIZE_MEDIUM; // control size

      class Attributes
      {
        font = "EtelkaNarrowMediumPro";
        align = "center"; // Text align
        valign = "middle"; // Text align
        color = "#FF0000"; // Text color
        size = 1; // Text size
        shadow = 1;
        shadowColor = "#00FF00";
      };
    }
    class CT_INS_Button
    {
      access = 0; // Control access (0 - ReadAndWrite, 1 - ReadAndCreate, 2 - ReadOnly, 3 - ReadOnlyVerified)
      idc = 430; // Control identification (without it, the control won't be displayed)
      type = CT_BUTTON; // Type
      style = ST_LEFT; // Style
      default = 0; // Control selected by default (only one within a display can be used)
      blinkingPeriod = 0; // Time in which control will fade out and back in. Use 0 to disable the effect.

      x = GUI_GRID_X;
      y = GUI_GRID_Y + (2 * GUI_GRID_H);
      w = 7  * GUI_GRID_W;
      h = 1  * GUI_GRID_H;


      colorBackground[] = {0.6,0.6,0.2,1}; // Fill color
      colorBackgroundDisabled[] = {0,0,0,0.5}; // Disabled fill color
      colorBackgroundActive[] = {0,0,0,1}; // Mouse hover fill color
      colorFocused[] = {1,0.5,0,1}; // Selected fill color (oscillates between this and colorBackground)

      text = "QUICKDEPLOY"; // Displayed text
      sizeEx = GUI_GRID_CENTER_H; // Text size
      font = GUI_FONT_NORMAL; // Font from CfgFontFamilies
      shadow = 1; // Shadow (0 - none, 1 - N/A, 2 - black outline)
      colorText[] = {1,1,1,1}; // Text color
      colorDisabled[] = {1,1,1,0.5}; // Disabled text color

      tooltip = "Deploy on the nearest available teammate"; // Tooltip text
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

      onButtonClick = "call BRM_insurgency_respawn_fnc_spawnOnNearest; false";
    };
    class CT_INS_Button2 : CT_INS_Button
    {
      idc = 431; // Control identification (without it, the control won't be displayed)

      x = GUI_GRID_X;
      y = GUI_GRID_Y + (4 * GUI_GRID_H);
      w = 7  * GUI_GRID_W;
      h = 1  * GUI_GRID_H;

      text = "DEPLOY"; // Displayed text
      tooltip = "Deploy on the selected spawnpoint/teammate"; // Tooltip text
      onButtonClick = "call BRM_insurgency_respawn_fnc_spawnOn; false";
    };
    class CT_INS_TREE
    {
      access = 0; // Control access (0 - ReadAndWrite, 1 - ReadAndCreate, 2 - ReadOnly, 3 - ReadOnlyVerified)
      idc = 450; // Control identification (without it, the control won't be displayed)
      type = CT_TREE; // Type
      style = ST_LEFT; // Style
      default = 0; // Control selected by default (only one within a display can be used)
      blinkingPeriod = 0; // Time in which control will fade out and back in. Use 0 to disable the effect.

      x = GUI_GRID_X;
      y = GUI_GRID_Y + (5 * GUI_GRID_H);
      w = 7  * GUI_GRID_W;
      h = 20  * GUI_GRID_H;


      colorBorder[] = {0,0,0,0}; // Frame color
      colorPicture[] = {1,1,1,1};
      colorPictureRight[] = {1,1,1,1};
      colorPictureSelected[] = {1,1,1,1};
      colorPictureRightSelected[] = {1,1,1,1};
      colorPictureDisabled[] = {1,1,1,1};
      colorPictureRightDisabled[] = {1,1,1,1};

      colorBackground[] = {0.3,0.3,0.3,0.5}; // Fill color
      colorSelect[] = {1,0.5,0,1}; // Selected item fill color (when multiselectEnabled is 0)
      colorMarked[] = {1,0.5,0,0.5}; // Marked item fill color (when multiselectEnabled is 1)
      colorMarkedSelected[] = {1,0.5,0,1}; // Selected item fill color (when multiselectEnabled is 1)

      sizeEx = GUI_TEXT_SIZE_SMALL; // Text size
      font = GUI_FONT_NORMAL; // Font from CfgFontFamilies
      shadow = 1; // Shadow (0 - none, 1 - N/A, 2 - black outline)
      colorText[] = {1,1,1,1}; // Text color
      colorSelectText[] = {1,1,1,1}; // Selected text color (when multiselectEnabled is 0)
      colorMarkedText[] = {1,1,1,1}; // Selected text color (when multiselectEnabled is 1)

      tooltip = "CT_TREE"; // Tooltip text
      tooltipColorShade[] = {0,0,0,1}; // Tooltip background color
      tooltipColorText[] = {1,1,1,1}; // Tooltip text color
      tooltipColorBox[] = {1,1,1,1}; // Tooltip frame color

      disableKeyboardSearch = false;
      multiselectEnabled = 0; // Allow selecting multiple items while holding Ctrl or Shift
      expandOnDoubleclick = 1; // Expand/collapse item upon double-click
      hiddenTexture = "A3\ui_f\data\gui\rsccommon\rsctree\hiddenTexture_ca.paa"; // Expand icon
      expandedTexture = "A3\ui_f\data\gui\rsccommon\rsctree\expandedTexture_ca.paa"; // Collapse icon
      maxHistoryDelay = 1; // Time since last keyboard type search to reset it

      // Scrollbar configuration
      class ScrollBar
      {
        width = 0; // Unknown?
        height = 0; // Unknown?
        scrollSpeed = 0.01; // Unknown?

        arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow
        arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on
        border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa"; // Slider background (stretched vertically)
        thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa"; // Dragging element (stretched vertically)

        color[] = {1,1,1,1}; // Scrollbar color
      };

      colorDisabled[] = {0,0,0,0}; // Does nothing, but must be present, otherwise an error is shown
      colorArrow[] = {0,0,0,0}; // Does nothing, but must be present, otherwise an error is shown
/*
      onCanDestroy = "systemChat str ['onCanDestroy',_this]; true";
      onDestroy = "systemChat str ['onDestroy',_this]; false";
      onMouseEnter = "systemChat str ['onMouseEnter',_this]; false";
      onMouseExit = "systemChat str ['onMouseExit',_this]; false";
      onSetFocus = "systemChat str ['onSetFocus',_this]; false";
      onKillFocus = "systemChat str ['onKillFocus',_this]; false";
      onKeyDown = "systemChat str ['onKeyDown',_this]; false";
      onKeyUp = "systemChat str ['onKeyUp',_this]; false";
      onMouseButtonDown = "systemChat str ['onMouseButtonDown',_this]; false";
      onMouseButtonUp = "systemChat str ['onMouseButtonUp',_this]; false";
      onMouseButtonClick = "systemChat str ['onMouseButtonClick',_this]; false";
      onMouseButtonDblClick = "systemChat str ['onMouseButtonDblClick',_this]; false";
      onMouseZChanged = "systemChat str ['onMouseZChanged',_this]; false";
      onMouseMoving = "";
      onMouseHolding = "";
*/
      onTreeSelChanged = "_this call BRM_insurgency_respawn_fnc_selectSpawn; false";/*
      onTreeLButtonDown = "systemChat str ['onTreeLButtonDown',_this]; false";
      onTreeDblClick = "systemChat str ['onTreeDblClick',_this]; false";
      onTreeExpanded = "systemChat str ['onTreeExpanded',_this]; false";
      onTreeCollapsed = "systemChat str ['onTreeCollapsed',_this]; false";
      //onTreeMouseMove = "systemChat str ['onTreeMouseMove',_this]; false"; // Causing CTD
      //onTreeMouseHold = "systemChat str ['onTreeMouseHold',_this]; false"; // Causing CTD
      onTreeMouseExit = "systemChat str ['onTreeMouseExit',_this]; false";*/
    };
    class CT_INS_MAP
    {
      access = 0; // Control access (0 - ReadAndWrite, 1 - ReadAndCreate, 2 - ReadOnly, 3 - ReadOnlyVerified)
      idc = 470; // Control identification (without it, the control won't be displayed)
      duration = 10;
      type = CT_MAP_MAIN; // Type
      style = ST_PICTURE; // Style
      default = 0; // Control selected by default (only one within a display can be used)
      blinkingPeriod = 0; // Time in which control will fade out and back in. Use 0 to disable the effect.


      x = GUI_GRID_X + (40*GUI_GRID_W - 5  * GUI_GRID_W);
      y = GUI_GRID_Y + (40*GUI_GRID_H - 5  * GUI_GRID_W);
      w = 5  * GUI_GRID_W;
      h = (5  * GUI_GRID_W);


      sizeEx = GUI_GRID_CENTER_H; // Text size
      font = GUI_FONT_NORMAL; // Font from CfgFontFamilies
      colorText[] = {0,0,0,1}; // Text color

      tooltip = ""; // Tooltip text
      tooltipColorShade[] = {0,0,0,1}; // Tooltip background color
      tooltipColorText[] = {1,1,1,1}; // Tooltip text color
      tooltipColorBox[] = {1,1,1,1}; // Tooltip frame color

      moveOnEdges = 1; // Move map when cursor is near its edge. Discontinued.

      // Rendering density coefficients
      ptsPerSquareSea = 5;  // seas
      ptsPerSquareTxt = 20; // textures
      ptsPerSquareCLn = 10; // count-lines
      ptsPerSquareExp = 10; // exposure
      ptsPerSquareCost =  10; // cost

      // Rendering thresholds
      ptsPerSquareFor = 9;  // forests
      ptsPerSquareForEdge = 9;  // forest edges
      ptsPerSquareRoad =  6;  // roads
      ptsPerSquareObj = 9;  // other objects

      scaleMin = 0.001; // Min map scale (i.e., max zoom)
      scaleMax = 1.0; // Max map scale (i.e., min zoom)
      scaleDefault = 0.16; // Default scale

      alphaFadeStartScale = 0.1; // Scale at which satellite map starts appearing
      alphaFadeEndScale = 0.01; // Scale at which satellite map is fully rendered
      maxSatelliteAlpha = 0.85; // Maximum alpha of satellite map

      text = "#(argb,8,8,3)color(1,1,1,1)"; // Fill texture
      colorBackground[] = {1,1,1,1}; // Fill color

      colorOutside[] = {0,0,0,1}; // Color outside of the terrain area (not sued when procedural terrain is enabled)
      colorSea[] = {0.4,0.6,0.8,0.5}; // Sea color
      colorForest[] = {0.6,0.8,0.4,0.5}; // Forest color
      colorForestBorder[] = {0.6,0.8,0.4,1}; // Forest border color
      colorRocks[] = {0,0,0,0.3}; // Rocks color
      colorRocksBorder[] = {0,0,0,1}; // Rocks border color
      colorLevels[] = {0.3,0.2,0.1,0.5}; // Elevation number color
      colorMainCountlines[] = {0.6,0.4,0.2,0.5}; // Main countline color (every 5th)
      colorCountlines[] = {0.6,0.4,0.2,0.3}; // Countline color
      colorMainCountlinesWater[] = {0.5,0.6,0.7,0.6}; // Main water countline color (every 5th)
      colorCountlinesWater[] = {0.5,0.6,0.7,0.3}; // Water countline color
      colorPowerLines[] = {0.1,0.1,0.1,1}; // Power lines color
      colorRailWay[] = {0.8,0.2,0,1}; // Railway color
      colorNames[] = {1.1,0.1,1.1,0.9}; // Unknown?
      colorInactive[] = {1,1,0,0.5}; // Unknown?
      colorTracks[] = {0.8,0.8,0.7,0.2}; // Small road border color
      colorTracksFill[] = {0.8,0.7,0.7,1}; // Small road color
      colorRoads[] = {0.7,0.7,0.7,1}; // Medium road border color
      colorRoadsFill[] = {1,1,1,1}; // Medium road color
      colorMainRoads[] = {0.9,0.5,0.3,1}; // Large road border color
      colorMainRoadsFill[] = {1,0.6,0.4,1}; // Large road color
      colorGrid[] = {0.1,0.1,0.1,0.6}; // Grid coordinate color
      colorGridMap[] = {0.1,0.1,0.1,0.6}; // Grid line color

      fontLabel = GUI_FONT_NORMAL; // Tooltip font from CfgFontFamilies
      sizeExLabel = GUI_GRID_CENTER_H * 0.5; // Tooltip font size

      fontGrid = GUI_FONT_SYSTEM; // Grid coordinate font from CfgFontFamilies
      sizeExGrid = GUI_GRID_CENTER_H * 0.5; // Grid coordinate font size

      fontUnits = GUI_FONT_SYSTEM; // Selected group member font from CfgFontFamilies
      sizeExUnits = GUI_GRID_CENTER_H * 0.5; // Selected group member font size

      fontNames = GUI_FONT_NARROW; // Marker font from CfgFontFamilies
      sizeExNames = GUI_GRID_CENTER_H * 0.5; // Marker font size

      fontInfo = GUI_FONT_NORMAL; // Unknown?
      sizeExInfo = GUI_GRID_CENTER_H * 0.5; // Unknown?

      fontLevel = GUI_FONT_SYSTEM; // Elevation number font
      sizeExLevel = GUI_GRID_CENTER_H * 0.5; // Elevation number font size

      showCountourInterval = 1; // Show Legend

      class Task
      {
        icon = "#(argb,8,8,3)color(1,1,1,1)";
        color[] = {1,1,0,1};

        iconCreated = "#(argb,8,8,3)color(1,1,1,1)";
        colorCreated[] = {0,0,0,1};

        iconCanceled = "#(argb,8,8,3)color(1,1,1,1)";
        colorCanceled[] = {0,0,0,0.5};

        iconDone = "#(argb,8,8,3)color(1,1,1,1)";
        colorDone[] = {0,1,0,1};

        iconFailed = "#(argb,8,8,3)color(1,1,1,1)";
        colorFailed[] = {1,0,0,1};

        size = 8;
        importance = 1; // Required, but not used
        coefMin = 1; // Required, but not used
        coefMax = 1; // Required, but not used
      };
      class ActiveMarker
      {
        color[] = {0,0,0,1}; // Icon color
        size = 2; // Size in pixels
      };
      class Waypoint
      {
        coefMax = 1; // Minimum size coefficient
        coefMin = 4; // Maximum size coefficient
        color[] = {0,0,0,0}; // Icon color
        icon = "#(argb,8,8,3)color(0,0,0,1)"; // Icon texture
        importance = 1; // Drawing importance (when multiple icons are close together, the one with larger importance is prioritized)
        size = 0; // Size in pixels
      };
      class LineMarker
      {
        lineDistanceMin = 3e-005;
        lineLengthMin = 5;
        lineWidthThick = 0.014;
        lineWidthThin = 0.008;
        textureComboBoxColor = "#(argb,8,8,3)color(1,1,1,1)";
      };
      class WaypointCompleted: Waypoint{};
      class CustomMark: Waypoint{};
      class Command: Waypoint{};
      class Bush: Waypoint{};
      class Rock: Waypoint{};
      class SmallTree: Waypoint{};
      class Tree: Waypoint{};
      class BusStop: Waypoint{};
      class FuelStation: Waypoint{};
      class Hospital: Waypoint{};
      class Church: Waypoint{};
      class Lighthouse: Waypoint{};
      class Power: Waypoint{};
      class PowerSolar: Waypoint{};
      class PowerWave: Waypoint{};
      class PowerWind: Waypoint{};
      class Quay: Waypoint{};
      class Transmitter: Waypoint{};
      class Watertower: Waypoint{};
      class Cross: Waypoint{};
      class Chapel: Waypoint{};
      class Shipwreck: Waypoint{};
      class Bunker: Waypoint{};
      class Fortress: Waypoint{};
      class Fountain: Waypoint{};
      class Ruin: Waypoint{};
      class Stack: Waypoint{};
      class Tourism: Waypoint{};
      class ViewTower: Waypoint{};

    };
  };
};
