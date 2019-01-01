
/*******************/
/*  Controls       */
/*******************/

// Control types
#define CT_STATIC           0
#define CT_BUTTON           1
#define CT_EDIT             2
#define CT_SLIDER           3
#define CT_COMBO            4
#define CT_LISTBOX          5
#define CT_TOOLBOX          6
#define CT_CHECKBOXES       7
#define CT_PROGRESS         8
#define CT_HTML             9
#define CT_STATIC_SKEW      10
#define CT_ACTIVETEXT       11
#define CT_TREE             12
#define CT_STRUCTURED_TEXT  13
#define CT_CONTEXT_MENU     14
#define CT_CONTROLS_GROUP   15
#define CT_SHORTCUTBUTTON   16
#define CT_HITZONES         17
#define CT_CONTROLS_TABLE   19
#define CT_XKEYDESC         40
#define CT_XBUTTON          41
#define CT_XLISTBOX         42
#define CT_XSLIDER          43
#define CT_XCOMBO           44
#define CT_ANIMATED_TEXTURE 45
#define CT_OBJECT           80
#define CT_OBJECT_ZOOM      81
#define CT_OBJECT_CONTAINER 82
#define CT_OBJECT_CONT_ANIM 83
#define CT_LINEBREAK        98
#define CT_USER             99
#define CT_MAP              100
#define CT_MAP_MAIN         101
#define CT_LISTNBOX         102
#define CT_ITEMSLOT         103
#define CT_CHECKBOX         77
#define CT_VEHICLE_DIRECTION 105

// Static styles
#define ST_POS            0x0F
#define ST_HPOS           0x03
#define ST_VPOS           0x0C
#define ST_LEFT           0x00
#define ST_RIGHT          0x01
#define ST_CENTER         0x02
#define ST_DOWN           0x04
#define ST_UP             0x08
#define ST_VCENTER        0x0C

#define ST_TYPE           0xF0
#define ST_SINGLE         0x00
#define ST_MULTI          0x10
#define ST_TITLE_BAR      0x20
#define ST_PICTURE        0x30
#define ST_FRAME          0x40
#define ST_BACKGROUND     0x50
#define ST_GROUP_BOX      0x60
#define ST_GROUP_BOX2     0x70
#define ST_HUD_BACKGROUND 0x80
#define ST_TILE_PICTURE   0x90
#define ST_WITH_RECT      0xA0
#define ST_LINE           0xB0
#define ST_UPPERCASE      0xC0
#define ST_LOWERCASE      0xD0

#define ST_SHADOW         0x100
#define ST_NO_RECT        0x200
#define ST_KEEP_ASPECT_RATIO  0x800

#define ST_TITLE          ST_TITLE_BAR + ST_CENTER

// Slider styles
#define SL_DIR            0x400
#define SL_VERT           0
#define SL_HORZ           0x400

#define SL_TEXTURES       0x10

// progress bar
#define ST_VERTICAL       0x01
#define ST_HORIZONTAL     0

// Listbox styles
#define LB_TEXTURES       0x10
#define LB_MULTI          0x20

// Tree styles
#define TR_SHOWROOT       1
#define TR_AUTOCOLLAPSE   2

// MessageBox styles
#define MB_BUTTON_OK      1
#define MB_BUTTON_CANCEL  2
#define MB_BUTTON_USER    4
#define MB_ERROR_DIALOG   8

// Xbox buttons
#define KEY_XINPUT                0x00050000

