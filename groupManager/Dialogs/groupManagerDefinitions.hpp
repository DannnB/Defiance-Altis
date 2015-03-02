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
#define ST_GROUP_BOX       96
#define ST_GROUP_BOX2      112
#define ST_ROUNDED_CORNER  ST_GROUP_BOX + ST_CENTER
#define ST_ROUNDED_CORNER2 ST_GROUP_BOX2 + ST_CENTER

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

#define BG_COLOR_OCHRE 0.76,0.50,0.078
#define BG_COLOR_OCHRE_PLAIN 0.76,0.50,0.078

#define BG_COLOR_LIGHT_GREY 0.95,0.95,0.95

#define BG_COLOR_BLACK 0.1,0.1,0.1
#define BG_COLOR_WHITE 1,1,1


////////////////
//Base Classes//
////////////////

class RscTextGrMn
{
    access = 0;
    idc = -1;
    type = CT_STATIC;
    style = ST_LEFT;
    linespacing = 1;
    colorBackground[] = {BG_COLOR_OCHRE_PLAIN,0.8};
    colorText[] = {1,1,1,1};
    text = "";
    shadow = 1;
    font = "PuristaMedium";
	// 0.55 is small, 0.7 is "normal"
	SizeEx = 0.030 / ((getResolution select 5)/0.55); /*0.033*/
    fixedWidth = 0;
    x = 0;
    y = 0;
    h = 0;
    w = 0;
};

class RscPictureGrMn
{
    access = 0;
    idc = -1;
    type = CT_STATIC;
    style = ST_PICTURE;
    colorBackground[] = {BG_COLOR_BLACK,0.6};
    colorText[] = {1,1,1,1};
    font = "PuristaMedium";
    sizeEx = 0;
    lineSpacing = 0;
    text = "";
    fixedWidth = 0;
    shadow = 0;
    x = 0;
    y = 0;
    w = 0.2;
    h = 0.2;
};

class RscButtonGrMn
{  
   access = 0;
    type = CT_BUTTON;
    text = "";
    colorText[] = {1,1,1,1};
    colorDisabled[] = {0.4,0.4,0.4,0};
    colorBackground[] = {BG_COLOR_OCHRE,0.6};
    colorBackgroundDisabled[] = {0,0.0,0};
    colorBackgroundActive[] = {BG_COLOR_LIGHT_GREY,1};
    colorFocused[] = {BG_COLOR_OCHRE,0.6};
    colorShadow[] = {0.023529,0,0.0313725,1};
    colorBorder[] = {0.023529,0,0.0313725,1};
    soundEnter[] = {"\ca\ui\data\sound\onover",0.09,1};
    soundPush[] = {"\ca\ui\data\sound\new1",0,0};
    soundClick[] = {"\ca\ui\data\sound\onclick",0.07,1};
    soundEscape[] = {"\ca\ui\data\sound\onescape",0.09,1};
    style = 2;
    x = 0;
    y = 0;
    w = 0.055589;
    h = 0.039216;
    shadow = 0;
    font = "PuristaMedium";
    sizeEx = 0.030 / ((getResolution select 5)/0.55); /*0.38*/
    offsetX = 0.001;
    offsetY = 0.001;
    offsetPressedX = 0.002;
    offsetPressedY = 0.002;
    borderSize = 0;
};

class RscFrameGrMn
{
    type = CT_STATIC;
    idc = -1;
    style = ST_FRAME;
    shadow = 2;
    colorBackground[] = {BG_COLOR_WHITE,1};
    colorText[] = {1,1,1,0.9};
    font = "PuristaMedium";
    sizeEx = 0.03;
    text = "";
};

class BOXGrMn
{ 
   type = CT_STATIC;
    idc = -1;
    style = ST_CENTER;
    shadow = 2;
    colorText[] = {1,1,1,1};
    font = "PuristaMedium";
    sizeEx = 0.02;
    colorBackground[] = {BG_COLOR_BLACK,0.6};
    text = ""; 

};