#define KEY_XBOX_A                KEY_XINPUT + 0
#define KEY_XBOX_B                KEY_XINPUT + 1
#define KEY_XBOX_X                KEY_XINPUT + 2
#define KEY_XBOX_Y                KEY_XINPUT + 3
#define KEY_XBOX_Up               KEY_XINPUT + 4
#define KEY_XBOX_Down             KEY_XINPUT + 5
#define KEY_XBOX_Left             KEY_XINPUT + 6
#define KEY_XBOX_Right            KEY_XINPUT + 7
#define KEY_XBOX_Start            KEY_XINPUT + 8
#define KEY_XBOX_Back             KEY_XINPUT + 9
#define KEY_XBOX_LeftBumper       KEY_XINPUT + 10
#define KEY_XBOX_RightBumper      KEY_XINPUT + 11
#define KEY_XBOX_LeftTrigger      KEY_XINPUT + 12
#define KEY_XBOX_RightTrigger     KEY_XINPUT + 13
#define KEY_XBOX_LeftThumb        KEY_XINPUT + 14
#define KEY_XBOX_RightThumb       KEY_XINPUT + 15
#define KEY_XBOX_LeftThumbXRight  KEY_XINPUT + 16
#define KEY_XBOX_LeftThumbYUp     KEY_XINPUT + 17
#define KEY_XBOX_RightThumbXRight KEY_XINPUT + 18
#define KEY_XBOX_RightThumbYUp    KEY_XINPUT + 19
#define KEY_XBOX_LeftThumbXLeft   KEY_XINPUT + 20
#define KEY_XBOX_LeftThumbYDown   KEY_XINPUT + 21
#define KEY_XBOX_RightThumbXLeft  KEY_XINPUT + 22
#define KEY_XBOX_RightThumbYDown  KEY_XINPUT + 23

///////////////////////////////////////////////////////////////////////////
/// GUI
///////////////////////////////////////////////////////////////////////////

//--- Hack to avoid too large display upon first startup (fixed in engine)
//#define GUI_GRID_OLD_WAbs		((safezoneW / ((floor (safezoneW / safezoneH)) max 1)) min 1.2)


//--- New grid for new A3 displays
#define GUI_GRID_WAbs			((safezoneW / safezoneH) min 1.2)
#define GUI_GRID_HAbs			(GUI_GRID_WAbs / 1.2)
#define GUI_GRID_W			(safezoneWAbs / 40)
#define GUI_GRID_H			(safezoneH / 25)
#define GUI_GRID_X			(safezoneXAbs)
#define GUI_GRID_Y			(safezoneY)
//
#define GUI_CTRL_W			(GUI_GRID_W)
#define GUI_CTRL_H			(GUI_GRID_H)
#define GUI_CTRL_X			(safezoneX)
#define GUI_CTRL_Y			(safezoneY)

//--- Screen Center
#define GUI_GRID_CENTER_WAbs		GUI_GRID_WAbs
#define GUI_GRID_CENTER_HAbs		GUI_GRID_HAbs
#define GUI_GRID_CENTER_W		GUI_GRID_W
#define GUI_GRID_CENTER_H		GUI_GRID_H
#define GUI_GRID_CENTER_X		(safezoneX + (safezoneW - GUI_GRID_CENTER_WAbs)/2)
#define GUI_GRID_CENTER_Y		(safezoneY + (safezoneH - GUI_GRID_CENTER_HAbs)/2)

//--- Bottom center position (used by Revive UI)
#define GUI_GRID_CENTER_BOTTOM_WAbs		GUI_GRID_WAbs
#define GUI_GRID_CENTER_BOTTOM_HAbs		GUI_GRID_HAbs
#define GUI_GRID_CENTER_BOTTOM_W		GUI_GRID_W
#define GUI_GRID_CENTER_BOTTOM_H		GUI_GRID_H
#define GUI_GRID_CENTER_BOTTOM_X		(safezoneX + (safezoneW - GUI_GRID_CENTER_WAbs)/2)
#define GUI_GRID_CENTER_BOTTOM_Y		(safezoneY + safezoneH - GUI_GRID_CENTER_HAbs)

//--- Screen Top Center
#define GUI_GRID_TOPCENTER_WAbs		GUI_GRID_WAbs
#define GUI_GRID_TOPCENTER_HAbs		GUI_GRID_HAbs
#define GUI_GRID_TOPCENTER_W		GUI_GRID_W
#define GUI_GRID_TOPCENTER_H		GUI_GRID_H
#define GUI_GRID_TOPCENTER_X		GUI_GRID_CENTER_X
#define GUI_GRID_TOPCENTER_Y		safezoneY