class RscListBoxGrMn
{
	access = 0;
	type = 5;
	w = 0.4;
	h = 0.4;
	rowHeight = 0;
	colorText[] ={1,1,1,1};
	colorDisabled[] ={1,1,1,0.25};
	colorScrollbar[] ={1,0,0,0};
	colorSelect[] ={1,1,0,0.4};
	// Use this one for text:
    colorSelect2[] ={1,1,0,1};
	colorSelectBackground[] ={0.95,0.95,0.95,0};
	colorSelectBackground2[] ={1,1,1,0};
	colorBackground[] ={BG_COLOR_BLACK,0.5};
	soundSelect[] ={"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1};
	arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
	arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
	class ListScrollBar
	{
		color[] ={1,1,1,0.6};
		colorActive[] ={1,1,1,1};
		colorDisabled[] ={1,1,1,0.3};
		shadow = 0;
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	};
	style = 16;
	font = "PuristaMedium";
	SizeEx = 0.03 / ((getResolution select 5)/0.55);
	shadow = 0;
	colorShadow[] ={0,0,0,0.5};
	color[] ={1,1,1,1};
	period = 1.2;
	maxHistoryDelay = 1;
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
};

class RscShortcutButtonGrMn
{
	type = 16;
	x = 0.1;
	y = 0.1;
	class HitZone{left = 0; top = 0; right = 0; bottom = 0;};
	class ShortcutPos{left = 0; top = 0; w = 0; h = 0;};
	class TextPos{left = 0;
		top = 0;
		right = 0;
		bottom = 0;};
	shortcuts[] = {};
	textureNoShortcut = "#(argb,8,8,3)color(0,0,0,0)";
	color[] = {1,1,1,1};
	color2[] = {0.95, 0.95, 0.95, 1};
	colorDisabled[] = {1,1,1,0.25};
	colorBackground[] = {BG_COLOR_OCHRE,0.8};
	colorBackground2[] = {BG_COLOR_OCHRE,0.8};
	colorText[] = {1,1,1,.9};
    colorBackgroundDisabled[] = {0,0.0,0};
    colorBackgroundActive[] = {BG_COLOR_OCHRE,0.8};
	colorBackgroundFocused[] = {BG_COLOR_OCHRE,0.8};
    colorFocused[] = {1,1,1,1};
    colorShadow[] = {0.023529,0,0.0313725,1};
    colorBorder[] = {0.023529,0,0.0313725,1};
	class Attributes
	{
		font = "PuristaMedium";
		color = "#E5E5E5";
		align = "center";
		shadow = "true";
		size = "1";
	};
	idc = -1;
	style = 0;
	default = 0;
	shadow = 1;
	w = 0.1;
	h = 0.1;
	animTextureDefault = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureNormal = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureDisabled = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureOver = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\over_ca.paa";
	animTextureFocused = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\focus_ca.paa";
	animTexturePressed = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\down_ca.paa";
	periodFocus = 1.2;
	periodOver = 0.8;
	period = 0.4;
	font = "PuristaMedium";
	size = "0.030 / ((getResolution select 5)/0.55)"; /*0.38*/
	sizeEx = "1";
	text = "";
	soundEnter[] = {"\A3\ui_f\data\sound\onover",0.09,1};
	soundPush[] = {"\A3\ui_f\data\sound\new1",0,0};
	soundClick[] = {"\A3\ui_f\data\sound\onclick",0.07,1};
	soundEscape[] = {"\A3\ui_f\data\sound\onescape",0.09,1};
	action = "";
	class AttributesImage
	{
		font = "PuristaMedium";
		color = "#E5E5E5";
		align = "left";
	};
};

class RscStructuredTextGrMn
 {
 idc = -1;
 type = CT_STRUCTURED_TEXT;// defined constant
 style = ST_LEFT; // defined constant
 colorBackground[] = {BG_COLOR_BLACK,0.6};
 x = 0.1;
 y = 0.1;
 w = 0.3;
 h = 0.1;
 size = "0.03 / ((getResolution select 5)/0.55)";
 text = "Testing Testing";
	 class Attributes {
		 font = "PuristaMedium";
		 color = "#FFFFFF";
		 align = "left";
		 valign = "middle";
		 shadow = false;
		 shadowColor = "#ff0000";
		 size = "1";
	 };
 };