//--- Screen Bottom Center
#define GUI_GRID_BOTTOMCENTER_WAbs	GUI_GRID_WAbs
#define GUI_GRID_BOTTOMCENTER_HAbs	GUI_GRID_HAbs
#define GUI_GRID_BOTTOMCENTER_W		GUI_GRID_W
#define GUI_GRID_BOTTOMCENTER_H		GUI_GRID_H
#define GUI_GRID_BOTTOMCENTER_X		GUI_GRID_CENTER_X
#define GUI_GRID_BOTTOMCENTER_Y		GUI_GRID_Y


//--- Top left
#define GUI_GRID_TOPLEFT_WAbs		GUI_GRID_WAbs
#define GUI_GRID_TOPLEFT_HAbs		GUI_GRID_HAbs
#define GUI_GRID_TOPLEFT_W		GUI_GRID_W
#define GUI_GRID_TOPLEFT_H		GUI_GRID_H
#define GUI_GRID_TOPLEFT_X		(safezoneX)
#define GUI_GRID_TOPLEFT_Y		(safezoneY)

//--- Bottom left
#define GUI_GRID_BOTTOM_X		(safezoneW)
#define GUI_GRID_BOTTOM_Y		(safezoneH)
#define GUI_GRID_TOTAL_W		(safezoneW)
#define GUI_GRID_TOTAL_H		(safezoneH)


///////////////////////////////////////////////////////////////////////////
/// Text Sizes
///////////////////////////////////////////////////////////////////////////
//MUF - text sizes are using new grid (40/25)
#define GUI_TEXT_SIZE_SMALL		(GUI_GRID_H * 0.8)
#define GUI_TEXT_SIZE_MEDIUM		(GUI_GRID_H * 1)
#define GUI_TEXT_SIZE_LARGE		(GUI_GRID_H * 1.2)

#define IGUI_TEXT_SIZE_MEDIUM		(GUI_GRID_H * 0.8)


///////////////////////////////////////////////////////////////////////////
/// Fonts
///////////////////////////////////////////////////////////////////////////

//Changed by MUF - TODO: set proper fonts when available - PREPARED FOR FONT CHANGE (was Zeppelin32Mono, changed to Purista/Etelka)

//GUI_FONT_MONO - used for optics active parts
//GUI_FONT_BOLD - used for titles
#define GUI_FONT_NORMAL			RobotoCondensed
#define GUI_FONT_BOLD			RobotoCondensedBold
#define GUI_FONT_THIN			RobotoCondensedLight
#define GUI_FONT_MONO			EtelkaMonospacePro
#define GUI_FONT_NARROW			EtelkaNarrowMediumPro

#define GUI_FONT_CODE			LucidaConsoleB	//Deprecated - for engine debug only (has only two sizes, which causes errors).
#define GUI_FONT_SYSTEM			TahomaB		//Deprecated - for engine debug only (has only one size, which causes errors).

//Font used by the engine as default when defined font (e.g. in description.ext) is not found
class DefaultFont
{
	font = GUI_FONT_NORMAL;
};


///////////////////////////////////////////////////////////////////////////
/// Sizes
///////////////////////////////////////////////////////////////////////////


/*

//dimension of bitmaps to be mapped 1:1 in 720p
#define w16 0.0196078
#define h16 0.0261438

#define w32 0.0392157
#define h32 0.0522876

#define w64 0.0784314
#define h64 0.1045752

#define w128 0.1568627
#define h128 0.2091503

#define w256 0.3137255
#define h256 0.4183007

#define w512 0.6274510
#define h512 0.8366013

#define w1024 1.2549020
#define h1024 1.6732026

#define w2048 2.5098039
#define h2048 3.3464052
*/
/*
class RscText;
class RscButton;
class RscEdit;
class RscListbox;
class RscButtonMenuOK;
class RscButtonMenuCancel;
class RscSlider;
class RscStructuredText;
class RscCombo;
class RscFrame;
class RscButtonMenu;
class RscCheckBox;
class RscTextCheckBox;
*/